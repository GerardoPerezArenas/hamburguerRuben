package com.gerardo.myapplication.`data`.dao

import android.database.Cursor
import androidx.room.CoroutinesRoom
import androidx.room.EntityDeletionOrUpdateAdapter
import androidx.room.EntityInsertionAdapter
import androidx.room.EntityUpsertionAdapter
import androidx.room.RoomDatabase
import androidx.room.RoomSQLiteQuery
import androidx.room.RoomSQLiteQuery.Companion.acquire
import androidx.room.SharedSQLiteStatement
import androidx.room.util.getColumnIndexOrThrow
import androidx.room.util.query
import androidx.sqlite.db.SupportSQLiteStatement
import com.gerardo.myapplication.`data`.database.Converters
import com.gerardo.myapplication.`data`.entities.Table
import com.gerardo.myapplication.`data`.entities.TableStatus
import java.lang.Class
import java.util.ArrayList
import java.util.concurrent.Callable
import javax.`annotation`.processing.Generated
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
public class TableDao_Impl(
  __db: RoomDatabase,
) : TableDao {
  private val __db: RoomDatabase

  private val __preparedStmtOfUpdateStatus: SharedSQLiteStatement

  private val __converters: Converters = Converters()

  private val __upsertionAdapterOfTable: EntityUpsertionAdapter<Table>
  init {
    this.__db = __db
    this.__preparedStmtOfUpdateStatus = object : SharedSQLiteStatement(__db) {
      public override fun createQuery(): String {
        val _query: String = "UPDATE tables SET status = ?, updatedAt = ? WHERE id = ?"
        return _query
      }
    }
    this.__upsertionAdapterOfTable = EntityUpsertionAdapter<Table>(object :
        EntityInsertionAdapter<Table>(__db) {
      protected override fun createQuery(): String =
          "INSERT INTO `tables` (`id`,`zoneId`,`number`,`status`,`updatedAt`) VALUES (nullif(?, 0),?,?,?,?)"

      protected override fun bind(statement: SupportSQLiteStatement, entity: Table) {
        statement.bindLong(1, entity.id.toLong())
        statement.bindLong(2, entity.zoneId.toLong())
        statement.bindLong(3, entity.number.toLong())
        val _tmp: String = __converters.fromTableStatus(entity.status)
        statement.bindString(4, _tmp)
        statement.bindLong(5, entity.updatedAt)
      }
    }, object : EntityDeletionOrUpdateAdapter<Table>(__db) {
      protected override fun createQuery(): String =
          "UPDATE `tables` SET `id` = ?,`zoneId` = ?,`number` = ?,`status` = ?,`updatedAt` = ? WHERE `id` = ?"

      protected override fun bind(statement: SupportSQLiteStatement, entity: Table) {
        statement.bindLong(1, entity.id.toLong())
        statement.bindLong(2, entity.zoneId.toLong())
        statement.bindLong(3, entity.number.toLong())
        val _tmp: String = __converters.fromTableStatus(entity.status)
        statement.bindString(4, _tmp)
        statement.bindLong(5, entity.updatedAt)
        statement.bindLong(6, entity.id.toLong())
      }
    })
  }

  public override suspend fun updateStatus(
    id: Int,
    status: TableStatus,
    updatedAt: Long,
  ): Unit = CoroutinesRoom.execute(__db, true, object : Callable<Unit> {
    public override fun call() {
      val _stmt: SupportSQLiteStatement = __preparedStmtOfUpdateStatus.acquire()
      var _argIndex: Int = 1
      val _tmp: String = __converters.fromTableStatus(status)
      _stmt.bindString(_argIndex, _tmp)
      _argIndex = 2
      _stmt.bindLong(_argIndex, updatedAt)
      _argIndex = 3
      _stmt.bindLong(_argIndex, id.toLong())
      try {
        __db.beginTransaction()
        try {
          _stmt.executeUpdateDelete()
          __db.setTransactionSuccessful()
        } finally {
          __db.endTransaction()
        }
      } finally {
        __preparedStmtOfUpdateStatus.release(_stmt)
      }
    }
  })

  public override suspend fun upsertAll(tables: List<Table>): Unit = CoroutinesRoom.execute(__db,
      true, object : Callable<Unit> {
    public override fun call() {
      __db.beginTransaction()
      try {
        __upsertionAdapterOfTable.upsert(tables)
        __db.setTransactionSuccessful()
      } finally {
        __db.endTransaction()
      }
    }
  })

  public override fun getTablesByZone(zoneId: Int): Flow<List<Table>> {
    val _sql: String = "SELECT * FROM tables WHERE zoneId = ? ORDER BY number ASC"
    val _statement: RoomSQLiteQuery = acquire(_sql, 1)
    var _argIndex: Int = 1
    _statement.bindLong(_argIndex, zoneId.toLong())
    return CoroutinesRoom.createFlow(__db, false, arrayOf("tables"), object : Callable<List<Table>>
        {
      public override fun call(): List<Table> {
        val _cursor: Cursor = query(__db, _statement, false, null)
        try {
          val _cursorIndexOfId: Int = getColumnIndexOrThrow(_cursor, "id")
          val _cursorIndexOfZoneId: Int = getColumnIndexOrThrow(_cursor, "zoneId")
          val _cursorIndexOfNumber: Int = getColumnIndexOrThrow(_cursor, "number")
          val _cursorIndexOfStatus: Int = getColumnIndexOrThrow(_cursor, "status")
          val _cursorIndexOfUpdatedAt: Int = getColumnIndexOrThrow(_cursor, "updatedAt")
          val _result: MutableList<Table> = ArrayList<Table>(_cursor.getCount())
          while (_cursor.moveToNext()) {
            val _item: Table
            val _tmpId: Int
            _tmpId = _cursor.getInt(_cursorIndexOfId)
            val _tmpZoneId: Int
            _tmpZoneId = _cursor.getInt(_cursorIndexOfZoneId)
            val _tmpNumber: Int
            _tmpNumber = _cursor.getInt(_cursorIndexOfNumber)
            val _tmpStatus: TableStatus
            val _tmp: String
            _tmp = _cursor.getString(_cursorIndexOfStatus)
            _tmpStatus = __converters.toTableStatus(_tmp)
            val _tmpUpdatedAt: Long
            _tmpUpdatedAt = _cursor.getLong(_cursorIndexOfUpdatedAt)
            _item = Table(_tmpId,_tmpZoneId,_tmpNumber,_tmpStatus,_tmpUpdatedAt)
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
