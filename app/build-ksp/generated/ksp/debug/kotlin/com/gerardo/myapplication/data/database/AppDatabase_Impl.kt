package com.gerardo.myapplication.`data`.database

import androidx.room.DatabaseConfiguration
import androidx.room.InvalidationTracker
import androidx.room.RoomDatabase
import androidx.room.RoomOpenHelper
import androidx.room.migration.AutoMigrationSpec
import androidx.room.migration.Migration
import androidx.room.util.TableInfo
import androidx.room.util.TableInfo.Companion.read
import androidx.room.util.dropFtsSyncTriggers
import androidx.sqlite.db.SupportSQLiteDatabase
import androidx.sqlite.db.SupportSQLiteOpenHelper
import com.gerardo.myapplication.`data`.dao.FamilyDao
import com.gerardo.myapplication.`data`.dao.FamilyDao_Impl
import com.gerardo.myapplication.`data`.dao.ProductDao
import com.gerardo.myapplication.`data`.dao.ProductDao_Impl
import com.gerardo.myapplication.`data`.dao.TableDao
import com.gerardo.myapplication.`data`.dao.TableDao_Impl
import com.gerardo.myapplication.`data`.dao.UserDao
import com.gerardo.myapplication.`data`.dao.UserDao_Impl
import com.gerardo.myapplication.`data`.dao.ZoneDao
import com.gerardo.myapplication.`data`.dao.ZoneDao_Impl
import java.lang.Class
import java.util.ArrayList
import java.util.HashMap
import java.util.HashSet
import javax.`annotation`.processing.Generated
import kotlin.Any
import kotlin.Boolean
import kotlin.Lazy
import kotlin.String
import kotlin.Suppress
import kotlin.collections.List
import kotlin.collections.Map
import kotlin.collections.MutableList
import kotlin.collections.Set

@Generated(value = ["androidx.room.RoomProcessor"])
@Suppress(names = ["UNCHECKED_CAST", "DEPRECATION", "REDUNDANT_PROJECTION"])
public class AppDatabase_Impl : AppDatabase() {
  private val _userDao: Lazy<UserDao> = lazy {
    UserDao_Impl(this)
  }


  private val _zoneDao: Lazy<ZoneDao> = lazy {
    ZoneDao_Impl(this)
  }


  private val _tableDao: Lazy<TableDao> = lazy {
    TableDao_Impl(this)
  }


  private val _familyDao: Lazy<FamilyDao> = lazy {
    FamilyDao_Impl(this)
  }


  private val _productDao: Lazy<ProductDao> = lazy {
    ProductDao_Impl(this)
  }


  protected override fun createOpenHelper(config: DatabaseConfiguration): SupportSQLiteOpenHelper {
    val _openCallback: SupportSQLiteOpenHelper.Callback = RoomOpenHelper(config, object :
        RoomOpenHelper.Delegate(1) {
      public override fun createAllTables(db: SupportSQLiteDatabase) {
        db.execSQL("CREATE TABLE IF NOT EXISTS `users` (`username` TEXT NOT NULL, `password` TEXT NOT NULL, `role` TEXT NOT NULL, PRIMARY KEY(`username`))")
        db.execSQL("CREATE TABLE IF NOT EXISTS `zones` (`id` INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, `name` TEXT NOT NULL, `active` INTEGER NOT NULL, `sortOrder` INTEGER NOT NULL, `createdAt` INTEGER NOT NULL)")
        db.execSQL("CREATE UNIQUE INDEX IF NOT EXISTS `index_zones_name` ON `zones` (`name`)")
        db.execSQL("CREATE TABLE IF NOT EXISTS `tables` (`id` INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, `zoneId` INTEGER NOT NULL, `number` INTEGER NOT NULL, `status` TEXT NOT NULL, `updatedAt` INTEGER NOT NULL, FOREIGN KEY(`zoneId`) REFERENCES `zones`(`id`) ON UPDATE NO ACTION ON DELETE CASCADE )")
        db.execSQL("CREATE INDEX IF NOT EXISTS `index_tables_zoneId` ON `tables` (`zoneId`)")
        db.execSQL("CREATE UNIQUE INDEX IF NOT EXISTS `index_tables_zoneId_number` ON `tables` (`zoneId`, `number`)")
        db.execSQL("CREATE TABLE IF NOT EXISTS `families` (`id` INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, `name` TEXT NOT NULL, `type` TEXT NOT NULL, `active` INTEGER NOT NULL, `sortOrder` INTEGER NOT NULL)")
        db.execSQL("CREATE UNIQUE INDEX IF NOT EXISTS `index_families_name` ON `families` (`name`)")
        db.execSQL("CREATE TABLE IF NOT EXISTS `products` (`id` INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, `familyId` INTEGER NOT NULL, `name` TEXT NOT NULL, `priceCents` INTEGER NOT NULL, `allergens` TEXT, `printerRoute` TEXT NOT NULL, `active` INTEGER NOT NULL, `sortOrder` INTEGER NOT NULL)")
        db.execSQL("CREATE UNIQUE INDEX IF NOT EXISTS `index_products_familyId_name` ON `products` (`familyId`, `name`)")
        db.execSQL("CREATE TABLE IF NOT EXISTS room_master_table (id INTEGER PRIMARY KEY,identity_hash TEXT)")
        db.execSQL("INSERT OR REPLACE INTO room_master_table (id,identity_hash) VALUES(42, '831946bb6cd2a600b2b5643fb9e26b66')")
      }

      public override fun dropAllTables(db: SupportSQLiteDatabase) {
        db.execSQL("DROP TABLE IF EXISTS `users`")
        db.execSQL("DROP TABLE IF EXISTS `zones`")
        db.execSQL("DROP TABLE IF EXISTS `tables`")
        db.execSQL("DROP TABLE IF EXISTS `families`")
        db.execSQL("DROP TABLE IF EXISTS `products`")
        val _callbacks: List<RoomDatabase.Callback>? = mCallbacks
        if (_callbacks != null) {
          for (_callback: RoomDatabase.Callback in _callbacks) {
            _callback.onDestructiveMigration(db)
          }
        }
      }

      public override fun onCreate(db: SupportSQLiteDatabase) {
        val _callbacks: List<RoomDatabase.Callback>? = mCallbacks
        if (_callbacks != null) {
          for (_callback: RoomDatabase.Callback in _callbacks) {
            _callback.onCreate(db)
          }
        }
      }

      public override fun onOpen(db: SupportSQLiteDatabase) {
        mDatabase = db
        db.execSQL("PRAGMA foreign_keys = ON")
        internalInitInvalidationTracker(db)
        val _callbacks: List<RoomDatabase.Callback>? = mCallbacks
        if (_callbacks != null) {
          for (_callback: RoomDatabase.Callback in _callbacks) {
            _callback.onOpen(db)
          }
        }
      }

      public override fun onPreMigrate(db: SupportSQLiteDatabase) {
        dropFtsSyncTriggers(db)
      }

      public override fun onPostMigrate(db: SupportSQLiteDatabase) {
      }

      public override fun onValidateSchema(db: SupportSQLiteDatabase):
          RoomOpenHelper.ValidationResult {
        val _columnsUsers: HashMap<String, TableInfo.Column> = HashMap<String, TableInfo.Column>(3)
        _columnsUsers.put("username", TableInfo.Column("username", "TEXT", true, 1, null,
            TableInfo.CREATED_FROM_ENTITY))
        _columnsUsers.put("password", TableInfo.Column("password", "TEXT", true, 0, null,
            TableInfo.CREATED_FROM_ENTITY))
        _columnsUsers.put("role", TableInfo.Column("role", "TEXT", true, 0, null,
            TableInfo.CREATED_FROM_ENTITY))
        val _foreignKeysUsers: HashSet<TableInfo.ForeignKey> = HashSet<TableInfo.ForeignKey>(0)
        val _indicesUsers: HashSet<TableInfo.Index> = HashSet<TableInfo.Index>(0)
        val _infoUsers: TableInfo = TableInfo("users", _columnsUsers, _foreignKeysUsers,
            _indicesUsers)
        val _existingUsers: TableInfo = read(db, "users")
        if (!_infoUsers.equals(_existingUsers)) {
          return RoomOpenHelper.ValidationResult(false, """
              |users(com.gerardo.myapplication.data.entities.User).
              | Expected:
              |""".trimMargin() + _infoUsers + """
              |
              | Found:
              |""".trimMargin() + _existingUsers)
        }
        val _columnsZones: HashMap<String, TableInfo.Column> = HashMap<String, TableInfo.Column>(5)
        _columnsZones.put("id", TableInfo.Column("id", "INTEGER", true, 1, null,
            TableInfo.CREATED_FROM_ENTITY))
        _columnsZones.put("name", TableInfo.Column("name", "TEXT", true, 0, null,
            TableInfo.CREATED_FROM_ENTITY))
        _columnsZones.put("active", TableInfo.Column("active", "INTEGER", true, 0, null,
            TableInfo.CREATED_FROM_ENTITY))
        _columnsZones.put("sortOrder", TableInfo.Column("sortOrder", "INTEGER", true, 0, null,
            TableInfo.CREATED_FROM_ENTITY))
        _columnsZones.put("createdAt", TableInfo.Column("createdAt", "INTEGER", true, 0, null,
            TableInfo.CREATED_FROM_ENTITY))
        val _foreignKeysZones: HashSet<TableInfo.ForeignKey> = HashSet<TableInfo.ForeignKey>(0)
        val _indicesZones: HashSet<TableInfo.Index> = HashSet<TableInfo.Index>(1)
        _indicesZones.add(TableInfo.Index("index_zones_name", true, listOf("name"), listOf("ASC")))
        val _infoZones: TableInfo = TableInfo("zones", _columnsZones, _foreignKeysZones,
            _indicesZones)
        val _existingZones: TableInfo = read(db, "zones")
        if (!_infoZones.equals(_existingZones)) {
          return RoomOpenHelper.ValidationResult(false, """
              |zones(com.gerardo.myapplication.data.entities.Zone).
              | Expected:
              |""".trimMargin() + _infoZones + """
              |
              | Found:
              |""".trimMargin() + _existingZones)
        }
        val _columnsTables: HashMap<String, TableInfo.Column> = HashMap<String, TableInfo.Column>(5)
        _columnsTables.put("id", TableInfo.Column("id", "INTEGER", true, 1, null,
            TableInfo.CREATED_FROM_ENTITY))
        _columnsTables.put("zoneId", TableInfo.Column("zoneId", "INTEGER", true, 0, null,
            TableInfo.CREATED_FROM_ENTITY))
        _columnsTables.put("number", TableInfo.Column("number", "INTEGER", true, 0, null,
            TableInfo.CREATED_FROM_ENTITY))
        _columnsTables.put("status", TableInfo.Column("status", "TEXT", true, 0, null,
            TableInfo.CREATED_FROM_ENTITY))
        _columnsTables.put("updatedAt", TableInfo.Column("updatedAt", "INTEGER", true, 0, null,
            TableInfo.CREATED_FROM_ENTITY))
        val _foreignKeysTables: HashSet<TableInfo.ForeignKey> = HashSet<TableInfo.ForeignKey>(1)
        _foreignKeysTables.add(TableInfo.ForeignKey("zones", "CASCADE", "NO ACTION",
            listOf("zoneId"), listOf("id")))
        val _indicesTables: HashSet<TableInfo.Index> = HashSet<TableInfo.Index>(2)
        _indicesTables.add(TableInfo.Index("index_tables_zoneId", false, listOf("zoneId"),
            listOf("ASC")))
        _indicesTables.add(TableInfo.Index("index_tables_zoneId_number", true, listOf("zoneId",
            "number"), listOf("ASC", "ASC")))
        val _infoTables: TableInfo = TableInfo("tables", _columnsTables, _foreignKeysTables,
            _indicesTables)
        val _existingTables: TableInfo = read(db, "tables")
        if (!_infoTables.equals(_existingTables)) {
          return RoomOpenHelper.ValidationResult(false, """
              |tables(com.gerardo.myapplication.data.entities.Table).
              | Expected:
              |""".trimMargin() + _infoTables + """
              |
              | Found:
              |""".trimMargin() + _existingTables)
        }
        val _columnsFamilies: HashMap<String, TableInfo.Column> =
            HashMap<String, TableInfo.Column>(5)
        _columnsFamilies.put("id", TableInfo.Column("id", "INTEGER", true, 1, null,
            TableInfo.CREATED_FROM_ENTITY))
        _columnsFamilies.put("name", TableInfo.Column("name", "TEXT", true, 0, null,
            TableInfo.CREATED_FROM_ENTITY))
        _columnsFamilies.put("type", TableInfo.Column("type", "TEXT", true, 0, null,
            TableInfo.CREATED_FROM_ENTITY))
        _columnsFamilies.put("active", TableInfo.Column("active", "INTEGER", true, 0, null,
            TableInfo.CREATED_FROM_ENTITY))
        _columnsFamilies.put("sortOrder", TableInfo.Column("sortOrder", "INTEGER", true, 0, null,
            TableInfo.CREATED_FROM_ENTITY))
        val _foreignKeysFamilies: HashSet<TableInfo.ForeignKey> = HashSet<TableInfo.ForeignKey>(0)
        val _indicesFamilies: HashSet<TableInfo.Index> = HashSet<TableInfo.Index>(1)
        _indicesFamilies.add(TableInfo.Index("index_families_name", true, listOf("name"),
            listOf("ASC")))
        val _infoFamilies: TableInfo = TableInfo("families", _columnsFamilies, _foreignKeysFamilies,
            _indicesFamilies)
        val _existingFamilies: TableInfo = read(db, "families")
        if (!_infoFamilies.equals(_existingFamilies)) {
          return RoomOpenHelper.ValidationResult(false, """
              |families(com.gerardo.myapplication.data.entities.Family).
              | Expected:
              |""".trimMargin() + _infoFamilies + """
              |
              | Found:
              |""".trimMargin() + _existingFamilies)
        }
        val _columnsProducts: HashMap<String, TableInfo.Column> =
            HashMap<String, TableInfo.Column>(8)
        _columnsProducts.put("id", TableInfo.Column("id", "INTEGER", true, 1, null,
            TableInfo.CREATED_FROM_ENTITY))
        _columnsProducts.put("familyId", TableInfo.Column("familyId", "INTEGER", true, 0, null,
            TableInfo.CREATED_FROM_ENTITY))
        _columnsProducts.put("name", TableInfo.Column("name", "TEXT", true, 0, null,
            TableInfo.CREATED_FROM_ENTITY))
        _columnsProducts.put("priceCents", TableInfo.Column("priceCents", "INTEGER", true, 0, null,
            TableInfo.CREATED_FROM_ENTITY))
        _columnsProducts.put("allergens", TableInfo.Column("allergens", "TEXT", false, 0, null,
            TableInfo.CREATED_FROM_ENTITY))
        _columnsProducts.put("printerRoute", TableInfo.Column("printerRoute", "TEXT", true, 0, null,
            TableInfo.CREATED_FROM_ENTITY))
        _columnsProducts.put("active", TableInfo.Column("active", "INTEGER", true, 0, null,
            TableInfo.CREATED_FROM_ENTITY))
        _columnsProducts.put("sortOrder", TableInfo.Column("sortOrder", "INTEGER", true, 0, null,
            TableInfo.CREATED_FROM_ENTITY))
        val _foreignKeysProducts: HashSet<TableInfo.ForeignKey> = HashSet<TableInfo.ForeignKey>(0)
        val _indicesProducts: HashSet<TableInfo.Index> = HashSet<TableInfo.Index>(1)
        _indicesProducts.add(TableInfo.Index("index_products_familyId_name", true,
            listOf("familyId", "name"), listOf("ASC", "ASC")))
        val _infoProducts: TableInfo = TableInfo("products", _columnsProducts, _foreignKeysProducts,
            _indicesProducts)
        val _existingProducts: TableInfo = read(db, "products")
        if (!_infoProducts.equals(_existingProducts)) {
          return RoomOpenHelper.ValidationResult(false, """
              |products(com.gerardo.myapplication.data.entities.Product).
              | Expected:
              |""".trimMargin() + _infoProducts + """
              |
              | Found:
              |""".trimMargin() + _existingProducts)
        }
        return RoomOpenHelper.ValidationResult(true, null)
      }
    }, "831946bb6cd2a600b2b5643fb9e26b66", "e42d0d39fa9bfb3cd1261279b15cc64e")
    val _sqliteConfig: SupportSQLiteOpenHelper.Configuration =
        SupportSQLiteOpenHelper.Configuration.builder(config.context).name(config.name).callback(_openCallback).build()
    val _helper: SupportSQLiteOpenHelper = config.sqliteOpenHelperFactory.create(_sqliteConfig)
    return _helper
  }

  protected override fun createInvalidationTracker(): InvalidationTracker {
    val _shadowTablesMap: HashMap<String, String> = HashMap<String, String>(0)
    val _viewTables: HashMap<String, Set<String>> = HashMap<String, Set<String>>(0)
    return InvalidationTracker(this, _shadowTablesMap, _viewTables,
        "users","zones","tables","families","products")
  }

  public override fun clearAllTables() {
    super.assertNotMainThread()
    val _db: SupportSQLiteDatabase = super.openHelper.writableDatabase
    val _supportsDeferForeignKeys: Boolean = android.os.Build.VERSION.SDK_INT >=
        android.os.Build.VERSION_CODES.LOLLIPOP
    try {
      if (!_supportsDeferForeignKeys) {
        _db.execSQL("PRAGMA foreign_keys = FALSE")
      }
      super.beginTransaction()
      if (_supportsDeferForeignKeys) {
        _db.execSQL("PRAGMA defer_foreign_keys = TRUE")
      }
      _db.execSQL("DELETE FROM `users`")
      _db.execSQL("DELETE FROM `zones`")
      _db.execSQL("DELETE FROM `tables`")
      _db.execSQL("DELETE FROM `families`")
      _db.execSQL("DELETE FROM `products`")
      super.setTransactionSuccessful()
    } finally {
      super.endTransaction()
      if (!_supportsDeferForeignKeys) {
        _db.execSQL("PRAGMA foreign_keys = TRUE")
      }
      _db.query("PRAGMA wal_checkpoint(FULL)").close()
      if (!_db.inTransaction()) {
        _db.execSQL("VACUUM")
      }
    }
  }

  protected override fun getRequiredTypeConverters(): Map<Class<out Any>, List<Class<out Any>>> {
    val _typeConvertersMap: HashMap<Class<out Any>, List<Class<out Any>>> =
        HashMap<Class<out Any>, List<Class<out Any>>>()
    _typeConvertersMap.put(UserDao::class.java, UserDao_Impl.getRequiredConverters())
    _typeConvertersMap.put(ZoneDao::class.java, ZoneDao_Impl.getRequiredConverters())
    _typeConvertersMap.put(TableDao::class.java, TableDao_Impl.getRequiredConverters())
    _typeConvertersMap.put(FamilyDao::class.java, FamilyDao_Impl.getRequiredConverters())
    _typeConvertersMap.put(ProductDao::class.java, ProductDao_Impl.getRequiredConverters())
    return _typeConvertersMap
  }

  public override fun getRequiredAutoMigrationSpecs(): Set<Class<out AutoMigrationSpec>> {
    val _autoMigrationSpecsSet: HashSet<Class<out AutoMigrationSpec>> =
        HashSet<Class<out AutoMigrationSpec>>()
    return _autoMigrationSpecsSet
  }

  public override
      fun getAutoMigrations(autoMigrationSpecs: Map<Class<out AutoMigrationSpec>, AutoMigrationSpec>):
      List<Migration> {
    val _autoMigrations: MutableList<Migration> = ArrayList<Migration>()
    return _autoMigrations
  }

  public override fun userDao(): UserDao = _userDao.value

  public override fun zoneDao(): ZoneDao = _zoneDao.value

  public override fun tableDao(): TableDao = _tableDao.value

  public override fun familyDao(): FamilyDao = _familyDao.value

  public override fun productDao(): ProductDao = _productDao.value
}
