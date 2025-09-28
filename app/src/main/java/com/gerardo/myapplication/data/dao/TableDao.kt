package com.gerardo.myapplication.data.dao

import androidx.room.Dao
import androidx.room.Query
import androidx.room.Upsert
import com.gerardo.myapplication.data.entities.Table
import com.gerardo.myapplication.data.entities.TableStatus
import kotlinx.coroutines.flow.Flow

@Dao
interface TableDao {
    @Upsert
    suspend fun upsertAll(tables: List<Table>)

    @Query("SELECT * FROM tables WHERE zoneId = :zoneId ORDER BY number ASC")
    fun getTablesByZone(zoneId: Int): Flow<List<Table>>

    @Query("UPDATE tables SET status = :status, updatedAt = :updatedAt WHERE id = :id")
    suspend fun updateStatus(id: Int, status: TableStatus, updatedAt: Long = System.currentTimeMillis())
}
