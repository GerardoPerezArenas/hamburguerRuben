package com.gerardo.myapplication.data.db

import androidx.room.migration.Migration
import androidx.sqlite.db.SupportSQLiteDatabase

object Migrations {
    val MIGRATION_1_2 = object : Migration(1, 2) {
        override fun migrate(database: SupportSQLiteDatabase) {
            database.execSQL(
                """
                CREATE TABLE IF NOT EXISTS zones (
                    id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
                    name TEXT NOT NULL,
                    active INTEGER NOT NULL DEFAULT 1,
                    sortOrder INTEGER NOT NULL DEFAULT 0,
                    createdAt INTEGER NOT NULL
                )
                """.trimIndent()
            )
            database.execSQL(
                "CREATE UNIQUE INDEX IF NOT EXISTS index_zones_name ON zones (name)"
            )
            // Seed por defecto
            val now = System.currentTimeMillis()
            database.execSQL("INSERT OR IGNORE INTO zones(name, active, sortOrder, createdAt) VALUES('Comedor', 1, 0, $now)")
            database.execSQL("INSERT OR IGNORE INTO zones(name, active, sortOrder, createdAt) VALUES('Bar', 1, 1, $now)")
            database.execSQL("INSERT OR IGNORE INTO zones(name, active, sortOrder, createdAt) VALUES('Barra', 1, 2, $now)")
            database.execSQL("INSERT OR IGNORE INTO zones(name, active, sortOrder, createdAt) VALUES('Para llevar', 1, 3, $now)")
        }
    }

    val MIGRATION_2_3 = object : Migration(2, 3) {
        override fun migrate(database: SupportSQLiteDatabase) {
            // Eliminar la zona "Bar"
            database.execSQL("DELETE FROM zones WHERE name = 'Bar'")
        }
    }

    val MIGRATION_3_4 = object : Migration(3, 4) {
        override fun migrate(database: SupportSQLiteDatabase) {
            database.execSQL(
                """
                CREATE TABLE IF NOT EXISTS tables (
                    id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
                    zoneId INTEGER NOT NULL,
                    number INTEGER NOT NULL,
                    status TEXT NOT NULL,
                    updatedAt INTEGER NOT NULL,
                    FOREIGN KEY(zoneId) REFERENCES zones(id) ON DELETE CASCADE
                )
                """.trimIndent()
            )
            database.execSQL(
                "CREATE UNIQUE INDEX IF NOT EXISTS index_tables_zoneId_number ON tables (zoneId, number)"
            )

            fun getZoneId(name: String): Int? {
                val cursor = database.query("SELECT id FROM zones WHERE name = '$name' LIMIT 1")
                return cursor.use {
                    if (it.moveToFirst()) it.getInt(0) else null
                }
            }

            val now = System.currentTimeMillis()
            val comedorId = getZoneId("Comedor")
            val barraId = getZoneId("Barra")

            comedorId?.let { zid ->
                for (n in 1..8) {
                    database.execSQL("INSERT OR IGNORE INTO tables(zoneId, number, status, updatedAt) VALUES($zid, $n, 'LIBRE', $now)")
                }
            }
            barraId?.let { zid ->
                for (n in 1..12) {
                    database.execSQL("INSERT OR IGNORE INTO tables(zoneId, number, status, updatedAt) VALUES($zid, $n, 'LIBRE', $now)")
                }
            }
        }
    }

    val MIGRATION_4_5 = object : Migration(4, 5) {
        override fun migrate(database: SupportSQLiteDatabase) {
            database.execSQL(
                """
                CREATE TABLE IF NOT EXISTS families (
                    id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
                    name TEXT NOT NULL,
                    type TEXT NOT NULL,
                    active INTEGER NOT NULL DEFAULT 1,
                    sortOrder INTEGER NOT NULL DEFAULT 0
                )
                """.trimIndent()
            )
            database.execSQL("CREATE UNIQUE INDEX IF NOT EXISTS index_families_name ON families (name)")

            database.execSQL(
                """
                CREATE TABLE IF NOT EXISTS products (
                    id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
                    familyId INTEGER NOT NULL,
                    name TEXT NOT NULL,
                    priceCents INTEGER NOT NULL,
                    allergens TEXT,
                    printerRoute TEXT NOT NULL,
                    active INTEGER NOT NULL DEFAULT 1,
                    sortOrder INTEGER NOT NULL DEFAULT 0,
                    FOREIGN KEY(familyId) REFERENCES families(id) ON DELETE CASCADE
                )
                """.trimIndent()
            )
            database.execSQL("CREATE UNIQUE INDEX IF NOT EXISTS index_products_familyId_name ON products (familyId, name)")

            // Seed mínimo
            database.execSQL("INSERT OR IGNORE INTO families(name, type, active, sortOrder) VALUES('COMIDAS', 'COMIDA', 1, 0)")
            database.execSQL("INSERT OR IGNORE INTO families(name, type, active, sortOrder) VALUES('BEBIDAS', 'BEBIDA', 1, 1)")

            fun famId(name: String): Int? {
                val c = database.query("SELECT id FROM families WHERE name = '$name' LIMIT 1")
                return c.use { if (it.moveToFirst()) it.getInt(0) else null }
            }
            val comidasId = famId("COMIDAS")
            val bebidasId = famId("BEBIDAS")
            comidasId?.let { fid ->
                database.execSQL("INSERT OR IGNORE INTO products(familyId, name, priceCents, printerRoute, active, sortOrder) VALUES($fid, 'Hamburguesa', 850, 'COCINA', 1, 0)")
                database.execSQL("INSERT OR IGNORE INTO products(familyId, name, priceCents, printerRoute, active, sortOrder) VALUES($fid, 'Patatas', 300, 'COCINA', 1, 1)")
            }
            bebidasId?.let { fid ->
                database.execSQL("INSERT OR IGNORE INTO products(familyId, name, priceCents, printerRoute, active, sortOrder) VALUES($fid, 'Cerveza', 250, 'BAR', 1, 0)")
                database.execSQL("INSERT OR IGNORE INTO products(familyId, name, priceCents, printerRoute, active, sortOrder) VALUES($fid, 'Refresco', 200, 'BAR', 1, 1)")
            }
        }
    }

    val MIGRATION_5_6 = object : Migration(5, 6) {
        override fun migrate(database: SupportSQLiteDatabase) {
            fun famId(name: String): Int? {
                val c = database.query("SELECT id FROM families WHERE name = '$name' LIMIT 1")
                return c.use { if (it.moveToFirst()) it.getInt(0) else null }
            }
            val comidasId = famId("COMIDAS")
            val bebidasId = famId("BEBIDAS")

            comidasId?.let { fid ->
                database.execSQL("INSERT OR IGNORE INTO products(familyId, name, priceCents, allergens, printerRoute, active, sortOrder) VALUES($fid, 'Cheeseburger', 950, 'lactosa, gluten', 'COCINA', 1, 2)")
                database.execSQL("INSERT OR IGNORE INTO products(familyId, name, priceCents, allergens, printerRoute, active, sortOrder) VALUES($fid, 'Bacon Burger', 1050, 'gluten', 'COCINA', 1, 3)")
                database.execSQL("INSERT OR IGNORE INTO products(familyId, name, priceCents, allergens, printerRoute, active, sortOrder) VALUES($fid, 'Ensalada', 700, null, 'COCINA', 1, 4)")
                database.execSQL("INSERT OR IGNORE INTO products(familyId, name, priceCents, allergens, printerRoute, active, sortOrder) VALUES($fid, 'Nuggets', 450, 'gluten', 'COCINA', 1, 5)")
            }
            bebidasId?.let { fid ->
                database.execSQL("INSERT OR IGNORE INTO products(familyId, name, priceCents, allergens, printerRoute, active, sortOrder) VALUES($fid, 'Agua', 150, null, 'BAR', 1, 2)")
                database.execSQL("INSERT OR IGNORE INTO products(familyId, name, priceCents, allergens, printerRoute, active, sortOrder) VALUES($fid, 'Café', 180, null, 'BAR', 1, 3)")
                database.execSQL("INSERT OR IGNORE INTO products(familyId, name, priceCents, allergens, printerRoute, active, sortOrder) VALUES($fid, 'Té', 180, null, 'BAR', 1, 4)")
                database.execSQL("INSERT OR IGNORE INTO products(familyId, name, priceCents, allergens, printerRoute, active, sortOrder) VALUES($fid, 'Zumo', 220, null, 'BAR', 1, 5)")
            }
        }
    }
}
