package com.gerardo.myapplication

import android.content.Intent
import android.os.Bundle
import androidx.appcompat.app.AppCompatActivity
import com.gerardo.myapplication.data.repository.SessionRepository
import com.gerardo.myapplication.databinding.ActivityMainBinding
import com.gerardo.myapplication.ui.login.LoginActivity

class MainActivity : AppCompatActivity() {
    private lateinit var binding: ActivityMainBinding
    private lateinit var sessionRepository: SessionRepository

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        sessionRepository = SessionRepository(this)

        // Verificar si el usuario está logueado
        if (!sessionRepository.isLoggedIn()) {
            startActivity(Intent(this, LoginActivity::class.java))
            finish()
            return
        }

        binding = ActivityMainBinding.inflate(layoutInflater)
        setContentView(binding.root)

        setupUI()
    }

    private fun setupUI() {
        val currentUser = sessionRepository.getCurrentUser()
        currentUser?.let { user ->
            binding.tvWelcome.text = "¡Bienvenido, ${user.username}!"
            binding.tvUserInfo.text = "Usuario: ${user.username} (${user.role})"
        }

        binding.btnLogout.setOnClickListener {
            sessionRepository.logout()
            startActivity(Intent(this, LoginActivity::class.java))
            finish()
        }
    }
}