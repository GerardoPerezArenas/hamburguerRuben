package com.gerardo.myapplication.ui.login

import android.app.Application
import androidx.lifecycle.AndroidViewModel
import androidx.lifecycle.viewModelScope
import com.gerardo.myapplication.data.repository.LoginResult
import com.gerardo.myapplication.data.repository.SessionRepository
import kotlinx.coroutines.flow.MutableStateFlow
import kotlinx.coroutines.flow.StateFlow
import kotlinx.coroutines.launch

class LoginViewModel(application: Application) : AndroidViewModel(application) {
    private val sessionRepository = SessionRepository(application)

    private val _loginState = MutableStateFlow<LoginState>(LoginState.Idle)
    val loginState: StateFlow<LoginState> = _loginState

    fun login(username: String, password: String) {
        viewModelScope.launch {
            _loginState.value = LoginState.Loading

            when (val result = sessionRepository.login(username, password)) {
                is LoginResult.Success -> {
                    _loginState.value = LoginState.Success(result.user.role)
                }
                is LoginResult.Error -> {
                    _loginState.value = LoginState.Error(result.message)
                }
            }
        }
    }
}

sealed class LoginState {
    object Idle : LoginState()
    object Loading : LoginState()
    data class Success(val userRole: String) : LoginState()
    data class Error(val message: String) : LoginState()
}
