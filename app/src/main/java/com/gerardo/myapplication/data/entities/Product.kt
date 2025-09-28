package com.gerardo.myapplication.data.entities

import androidx.room.Entity
import androidx.room.Index
import androidx.room.PrimaryKey

@Entity(
    tableName = "families",
    indices = [Index(value = ["name"], unique = true)]
)
data class Family(
    @PrimaryKey(autoGenerate = true) val id: Int = 0,
    val name: String,
    val type: FamilyType,
    val active: Boolean = true,
    val sortOrder: Int = 0
)

enum class FamilyType { COMIDA, BEBIDA }

enum class PrinterRoute { BAR, COCINA }

@Entity(
    tableName = "products",
    indices = [Index(value = ["familyId", "name"], unique = true)]
)
data class Product(
    @PrimaryKey(autoGenerate = true) val id: Int = 0,
    val familyId: Int,
    val name: String,
    val priceCents: Int,
    val allergens: String? = null,
    val printerRoute: PrinterRoute = PrinterRoute.COCINA,
    val active: Boolean = true,
    val sortOrder: Int = 0
)
