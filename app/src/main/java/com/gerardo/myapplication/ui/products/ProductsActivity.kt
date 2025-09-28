package com.gerardo.myapplication.ui.products

import android.os.Bundle
import androidx.appcompat.app.AppCompatActivity
import androidx.lifecycle.Lifecycle
import androidx.lifecycle.lifecycleScope
import androidx.lifecycle.repeatOnLifecycle
import androidx.recyclerview.widget.LinearLayoutManager
import androidx.recyclerview.widget.RecyclerView
import com.gerardo.myapplication.R
import com.gerardo.myapplication.data.database.AppDatabase
import com.gerardo.myapplication.data.entities.FamilyType
import com.gerardo.myapplication.data.entities.Product
import com.google.android.material.button.MaterialButton
import com.google.android.material.button.MaterialButtonToggleGroup
import kotlinx.coroutines.flow.collectLatest
import kotlinx.coroutines.launch

class ProductsActivity : AppCompatActivity() {
    private lateinit var adapter: ProductsAdapter

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_products)

        supportActionBar?.title = getString(R.string.app_name) + " - Carta"
        supportActionBar?.setDisplayHomeAsUpEnabled(true)

        val toggle = findViewById<MaterialButtonToggleGroup>(R.id.toggleGroup)
        val btnComida = findViewById<MaterialButton>(R.id.btnComida)
        val btnBebida = findViewById<MaterialButton>(R.id.btnBebida)
        val rv = findViewById<RecyclerView>(R.id.rvProducts)

        rv.layoutManager = LinearLayoutManager(this)
        adapter = ProductsAdapter()
        rv.adapter = adapter

        var currentType = FamilyType.COMIDA
        btnComida.isChecked = true

        fun load(type: FamilyType) {
            val dao = AppDatabase.getDatabase(this).productDao()
            lifecycleScope.launch {
                repeatOnLifecycle(Lifecycle.State.STARTED) {
                    dao.getActiveProductsByFamilyType(type).collectLatest { list ->
                        adapter.submit(list)
                    }
                }
            }
        }

        toggle.addOnButtonCheckedListener { _, checkedId, isChecked ->
            if (!isChecked) return@addOnButtonCheckedListener
            currentType = if (checkedId == R.id.btnComida) FamilyType.COMIDA else FamilyType.BEBIDA
            load(currentType)
        }

        load(currentType)
    }

    override fun onSupportNavigateUp(): Boolean {
        finish()
        return true
    }
}

private class ProductsAdapter : RecyclerView.Adapter<ProductVH>() {
    private val items = mutableListOf<Product>()
    fun submit(newItems: List<Product>) {
        items.clear(); items.addAll(newItems); notifyDataSetChanged()
    }
    override fun onCreateViewHolder(parent: android.view.ViewGroup, viewType: Int): ProductVH {
        val v = android.view.LayoutInflater.from(parent.context).inflate(R.layout.item_product, parent, false)
        return ProductVH(v)
    }
    override fun getItemCount(): Int = items.size
    override fun onBindViewHolder(holder: ProductVH, position: Int) = holder.bind(items[position])
}

private class ProductVH(itemView: android.view.View) : RecyclerView.ViewHolder(itemView) {
    private val name = itemView.findViewById<android.widget.TextView>(R.id.tvName)
    private val price = itemView.findViewById<android.widget.TextView>(R.id.tvPrice)
    private val allergens = itemView.findViewById<android.widget.TextView>(R.id.tvAllergens)
    fun bind(p: Product) {
        name.text = p.name
        price.text = String.format("%.2f €", p.priceCents / 100.0)
        if (p.allergens.isNullOrBlank()) {
            allergens.visibility = android.view.View.GONE
        } else {
            allergens.visibility = android.view.View.VISIBLE
            allergens.text = p.allergens
        }
    }
}
