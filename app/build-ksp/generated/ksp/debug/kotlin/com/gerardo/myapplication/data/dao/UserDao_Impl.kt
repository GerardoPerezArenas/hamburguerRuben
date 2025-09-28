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
import com.gerardo.myapplication.`data`.entities.User
import java.lang.Class
import java.util.concurrent.Callable
import javax.`annotation`.processing.Generated
import kotlin.Int
import kotlin.String
import kotlin.Suppress
import kotlin.Unit
import kotlin.collections.List
import kotlin.jvm.JvmStatic

@Generated(value = ["androidx.room.RoomProcessor"])
@Suppress(names = ["UNCHECKED_CAST", "DEPRECATION", "REDUNDANT_PROJECTION"])
public class UserDao_Impl(
  __db: RoomDatabase,
) : UserDao {
  private val __db: RoomDatabase

  private val __insertionAdapterOfUser: EntityInsertionAdapter<User>
  init {
    this.__db = __db
    this.__insertionAdapterOfUser = object : EntityInsertionAdapter<User>(__db) {
      protected override fun createQuery(): String =
          "INSERT OR REPLACE INTO `users` (`username`,`password`,`role`) VALUES (?,?,?)"

      protected override fun bind(statement: SupportSQLiteStatement, entity: User) {
        statement.bindString(1, entity.username)
        statement.bindString(2, entity.password)
        statement.bindString(3, entity.role)
      }
    }
  }

  public override suspend fun insertUsers(users: List<User>): Unit = CoroutinesRoom.execute(__db,
      true, object : Callable<Unit> {
    public override fun call() {
      __db.beginTransaction()
      try {
        __insertionAdapterOfUser.insert(users)
        __db.setTransactionSuccessful()
      } finally {
        __db.endTransaction()
      }
    }
  })

  public override suspend fun authenticateUser(username: String, password: String): User? {
    val _sql: String = "SELECT * FROM users WHERE username = ? AND password = ?"
    val _statement: RoomSQLiteQuery = acquire(_sql, 2)
    var _argIndex: Int = 1
    _statement.bindString(_argIndex, username)
    _argIndex = 2
    _statement.bindString(_argIndex, password)
    val _cancellationSignal: CancellationSignal? = createCancellationSignal()
    return execute(__db, false, _cancellationSignal, object : Callable<User?> {
      public override fun call(): User? {
        val _cursor: Cursor = query(__db, _statement, false, null)
        try {
          val _cursorIndexOfUsername: Int = getColumnIndexOrThrow(_cursor, "username")
          val _cursorIndexOfPassword: Int = getColumnIndexOrThrow(_cursor, "password")
          val _cursorIndexOfRole: Int = getColumnIndexOrThrow(_cursor, "role")
          val _result: User?
          if (_cursor.moveToFirst()) {
            val _tmpUsername: String
            _tmpUsername = _cursor.getString(_cursorIndexOfUsername)
            val _tmpPassword: String
            _tmpPassword = _cursor.getString(_cursorIndexOfPassword)
            val _tmpRole: String
            _tmpRole = _cursor.getString(_cursorIndexOfRole)
            _result = User(_tmpUsername,_tmpPassword,_tmpRole)
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

  public override suspend fun getUserCount(): Int {
    val _sql: String = "SELECT COUNT(*) FROM users"
    val _statement: RoomSQLiteQuery = acquire(_sql, 0)
    val _cancellationSignal: CancellationSignal? = createCancellationSignal()
    return execute(__db, false, _cancellationSignal, object : Callable<Int> {
      public override fun call(): Int {
        val _cursor: Cursor = query(__db, _statement, false, null)
        try {
          val _result: Int
          if (_cursor.moveToFirst()) {
            val _tmp: Int
            _tmp = _cursor.getInt(0)
            _result = _tmp
          } else {
            _result = 0
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
