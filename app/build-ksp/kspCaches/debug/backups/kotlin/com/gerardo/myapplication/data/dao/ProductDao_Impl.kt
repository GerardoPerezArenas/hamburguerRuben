package com.gerardo.myapplication.`data`.dao

import android.database.Cursor
import androidx.room.CoroutinesRoom
import androidx.room.EntityInsertionAdapter
import androidx.room.RoomDatabase
import androidx.room.RoomSQLiteQuery
import androidx.room.RoomSQLiteQuery.Companion.acquire
import androidx.room.util.getColumnIndexOrThrow
import androidx.room.util.query
import androidx.sqlite.db.SupportSQLiteStatement
import com.gerardo.myapplication.`data`.database.Converters
import com.gerardo.myapplication.`data`.entities.FamilyType
import com.gerardo.myapplication.`data`.entities.PrinterRoute
import com.gerardo.myapplication.`data`.entities.Product
import java.lang.Class
import java.util.ArrayList
import java.util.concurrent.Callable
import javax.`annotation`.processing.Generated
import kotlin.Boolean
import kotlin.Int
import kotlin.String
import kotlin.Suppress
import kotlin.Unit
import kotlin.collections.List
import kotlin.collections.MutableList
import kotlin.jvm.JvmStatic
import kotlinx.coroutines.flow.Flow

@Generated(value = ["androidx.room.RoomProcessor"])
@Suppress(names = ["UNCHECKED_CAST", "DEPRECATION", "REDUNDANT_PROJECTION"])
public class ProductDao_Impl(
  __db: RoomDatabase,
) : ProductDao {
  private val __db: RoomDatabase

  private val __insertionAdapterOfProduct: EntityInsertionAdapter<Product>

  private val __converters: Converters = Converters()
  init {
    this.__db = __db
    this.__insertionAdapterOfProduct = object : EntityInsertionAdapter<Product>(__db) {
      protected override fun createQuery(): String =
          "INSERT OR REPLACE INTO `products` (`id`,`familyId`,`name`,`priceCents`,`allergens`,`printerRoute`,`active`,`sortOrder`) VALUES (nullif(?, 0),?,?,?,?,?,?,?)"

      protected override fun bind(statement: SupportSQLiteStatement, entity: Product) {
        statement.bindLong(1, entity.id.toLong())
        statement.bindLong(2, entity.familyId.toLong())
        statement.bindString(3, entity.name)
        statement.bindLong(4, entity.priceCents.toLong())
        val _tmpAllergens: String? = entity.allergens
        if (_tmpAllergens == null) {
          statement.bindNull(5)
        } else {
          statement.bindString(5, _tmpAllergens)
        }
        val _tmp: String = __converters.fromPrinterRoute(entity.printerRoute)
        statement.bindString(6, _tmp)
        val _tmp_1: Int = if (entity.active) 1 else 0
        statement.bindLong(7, _tmp_1.toLong())
        statement.bindLong(8, entity.sortOrder.toLong())
      }
    }
  }

  public override suspend fun insertProducts(products: List<Product>): Unit =
      CoroutinesRoom.execute(__db, true, object : Callable<Unit> {
    public override fun call() {
      __db.beginTransaction()
      try {
        __insertionAdapterOfProduct.insert(products)
        __db.setTransactionSuccessful()
      } finally {
        __db.endTransaction()
      }
    }
  })

  public override fun getActiveProductsByFamilyType(type: FamilyType): Flow<List<Product>> {
    val _sql: String = """
        |
        |        SELECT p.* FROM products p
        |        INNER JOIN families f ON f.id = p.familyId
        |        WHERE p.active = 1 AND f.active = 1 AND f.type = ?
        |        ORDER BY f.sortOrder, p.sortOrder, p.name
        |    
        """.trimMargin()
    val _statement: RoomSQLiteQuery = acquire(_sql, 1)
    var _argIndex: Int = 1
    val _tmp: String = __converters.fromFamilyType(type)
    _statement.bindString(_argIndex, _tmp)
    return CoroutinesRoom.createFlow(__db, false, arrayOf("products", "families"), object :
        Callable<List<Product>> {
      public override fun call(): List<Product> {
        val _cursor: Cursor = query(__db, _statement, false, null)
        try {
          val _cursorIndexOfId: Int = getColumnIndexOrThrow(_cursor, "id")
          val _cursorIndexOfFamilyId: Int = getColumnIndexOrThrow(_cursor, "familyId")
          val _cursorIndexOfName: Int = getColumnIndexOrThrow(_cursor, "name")
          val _cursorIndexOfPriceCents: Int = getColumnIndexOrThrow(_cursor, "priceCents")
          val _cursorIndexOfAllergens: Int = getColumnIndexOrThrow(_cursor, "allergens")
          val _cursorIndexOfPrinterRoute: Int = getColumnIndexOrThrow(_cursor, "printerRoute")
          val _cursorIndexOfActive: Int = getColumnIndexOrThrow(_cursor, "active")
          val _cursorIndexOfSortOrder: Int = getColumnIndexOrThrow(_cursor, "sortOrder")
          val _result: MutableList<Product> = ArrayList<Product>(_cursor.getCount())
          while (_cursor.moveToNext()) {
            val _item: Product
            val _tmpId: Int
            _tmpId = _cursor.getInt(_cursorIndexOfId)
            val _tmpFamilyId: Int
            _tmpFamilyId = _cursor.getInt(_cursorIndexOfFamilyId)
            val _tmpName: String
            _tmpName = _cursor.getString(_cursorIndexOfName)
            val _tmpPriceCents: Int
            _tmpPriceCents = _cursor.getInt(_cursorIndexOfPriceCents)
            val _tmpAllergens: String?
            if (_cursor.isNull(_cursorIndexOfAllergens)) {
              _tmpAllergens = null
            } else {
              _tmpAllergens = _cursor.getString(_cursorIndexOfAllergens)
            }
            val _tmpPrinterRoute: PrinterRoute
            val _tmp_1: String
            _tmp_1 = _cursor.getString(_cursorIndexOfPrinterRoute)
            _tmpPrinterRoute = __converters.toPrinterRoute(_tmp_1)
            val _tmpActive: Boolean
            val _tmp_2: Int
            _tmp_2 = _cursor.getInt(_cursorIndexOfActive)
            _tmpActive = _tmp_2 != 0
            val _tmpSortOrder: Int
            _tmpSortOrder = _cursor.getInt(_cursorIndexOfSortOrder)
            _item =
                Product(_tmpId,_tmpFamilyId,_tmpName,_tmpPriceCents,_tmpAllergens,_tmpPrinterRoute,_tmpActive,_tmpSortOrder)
            _result.add(_item)
          }
          return _result
        } finally {
          _cursor.close()
        }
      }

      protected fun finalize() {
        _statement.release()
      }
    })
  }

  public companion object {
    @JvmStatic
    public fun getRequiredConverters(): List<Class<*>> = emptyList()
  }
}
