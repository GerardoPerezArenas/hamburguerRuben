package com.gerardo.myapplication.data.entities

import androidx.room.Entity
import androidx.room.Index
import androidx.room.PrimaryKey
import androidx.room.ForeignKey

@Entity(
    tableName = "tables",
    indices = [
        Index(value = ["zoneId"]),
        Index(value = ["zoneId", "number"], unique = true)
    ],
    foreignKeys = [
        ForeignKey(
            entity = Zone::class,
            parentColumns = ["id"],
            childColumns = ["zoneId"],
            onDelete = ForeignKey.CASCADE
        )
    ]
)
data class Table(
    @PrimaryKey(autoGenerate = true) val id: Int = 0,
    val zoneId: Int,
    val number: Int,
    val status: TableStatus = TableStatus.LIBRE,
    val updatedAt: Long = System.currentTimeMillis()
)

enum class TableStatus {
    LIBRE,
    CON_PEDIDO
}
