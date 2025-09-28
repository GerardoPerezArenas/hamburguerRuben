package com.gerardo.myapplication.data.database

import androidx.room.TypeConverter
import com.gerardo.myapplication.data.entities.TableStatus
import com.gerardo.myapplication.data.entities.FamilyType
import com.gerardo.myapplication.data.entities.PrinterRoute
import com.gerardo.myapplication.data.entities.OrderStatus

class Converters {
    @TypeConverter
    fun toTableStatus(value: String): TableStatus = TableStatus.valueOf(value)

    @TypeConverter
    fun fromTableStatus(status: TableStatus): String = status.name

    @TypeConverter
    fun toFamilyType(value: String): FamilyType = FamilyType.valueOf(value)

    @TypeConverter
    fun fromFamilyType(type: FamilyType): String = type.name

    @TypeConverter
    fun toPrinterRoute(value: String): PrinterRoute = PrinterRoute.valueOf(value)

    @TypeConverter
    fun fromPrinterRoute(route: PrinterRoute): String = route.name

    @TypeConverter
    fun toOrderStatus(value: String): OrderStatus = OrderStatus.valueOf(value)

    @TypeConverter
    fun fromOrderStatus(status: OrderStatus): String = status.name
}
