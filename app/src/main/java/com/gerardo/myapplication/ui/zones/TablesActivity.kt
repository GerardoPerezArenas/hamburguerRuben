package com.gerardo.myapplication.ui.zones

import android.os.Bundle
import android.widget.TextView
import androidx.appcompat.app.AppCompatActivity
import androidx.lifecycle.Lifecycle
import androidx.lifecycle.lifecycleScope
import androidx.lifecycle.repeatOnLifecycle
import androidx.recyclerview.widget.GridLayoutManager
import androidx.recyclerview.widget.RecyclerView
import com.gerardo.myapplication.R
import com.gerardo.myapplication.data.database.AppDatabase
import com.gerardo.myapplication.data.entities.Table
import com.gerardo.myapplication.data.entities.TableStatus
import kotlinx.coroutines.flow.collectLatest
import kotlinx.coroutines.launch

class TablesActivity : AppCompatActivity() {
    private lateinit var adapter: TablesAdapter

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_tables)

        val zoneId = intent.getIntExtra("zoneId", -1)
        val zoneName = intent.getStringExtra("zoneName") ?: ""

        // Título y flecha Up
        supportActionBar?.title = getString(R.string.tables_title) + " / " + zoneName
        supportActionBar?.setDisplayHomeAsUpEnabled(true)

        // Configurar RecyclerView
        val rv = findViewById<RecyclerView>(R.id.rvTables)
        rv.layoutManager = GridLayoutManager(this, 4)
        adapter = TablesAdapter { table ->
            // TODO: abrir detalle de mesa para T5
        }
        rv.adapter = adapter

        // Observar mesas de esta zona
        if (zoneId > 0) {
            val tableDao = AppDatabase.getDatabase(this).tableDao()
            lifecycleScope.launch {
                repeatOnLifecycle(Lifecycle.State.STARTED) {
                    tableDao.getTablesByZone(zoneId).collectLatest { tables ->
                        adapter.submit(tables)
                    }
                }
            }
        }
    }

    override fun onSupportNavigateUp(): Boolean {
        finish()
        return true
    }
}

private class TablesAdapter(
    private val onClick: (Table) -> Unit
) : RecyclerView.Adapter<TableViewHolder>() {
    private val items = mutableListOf<Table>()

    fun submit(newItems: List<Table>) {
        items.clear()
        items.addAll(newItems)
        notifyDataSetChanged()
    }

    override fun onCreateViewHolder(parent: android.view.ViewGroup, viewType: Int): TableViewHolder {
        val view = android.view.LayoutInflater.from(parent.context)
            .inflate(R.layout.item_table, parent, false)
        return TableViewHolder(view)
    }

    override fun getItemCount(): Int = items.size

    override fun onBindViewHolder(holder: TableViewHolder, position: Int) {
        holder.bind(items[position], onClick)
    }
}

private class TableViewHolder(itemView: android.view.View) : RecyclerView.ViewHolder(itemView) {
    private val tvNumber = itemView.findViewById<android.widget.TextView>(R.id.tvNumber)

    fun bind(table: Table, onClick: (Table) -> Unit) {
        tvNumber.text = table.number.toString()

        val color = when (table.status) {
            TableStatus.LIBRE -> itemView.context.getColor(R.color.table_free)
            TableStatus.CON_PEDIDO -> itemView.context.getColor(R.color.table_busy)
        }
        itemView.setBackgroundColor(color)

        itemView.setOnClickListener { onClick(table) }
    }
}
