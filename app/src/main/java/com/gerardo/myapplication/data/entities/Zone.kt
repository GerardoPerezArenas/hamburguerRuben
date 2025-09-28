package com.gerardo.myapplication.data.entities

import androidx.room.Entity
import androidx.room.Index
import androidx.room.PrimaryKey

@Entity(
    tableName = "zones",
    indices = [Index(value = ["name"], unique = true)]
)
data class Zone(
    @PrimaryKey(autoGenerate = true) val id: Int = 0,
    val name: String,
    val active: Boolean = true,
    val sortOrder: Int = 0,
    val createdAt: Long = System.currentTimeMillis()
)
