package com.gerardo.myapplication.data.dao

import androidx.room.Dao
import androidx.room.Insert
import androidx.room.Query
import androidx.room.Transaction
import androidx.room.Update
import com.gerardo.myapplication.data.entities.Order
import com.gerardo.myapplication.data.entities.OrderItem
import com.gerardo.myapplication.data.entities.OrderStatus
import kotlinx.coroutines.flow.Flow

@Dao
interface OrderDao {
    @Insert
    suspend fun insertOrder(order: Order): Long

    @Update
    suspend fun updateOrder(order: Order)

    @Query("SELECT * FROM orders WHERE tableId = :tableId AND status = 'OPEN' LIMIT 1")
    suspend fun getOpenOrderByTable(tableId: Int): Order?

    @Query("SELECT * FROM orders WHERE id = :orderId")
    suspend fun getOrderById(orderId: Int): Order?

    @Transaction
    @Query("SELECT * FROM orders WHERE tableId = :tableId AND status = 'OPEN'")
    fun getOpenOrderWithItemsByTable(tableId: Int): Flow<OrderWithItems?>
}

@Dao
interface OrderItemDao {
    @Insert
    suspend fun insertOrderItem(orderItem: OrderItem)

    @Query("DELETE FROM order_items WHERE orderId = :orderId")
    suspend fun deleteItemsByOrderId(orderId: Int)

    @Query("SELECT * FROM order_items WHERE orderId = :orderId")
    suspend fun getItemsByOrderId(orderId: Int): List<OrderItem>
}

data class OrderWithItems(
    val order: Order,
    val items: List<OrderItem>
)
