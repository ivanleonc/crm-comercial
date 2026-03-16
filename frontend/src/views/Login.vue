<template>
  <div class="login-container">
    <div class="bg-shape shape-1"></div>
    <div class="bg-shape shape-2"></div>

    <div class="login-card fade-in-up">
      <div class="brand-header">
        <div class="logo-icon">
          <svg xmlns="http://www.w3.org/2000/svg" width="28" height="28" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
            <rect x="3" y="3" width="7" height="7"></rect>
            <rect x="14" y="3" width="7" height="7"></rect>
            <rect x="14" y="14" width="7" height="7"></rect>
            <path d="M3 14h7v7H3z"></path>
          </svg>
        </div>
        <h2>Bienvenido de nuevo</h2>
        <p>Ingresa a tu cuenta de CRM Comercial</p>
      </div>
      
      <form @submit.prevent="hacerLogin" class="login-form">
        <div class="input-group">
          <label for="email">Correo Electrónico</label>
          <div class="input-wrapper">
            <svg class="input-icon" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
              <path d="M4 4h16c1.1 0 2 .9 2 2v12c0 1.1-.9 2-2 2H4c-1.1 0-2-.9-2-2V6c0-1.1.9-2 2-2z"></path>
              <polyline points="22,6 12,13 2,6"></polyline>
            </svg>
            <input type="email" id="email" v-model="email" required placeholder="tu@empresa.com" />
          </div>
        </div>
        
        <div class="input-group">
          <label for="password">Contraseña</label>
          <div class="input-wrapper">
            <svg class="input-icon" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
              <rect x="3" y="11" width="18" height="11" rx="2" ry="2"></rect>
              <path d="M7 11V7a5 5 0 0 1 10 0v4"></path>
            </svg>
            <input type="password" id="password" v-model="password" required placeholder="••••••••" />
          </div>
        </div>

        <div v-if="error" class="error-msg shake">
          <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
            <circle cx="12" cy="12" r="10"></circle>
            <line x1="12" y1="8" x2="12" y2="12"></line>
            <line x1="12" y1="16" x2="12.01" y2="16"></line>
          </svg>
          <span>{{ error }}</span>
        </div>

        <button type="submit" class="btn-primary">
          <span>Ingresar al sistema</span>
          <svg class="btn-icon" xmlns="http://www.w3.org/2000/svg" width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
            <line x1="5" y1="12" x2="19" y2="12"></line>
            <polyline points="12 5 19 12 12 19"></polyline>
          </svg>
        </button>
        
        <div class="register-link">
          <span class="text-muted">¿No tienes cuenta?</span>
          <router-link to="/registro" class="link-primary">Regístrate aquí</router-link>
        </div>
      </form>
    </div>
  </div>
</template>

<script setup>
import { ref } from 'vue';
import { useRouter } from 'vue-router';
import api from '../services/api'; 

const email = ref('');
const password = ref('');
const error = ref('');
const router = useRouter();

const hacerLogin = async () => {
  error.value = ''; 
  try {
    const data = await api.login({ email: email.value, password: password.value });

    // Guardamos el token
    localStorage.setItem('token', data.token);
    localStorage.setItem('usuario', JSON.stringify(data.usuario));
    
    // Redirigimos al Kanban
    router.push('/');
  } catch (err) {
    error.value = err.response?.data?.error || 'Error al conectar con el servidor'; 
  }
};
</script>

<style scoped>
/* Contenedor principal del Auth (Sobrescribe el padding global del body para centrar perfecto) */
.login-container {
  display: flex; justify-content: center; align-items: center;
  min-height: 100vh;
  margin-top: -80px; /* Compensa el padding-top del body global */
  position: relative; overflow: hidden;
}

/* --- Fondo decorativo SaaS exclusivo del Login --- */
.bg-shape { position: absolute; border-radius: 50%; filter: blur(80px); z-index: 0; opacity: 0.5; }
.shape-1 { width: 400px; height: 400px; background: #e0e7ff; top: -100px; left: -100px; }
.shape-2 { width: 300px; height: 300px; background: #fce7f3; bottom: -50px; right: -50px; }

/* --- Tarjeta Auth --- */
.login-card {
  background: var(--bg-surface); padding: 48px 40px; border-radius: 20px;
  box-shadow: var(--shadow-lg); width: 100%; max-width: 420px; z-index: 1;
  border: 1px solid rgba(255,255,255,0.8); backdrop-filter: blur(10px);
}

/* --- Encabezado Auth --- */
.brand-header { text-align: center; margin-bottom: 32px; }
.logo-icon {
  display: inline-flex; justify-content: center; align-items: center;
  width: 56px; height: 56px; background: linear-gradient(135deg, #e0e7ff 0%, #c7d2fe 100%);
  color: var(--primary); border-radius: 16px; margin-bottom: 16px;
  box-shadow: 0 4px 6px -1px rgba(79, 70, 229, 0.1);
}
.brand-header h2 { margin: 0 0 8px 0; color: var(--text-main); font-size: 1.5rem; font-weight: 700; letter-spacing: -0.025em; }
.brand-header p { margin: 0; color: var(--text-muted); font-size: 0.95rem; }

/* Layout del form interno */
.login-form { display: flex; flex-direction: column; gap: 20px; }
.input-group label { display: block; margin-bottom: 8px; font-weight: 600; font-size: 0.85rem; color: var(--text-main); }
.register-link { text-align: center; margin-top: 8px; font-size: 0.9rem; margin-left: 6px;}
</style>