package com.gerardo.myapplication.data.dao

import androidx.room.Dao
import androidx.room.Insert
import androidx.room.OnConflictStrategy
import androidx.room.Query
import com.gerardo.myapplication.data.entities.FamilyType
import com.gerardo.myapplication.data.entities.Product
import kotlinx.coroutines.flow.Flow

@Dao
interface ProductDao {
    @Insert(onConflict = OnConflictStrategy.REPLACE)
    suspend fun insertProducts(products: List<Product>)

    @Query("""
        SELECT p.* FROM products p
        INNER JOIN families f ON f.id = p.familyId
        WHERE p.active = 1 AND f.active = 1 AND f.type = :type
        ORDER BY f.sortOrder, p.sortOrder, p.name
    """)
    fun getActiveProductsByFamilyType(type: FamilyType): Flow<List<Product>>
}
