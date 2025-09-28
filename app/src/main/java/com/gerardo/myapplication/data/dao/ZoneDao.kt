package com.gerardo.myapplication.data.dao

import androidx.room.Dao
import androidx.room.Insert
import androidx.room.OnConflictStrategy
import androidx.room.Query
import com.gerardo.myapplication.data.entities.Zone
import kotlinx.coroutines.flow.Flow

@Dao
interface ZoneDao {
    @Insert(onConflict = OnConflictStrategy.REPLACE)
    suspend fun insertZones(zones: List<Zone>)

    @Query("SELECT * FROM zones ORDER BY sortOrder ASC, name ASC")
    fun getAllZones(): Flow<List<Zone>>

    @Query("SELECT * FROM zones WHERE active = 1 ORDER BY sortOrder ASC, name ASC")
    fun getActiveZones(): Flow<List<Zone>>

    @Query("SELECT * FROM zones WHERE id = :id LIMIT 1")
    suspend fun getById(id: Int): Zone?

    @Query("SELECT * FROM zones WHERE name = :name LIMIT 1")
    suspend fun getByName(name: String): Zone?
}
