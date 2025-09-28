package com.gerardo.myapplication.ui.zones

import android.content.Intent
import android.os.Bundle
import android.view.ViewGroup
import android.widget.LinearLayout
import androidx.appcompat.app.AppCompatActivity
import androidx.core.view.setPadding
import androidx.lifecycle.Lifecycle
import androidx.lifecycle.lifecycleScope
import androidx.lifecycle.repeatOnLifecycle
import com.gerardo.myapplication.R
import com.gerardo.myapplication.data.database.AppDatabase
import com.gerardo.myapplication.ui.products.ProductsActivity
import com.google.android.material.button.MaterialButton
import kotlinx.coroutines.flow.collectLatest
import kotlinx.coroutines.launch

class ZonesActivity : AppCompatActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_zones)

        // Título y flecha Up
        supportActionBar?.title = getString(R.string.zones_title)
        supportActionBar?.setDisplayHomeAsUpEnabled(true)

        val btnCarta = findViewById<android.widget.Button>(R.id.btnCarta)
        btnCarta.setOnClickListener {
            startActivity(Intent(this, ProductsActivity::class.java))
        }

        val container = findViewById<LinearLayout>(R.id.zoneContainer)
        val dao = AppDatabase.getDatabase(this).zoneDao()

        lifecycleScope.launch {
            repeatOnLifecycle(Lifecycle.State.STARTED) {
                dao.getActiveZones().collectLatest { zones ->
                    container.removeAllViews()
                    zones.forEach { zone ->
                        val btn = MaterialButton(this@ZonesActivity, null, com.google.android.material.R.attr.materialButtonOutlinedStyle).apply {
                            layoutParams = LinearLayout.LayoutParams(
                                ViewGroup.LayoutParams.MATCH_PARENT,
                                ViewGroup.LayoutParams.WRAP_CONTENT
                            ).also { lp ->
                                lp.topMargin = resources.getDimensionPixelSize(R.dimen.spacing_md)
                            }
                            text = zone.name
                            setPadding(resources.getDimensionPixelSize(R.dimen.spacing_md))
                            setOnClickListener {
                                val i = Intent(this@ZonesActivity, TablesActivity::class.java)
                                i.putExtra("zoneId", zone.id)
                                i.putExtra("zoneName", zone.name)
                                startActivity(i)
                            }
                        }
                        container.addView(btn)
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
