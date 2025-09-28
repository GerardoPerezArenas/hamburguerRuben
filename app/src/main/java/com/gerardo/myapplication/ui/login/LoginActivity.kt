package com.gerardo.myapplication.ui.login

import android.content.Intent
import android.os.Bundle
import android.view.View
import android.widget.Button
import android.widget.TextView
import android.widget.Toast
import androidx.appcompat.app.AppCompatActivity
import androidx.lifecycle.lifecycleScope
import com.gerardo.myapplication.R
import com.gerardo.myapplication.data.repository.LoginResult
import com.gerardo.myapplication.data.repository.SessionRepository
import com.gerardo.myapplication.ui.zones.ZonesActivity
import com.google.android.material.textfield.TextInputEditText
import kotlinx.coroutines.launch

class LoginActivity : AppCompatActivity() {
    private lateinit var sessionRepository: SessionRepository

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        sessionRepository = SessionRepository(this)

        setContentView(R.layout.activity_login)

        Toast.makeText(this, "Pantalla de login cargada", Toast.LENGTH_SHORT).show()

        val etUsername = findViewById<TextInputEditText>(R.id.etUsername)
        val etPassword = findViewById<TextInputEditText>(R.id.etPassword)
        val btnLogin = findViewById<Button>(R.id.btnLogin)
        val tvError = findViewById<TextView>(R.id.tvError)

        btnLogin.setOnClickListener {
            val username = etUsername.text?.toString()?.trim().orEmpty()
            val password = etPassword.text?.toString()?.trim().orEmpty()

            if (username.isEmpty() || password.isEmpty()) {
                tvError.text = "Por favor, complete todos los campos"
                tvError.visibility = View.VISIBLE
                return@setOnClickListener
            }

            tvError.visibility = View.GONE
            btnLogin.isEnabled = false

            lifecycleScope.launch {
                when (val res = sessionRepository.login(username, password)) {
                    is LoginResult.Success -> {
                        startActivity(Intent(this@LoginActivity, ZonesActivity::class.java))
                        finish()
                    }
                    is LoginResult.Error -> {
                        btnLogin.isEnabled = true
                        tvError.text = res.message
                        tvError.visibility = View.VISIBLE
                    }
                }
            }
        }
    }
}
