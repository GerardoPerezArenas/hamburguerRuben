package com.gerardo.myapplication.data.repository

import android.content.Context
import android.content.SharedPreferences
import com.gerardo.myapplication.data.database.AppDatabase
import com.gerardo.myapplication.data.entities.User

class SessionRepository(context: Context) {
    private val userDao = AppDatabase.getDatabase(context).userDao()
    private val prefs: SharedPreferences =
        context.getSharedPreferences("session_prefs", Context.MODE_PRIVATE)

    private var currentUser: User? = loadUserFromPrefs()

    suspend fun login(username: String, password: String): LoginResult {
        return try {
            val user = userDao.authenticateUser(username, password)
            if (user != null) {
                currentUser = user
                saveUserToPrefs(user)
                LoginResult.Success(user)
            } else {
                LoginResult.Error("Usuario o contraseña incorrectos")
            }
        } catch (e: Exception) {
            LoginResult.Error("Error de conexión: ${e.message}")
        }
    }

    fun getCurrentUser(): User? = currentUser

    fun isLoggedIn(): Boolean = currentUser != null

    fun logout() {
        currentUser = null
        prefs.edit().clear().apply()
    }

    fun isAdmin(): Boolean = currentUser?.role == "ADMIN"

    private fun saveUserToPrefs(user: User) {
        prefs.edit()
            .putString(KEY_USERNAME, user.username)
            .putString(KEY_ROLE, user.role)
            .apply()
    }

    private fun loadUserFromPrefs(): User? {
        val username = prefs.getString(KEY_USERNAME, null)
        val role = prefs.getString(KEY_ROLE, null)
        return if (username != null && role != null) {
            // No persistimos la contraseña; no es necesaria para la sesión en memoria
            User(username = username, password = "", role = role)
        } else null
    }

    companion object {
        private const val KEY_USERNAME = "username"
        private const val KEY_ROLE = "role"
    }
}

sealed class LoginResult {
    data class Success(val user: User) : LoginResult()
    data class Error(val message: String) : LoginResult()
}
