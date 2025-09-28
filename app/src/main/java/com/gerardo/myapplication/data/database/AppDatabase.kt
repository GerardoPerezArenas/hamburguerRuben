package com.gerardo.myapplication.data.database

import android.content.Context
import androidx.room.Database
import androidx.room.Room
import androidx.room.RoomDatabase
import androidx.room.TypeConverters
import androidx.sqlite.db.SupportSQLiteDatabase
import com.gerardo.myapplication.data.dao.*
import com.gerardo.myapplication.data.entities.*
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.launch

@Database(
    entities = [User::class, Zone::class, Table::class, Family::class, Product::class],
    version = 1,
    exportSchema = false
)
@TypeConverters(Converters::class)
abstract class AppDatabase : RoomDatabase() {
    abstract fun userDao(): UserDao
    abstract fun zoneDao(): ZoneDao
    abstract fun tableDao(): TableDao
    abstract fun familyDao(): FamilyDao
    abstract fun productDao(): ProductDao

    companion object {
        @Volatile
        private var INSTANCE: AppDatabase? = null

        fun getDatabase(context: Context): AppDatabase {
            return INSTANCE ?: synchronized(this) {
                val instance = Room.databaseBuilder(
                    context.applicationContext,
                    AppDatabase::class.java,
                    "retroburger_clean_db"
                )
                    .fallbackToDestructiveMigration()
                    .addCallback(DatabaseCallback())
                    .build()
                INSTANCE = instance
                instance
            }
        }

        private class DatabaseCallback : RoomDatabase.Callback() {
            override fun onCreate(db: SupportSQLiteDatabase) {
                super.onCreate(db)
                INSTANCE?.let { database ->
                    CoroutineScope(Dispatchers.IO).launch {
                        seedAll(database)
                    }
                }
            }
        }

        private suspend fun seedAll(database: AppDatabase) {
            // Seed usuarios
            val users = listOf(
                User("admin", "1234", "ADMIN"),
                User("gerardo", "1234", "CAMARERO")
            )
            database.userDao().insertUsers(users)

            // Seed zonas
            val now = System.currentTimeMillis()
            val zones = listOf(
                Zone(name = "Comedor", sortOrder = 0, createdAt = now),
                Zone(name = "Barra", sortOrder = 1, createdAt = now),
                Zone(name = "Para llevar", sortOrder = 2, createdAt = now)
            )
            database.zoneDao().insertZones(zones)

            // Seed mesas
            val comedor = database.zoneDao().getByName("Comedor")
            val barra = database.zoneDao().getByName("Barra")
            val tables = mutableListOf<Table>()
            comedor?.let { z ->
                for (n in 1..8) tables.add(Table(zoneId = z.id, number = n, status = TableStatus.LIBRE, updatedAt = now))
            }
            barra?.let { z ->
                for (n in 1..12) tables.add(Table(zoneId = z.id, number = n, status = TableStatus.LIBRE, updatedAt = now))
            }
            if (tables.isNotEmpty()) database.tableDao().upsertAll(tables)

            // Seed familias y productos
            val comidas = Family(name = "COMIDAS", type = FamilyType.COMIDA, sortOrder = 0)
            val bebidas = Family(name = "BEBIDAS", type = FamilyType.BEBIDA, sortOrder = 1)
            database.familyDao().insertFamilies(listOf(comidas, bebidas))

            val comidasDb = database.familyDao().getByName("COMIDAS")
            val bebidasDb = database.familyDao().getByName("BEBIDAS")
            val products = mutableListOf<Product>()

            comidasDb?.let { f ->
                products.addAll(listOf(
                    Product(familyId = f.id, name = "Hamburguesa", priceCents = 850, printerRoute = PrinterRoute.COCINA, sortOrder = 0),
                    Product(familyId = f.id, name = "Patatas", priceCents = 300, printerRoute = PrinterRoute.COCINA, sortOrder = 1),
                    Product(familyId = f.id, name = "Cheeseburger", priceCents = 950, allergens = "lactosa, gluten", printerRoute = PrinterRoute.COCINA, sortOrder = 2),
                    Product(familyId = f.id, name = "Bacon Burger", priceCents = 1050, allergens = "gluten", printerRoute = PrinterRoute.COCINA, sortOrder = 3),
                    Product(familyId = f.id, name = "Ensalada", priceCents = 700, printerRoute = PrinterRoute.COCINA, sortOrder = 4),
                    Product(familyId = f.id, name = "Nuggets", priceCents = 450, allergens = "gluten", printerRoute = PrinterRoute.COCINA, sortOrder = 5)
                ))
            }

            bebidasDb?.let { f ->
                products.addAll(listOf(
                    Product(familyId = f.id, name = "Cerveza", priceCents = 250, printerRoute = PrinterRoute.BAR, sortOrder = 0),
                    Product(familyId = f.id, name = "Refresco", priceCents = 200, printerRoute = PrinterRoute.BAR, sortOrder = 1),
                    Product(familyId = f.id, name = "Agua", priceCents = 150, printerRoute = PrinterRoute.BAR, sortOrder = 2),
                    Product(familyId = f.id, name = "Café", priceCents = 180, printerRoute = PrinterRoute.BAR, sortOrder = 3),
                    Product(familyId = f.id, name = "Té", priceCents = 180, printerRoute = PrinterRoute.BAR, sortOrder = 4),
                    Product(familyId = f.id, name = "Zumo", priceCents = 220, printerRoute = PrinterRoute.BAR, sortOrder = 5)
                ))
            }

            if (products.isNotEmpty()) database.productDao().insertProducts(products)
        }
    }
}
