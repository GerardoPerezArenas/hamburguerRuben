package com.gerardo.myapplication.`data`.dao

import android.database.Cursor
import android.os.CancellationSignal
import androidx.room.CoroutinesRoom
import androidx.room.CoroutinesRoom.Companion.execute
import androidx.room.EntityInsertionAdapter
import androidx.room.RoomDatabase
import androidx.room.RoomSQLiteQuery
import androidx.room.RoomSQLiteQuery.Companion.acquire
import androidx.room.util.createCancellationSignal
import androidx.room.util.getColumnIndexOrThrow
import androidx.room.util.query
import androidx.sqlite.db.SupportSQLiteStatement
import com.gerardo.myapplication.`data`.database.Converters
import com.gerardo.myapplication.`data`.entities.Family
import com.gerardo.myapplication.`data`.entities.FamilyType
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
public class FamilyDao_Impl(
  __db: RoomDatabase,
) : FamilyDao {
  private val __db: RoomDatabase

  private val __insertionAdapterOfFamily: EntityInsertionAdapter<Family>

  private val __converters: Converters = Converters()
  init {
    this.__db = __db
    this.__insertionAdapterOfFamily = object : EntityInsertionAdapter<Family>(__db) {
      protected override fun createQuery(): String =
          "INSERT OR REPLACE INTO `families` (`id`,`name`,`type`,`active`,`sortOrder`) VALUES (nullif(?, 0),?,?,?,?)"

      protected override fun bind(statement: SupportSQLiteStatement, entity: Family) {
        statement.bindLong(1, entity.id.toLong())
        statement.bindString(2, entity.name)
        val _tmp: String = __converters.fromFamilyType(entity.type)
        statement.bindString(3, _tmp)
        val _tmp_1: Int = if (entity.active) 1 else 0
        statement.bindLong(4, _tmp_1.toLong())
        statement.bindLong(5, entity.sortOrder.toLong())
      }
    }
  }

  public override suspend fun insertFamilies(families: List<Family>): Unit =
      CoroutinesRoom.execute(__db, true, object : Callable<Unit> {
    public override fun call() {
      __db.beginTransaction()
      try {
        __insertionAdapterOfFamily.insert(families)
        __db.setTransactionSuccessful()
      } finally {
        __db.endTransaction()
      }
    }
  })

  public override fun getActiveFamiliesByType(type: FamilyType): Flow<List<Family>> {
    val _sql: String =
        "SELECT * FROM families WHERE active = 1 AND type = ? ORDER BY sortOrder, name"
    val _statement: RoomSQLiteQuery = acquire(_sql, 1)
    var _argIndex: Int = 1
    val _tmp: String = __converters.fromFamilyType(type)
    _statement.bindString(_argIndex, _tmp)
    return CoroutinesRoom.createFlow(__db, false, arrayOf("families"), object :
        Callable<List<Family>> {
      public override fun call(): List<Family> {
        val _cursor: Cursor = query(__db, _statement, false, null)
        try {
          val _cursorIndexOfId: Int = getColumnIndexOrThrow(_cursor, "id")
          val _cursorIndexOfName: Int = getColumnIndexOrThrow(_cursor, "name")
          val _cursorIndexOfType: Int = getColumnIndexOrThrow(_cursor, "type")
          val _cursorIndexOfActive: Int = getColumnIndexOrThrow(_cursor, "active")
          val _cursorIndexOfSortOrder: Int = getColumnIndexOrThrow(_cursor, "sortOrder")
          val _result: MutableList<Family> = ArrayList<Family>(_cursor.getCount())
          while (_cursor.moveToNext()) {
            val _item: Family
            val _tmpId: Int
            _tmpId = _cursor.getInt(_cursorIndexOfId)
            val _tmpName: String
            _tmpName = _cursor.getString(_cursorIndexOfName)
            val _tmpType: FamilyType
            val _tmp_1: String
            _tmp_1 = _cursor.getString(_cursorIndexOfType)
            _tmpType = __converters.toFamilyType(_tmp_1)
            val _tmpActive: Boolean
            val _tmp_2: Int
            _tmp_2 = _cursor.getInt(_cursorIndexOfActive)
            _tmpActive = _tmp_2 != 0
            val _tmpSortOrder: Int
            _tmpSortOrder = _cursor.getInt(_cursorIndexOfSortOrder)
            _item = Family(_tmpId,_tmpName,_tmpType,_tmpActive,_tmpSortOrder)
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

  public override suspend fun getByName(name: String): Family? {
    val _sql: String = "SELECT * FROM families WHERE name = ? LIMIT 1"
    val _statement: RoomSQLiteQuery = acquire(_sql, 1)
    var _argIndex: Int = 1
    _statement.bindString(_argIndex, name)
    val _cancellationSignal: CancellationSignal? = createCancellationSignal()
    return execute(__db, false, _cancellationSignal, object : Callable<Family?> {
      public override fun call(): Family? {
        val _cursor: Cursor = query(__db, _statement, false, null)
        try {
          val _cursorIndexOfId: Int = getColumnIndexOrThrow(_cursor, "id")
          val _cursorIndexOfName: Int = getColumnIndexOrThrow(_cursor, "name")
          val _cursorIndexOfType: Int = getColumnIndexOrThrow(_cursor, "type")
          val _cursorIndexOfActive: Int = getColumnIndexOrThrow(_cursor, "active")
          val _cursorIndexOfSortOrder: Int = getColumnIndexOrThrow(_cursor, "sortOrder")
          val _result: Family?
          if (_cursor.moveToFirst()) {
            val _tmpId: Int
            _tmpId = _cursor.getInt(_cursorIndexOfId)
            val _tmpName: String
            _tmpName = _cursor.getString(_cursorIndexOfName)
            val _tmpType: FamilyType
            val _tmp: String
            _tmp = _cursor.getString(_cursorIndexOfType)
            _tmpType = __converters.toFamilyType(_tmp)
            val _tmpActive: Boolean
            val _tmp_1: Int
            _tmp_1 = _cursor.getInt(_cursorIndexOfActive)
            _tmpActive = _tmp_1 != 0
            val _tmpSortOrder: Int
            _tmpSortOrder = _cursor.getInt(_cursorIndexOfSortOrder)
            _result = Family(_tmpId,_tmpName,_tmpType,_tmpActive,_tmpSortOrder)
          } else {
            _result = null
          }
          return _result
        } finally {
          _cursor.close()
          _statement.release()
        }
      }
    })
  }

  public companion object {
    @JvmStatic
    public fun getRequiredConverters(): List<Class<*>> = emptyList()
  }
}
