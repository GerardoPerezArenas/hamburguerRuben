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
import com.gerardo.myapplication.`data`.entities.Zone
import java.lang.Class
import java.util.ArrayList
import java.util.concurrent.Callable
import javax.`annotation`.processing.Generated
import kotlin.Boolean
import kotlin.Int
import kotlin.Long
import kotlin.String
import kotlin.Suppress
import kotlin.Unit
import kotlin.collections.List
import kotlin.collections.MutableList
import kotlin.jvm.JvmStatic
import kotlinx.coroutines.flow.Flow

@Generated(value = ["androidx.room.RoomProcessor"])
@Suppress(names = ["UNCHECKED_CAST", "DEPRECATION", "REDUNDANT_PROJECTION"])
public class ZoneDao_Impl(
  __db: RoomDatabase,
) : ZoneDao {
  private val __db: RoomDatabase

  private val __insertionAdapterOfZone: EntityInsertionAdapter<Zone>
  init {
    this.__db = __db
    this.__insertionAdapterOfZone = object : EntityInsertionAdapter<Zone>(__db) {
      protected override fun createQuery(): String =
          "INSERT OR REPLACE INTO `zones` (`id`,`name`,`active`,`sortOrder`,`createdAt`) VALUES (nullif(?, 0),?,?,?,?)"

      protected override fun bind(statement: SupportSQLiteStatement, entity: Zone) {
        statement.bindLong(1, entity.id.toLong())
        statement.bindString(2, entity.name)
        val _tmp: Int = if (entity.active) 1 else 0
        statement.bindLong(3, _tmp.toLong())
        statement.bindLong(4, entity.sortOrder.toLong())
        statement.bindLong(5, entity.createdAt)
      }
    }
  }

  public override suspend fun insertZones(zones: List<Zone>): Unit = CoroutinesRoom.execute(__db,
      true, object : Callable<Unit> {
    public override fun call() {
      __db.beginTransaction()
      try {
        __insertionAdapterOfZone.insert(zones)
        __db.setTransactionSuccessful()
      } finally {
        __db.endTransaction()
      }
    }
  })

  public override fun getAllZones(): Flow<List<Zone>> {
    val _sql: String = "SELECT * FROM zones ORDER BY sortOrder ASC, name ASC"
    val _statement: RoomSQLiteQuery = acquire(_sql, 0)
    return CoroutinesRoom.createFlow(__db, false, arrayOf("zones"), object : Callable<List<Zone>> {
      public override fun call(): List<Zone> {
        val _cursor: Cursor = query(__db, _statement, false, null)
        try {
          val _cursorIndexOfId: Int = getColumnIndexOrThrow(_cursor, "id")
          val _cursorIndexOfName: Int = getColumnIndexOrThrow(_cursor, "name")
          val _cursorIndexOfActive: Int = getColumnIndexOrThrow(_cursor, "active")
          val _cursorIndexOfSortOrder: Int = getColumnIndexOrThrow(_cursor, "sortOrder")
          val _cursorIndexOfCreatedAt: Int = getColumnIndexOrThrow(_cursor, "createdAt")
          val _result: MutableList<Zone> = ArrayList<Zone>(_cursor.getCount())
          while (_cursor.moveToNext()) {
            val _item: Zone
            val _tmpId: Int
            _tmpId = _cursor.getInt(_cursorIndexOfId)
            val _tmpName: String
            _tmpName = _cursor.getString(_cursorIndexOfName)
            val _tmpActive: Boolean
            val _tmp: Int
            _tmp = _cursor.getInt(_cursorIndexOfActive)
            _tmpActive = _tmp != 0
            val _tmpSortOrder: Int
            _tmpSortOrder = _cursor.getInt(_cursorIndexOfSortOrder)
            val _tmpCreatedAt: Long
            _tmpCreatedAt = _cursor.getLong(_cursorIndexOfCreatedAt)
            _item = Zone(_tmpId,_tmpName,_tmpActive,_tmpSortOrder,_tmpCreatedAt)
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

  public override fun getActiveZones(): Flow<List<Zone>> {
    val _sql: String = "SELECT * FROM zones WHERE active = 1 ORDER BY sortOrder ASC, name ASC"
    val _statement: RoomSQLiteQuery = acquire(_sql, 0)
    return CoroutinesRoom.createFlow(__db, false, arrayOf("zones"), object : Callable<List<Zone>> {
      public override fun call(): List<Zone> {
        val _cursor: Cursor = query(__db, _statement, false, null)
        try {
          val _cursorIndexOfId: Int = getColumnIndexOrThrow(_cursor, "id")
          val _cursorIndexOfName: Int = getColumnIndexOrThrow(_cursor, "name")
          val _cursorIndexOfActive: Int = getColumnIndexOrThrow(_cursor, "active")
          val _cursorIndexOfSortOrder: Int = getColumnIndexOrThrow(_cursor, "sortOrder")
          val _cursorIndexOfCreatedAt: Int = getColumnIndexOrThrow(_cursor, "createdAt")
          val _result: MutableList<Zone> = ArrayList<Zone>(_cursor.getCount())
          while (_cursor.moveToNext()) {
            val _item: Zone
            val _tmpId: Int
            _tmpId = _cursor.getInt(_cursorIndexOfId)
            val _tmpName: String
            _tmpName = _cursor.getString(_cursorIndexOfName)
            val _tmpActive: Boolean
            val _tmp: Int
            _tmp = _cursor.getInt(_cursorIndexOfActive)
            _tmpActive = _tmp != 0
            val _tmpSortOrder: Int
            _tmpSortOrder = _cursor.getInt(_cursorIndexOfSortOrder)
            val _tmpCreatedAt: Long
            _tmpCreatedAt = _cursor.getLong(_cursorIndexOfCreatedAt)
            _item = Zone(_tmpId,_tmpName,_tmpActive,_tmpSortOrder,_tmpCreatedAt)
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

  public override suspend fun getById(id: Int): Zone? {
    val _sql: String = "SELECT * FROM zones WHERE id = ? LIMIT 1"
    val _statement: RoomSQLiteQuery = acquire(_sql, 1)
    var _argIndex: Int = 1
    _statement.bindLong(_argIndex, id.toLong())
    val _cancellationSignal: CancellationSignal? = createCancellationSignal()
    return execute(__db, false, _cancellationSignal, object : Callable<Zone?> {
      public override fun call(): Zone? {
        val _cursor: Cursor = query(__db, _statement, false, null)
        try {
          val _cursorIndexOfId: Int = getColumnIndexOrThrow(_cursor, "id")
          val _cursorIndexOfName: Int = getColumnIndexOrThrow(_cursor, "name")
          val _cursorIndexOfActive: Int = getColumnIndexOrThrow(_cursor, "active")
          val _cursorIndexOfSortOrder: Int = getColumnIndexOrThrow(_cursor, "sortOrder")
          val _cursorIndexOfCreatedAt: Int = getColumnIndexOrThrow(_cursor, "createdAt")
          val _result: Zone?
          if (_cursor.moveToFirst()) {
            val _tmpId: Int
            _tmpId = _cursor.getInt(_cursorIndexOfId)
            val _tmpName: String
            _tmpName = _cursor.getString(_cursorIndexOfName)
            val _tmpActive: Boolean
            val _tmp: Int
            _tmp = _cursor.getInt(_cursorIndexOfActive)
            _tmpActive = _tmp != 0
            val _tmpSortOrder: Int
            _tmpSortOrder = _cursor.getInt(_cursorIndexOfSortOrder)
            val _tmpCreatedAt: Long
            _tmpCreatedAt = _cursor.getLong(_cursorIndexOfCreatedAt)
            _result = Zone(_tmpId,_tmpName,_tmpActive,_tmpSortOrder,_tmpCreatedAt)
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

  public override suspend fun getByName(name: String): Zone? {
    val _sql: String = "SELECT * FROM zones WHERE name = ? LIMIT 1"
    val _statement: RoomSQLiteQuery = acquire(_sql, 1)
    var _argIndex: Int = 1
    _statement.bindString(_argIndex, name)
    val _cancellationSignal: CancellationSignal? = createCancellationSignal()
    return execute(__db, false, _cancellationSignal, object : Callable<Zone?> {
      public override fun call(): Zone? {
        val _cursor: Cursor = query(__db, _statement, false, null)
        try {
          val _cursorIndexOfId: Int = getColumnIndexOrThrow(_cursor, "id")
          val _cursorIndexOfName: Int = getColumnIndexOrThrow(_cursor, "name")
          val _cursorIndexOfActive: Int = getColumnIndexOrThrow(_cursor, "active")
          val _cursorIndexOfSortOrder: Int = getColumnIndexOrThrow(_cursor, "sortOrder")
          val _cursorIndexOfCreatedAt: Int = getColumnIndexOrThrow(_cursor, "createdAt")
          val _result: Zone?
          if (_cursor.moveToFirst()) {
            val _tmpId: Int
            _tmpId = _cursor.getInt(_cursorIndexOfId)
            val _tmpName: String
            _tmpName = _cursor.getString(_cursorIndexOfName)
            val _tmpActive: Boolean
            val _tmp: Int
            _tmp = _cursor.getInt(_cursorIndexOfActive)
            _tmpActive = _tmp != 0
            val _tmpSortOrder: Int
            _tmpSortOrder = _cursor.getInt(_cursorIndexOfSortOrder)
            val _tmpCreatedAt: Long
            _tmpCreatedAt = _cursor.getLong(_cursorIndexOfCreatedAt)
            _result = Zone(_tmpId,_tmpName,_tmpActive,_tmpSortOrder,_tmpCreatedAt)
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
