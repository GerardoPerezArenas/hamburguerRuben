package com.gerardo.myapplication.data.dao

import androidx.room.Dao
import androidx.room.Insert
import androidx.room.OnConflictStrategy
import androidx.room.Query
import com.gerardo.myapplication.data.entities.Family
import com.gerardo.myapplication.data.entities.FamilyType
import kotlinx.coroutines.flow.Flow

@Dao
interface FamilyDao {
    @Insert(onConflict = OnConflictStrategy.REPLACE)
    suspend fun insertFamilies(families: List<Family>)

    @Query("SELECT * FROM families WHERE active = 1 AND type = :type ORDER BY sortOrder, name")
    fun getActiveFamiliesByType(type: FamilyType): Flow<List<Family>>

    @Query("SELECT * FROM families WHERE name = :name LIMIT 1")
    suspend fun getByName(name: String): Family?
}
