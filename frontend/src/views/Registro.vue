<template>
  <div class="login-container">
    <div class="bg-shape shape-1"></div>
    <div class="bg-shape shape-2"></div>

    <div class="login-card fade-in-up" style="max-width: 480px;">
      <div class="brand-header">
        <div class="logo-icon">
          <svg xmlns="http://www.w3.org/2000/svg" width="28" height="28" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
            <path d="M16 21v-2a4 4 0 0 0-4-4H5a4 4 0 0 0-4 4v2"></path>
            <circle cx="8.5" cy="7" r="4"></circle>
            <line x1="20" y1="8" x2="20" y2="14"></line>
            <line x1="23" y1="11" x2="17" y2="11"></line>
          </svg>
        </div>
        <h2>Crear nueva cuenta</h2>
        <p>Registra un nuevo usuario en el sistema</p>
      </div>
      
      <form @submit.prevent="registrarUsuario" class="login-form">
        <div class="input-group">
          <label>Nombre Completo</label>
          <div class="input-wrapper">
            <svg class="input-icon" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
              <path d="M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2"></path>
              <circle cx="12" cy="7" r="4"></circle>
            </svg>
            <input type="text" v-model="form.nombre" required placeholder="Ej. Ana Pérez" />
          </div>
        </div>

        <div class="input-group">
          <label>Correo Electrónico</label>
          <div class="input-wrapper">
            <svg class="input-icon" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
              <path d="M4 4h16c1.1 0 2 .9 2 2v12c0 1.1-.9 2-2 2H4c-1.1 0-2-.9-2-2V6c0-1.1.9-2 2-2z"></path>
              <polyline points="22,6 12,13 2,6"></polyline>
            </svg>
            <input type="email" v-model="form.email" required placeholder="ana@empresa.com" />
          </div>
        </div>
        
        <div class="input-group">
          <label>Contraseña</label>
          <div class="input-wrapper">
            <svg class="input-icon" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
              <rect x="3" y="11" width="18" height="11" rx="2" ry="2"></rect>
              <path d="M7 11V7a5 5 0 0 1 10 0v4"></path>
            </svg>
            <input type="password" v-model="form.password" required placeholder="••••••••" />
          </div>
        </div>

        <div class="input-group">
          <label>Rol del Usuario</label>
          <div class="input-wrapper">
            <svg class="input-icon" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
              <path d="M12 22s8-4 8-10V5l-8-3-8 3v7c0 6 8 10 8 10z"></path>
            </svg>
            <select v-model="form.id_rol" required>
              <option value="1">Administrador (Control total)</option>
              <option value="2">Asesor (Puede mover tarjetas)</option>
              <option value="3">Lector (Solo vista)</option>
            </select>
          </div>
        </div>

        <div v-if="mensaje" :class="[esError ? 'error-msg shake' : 'success-msg']">
          <svg v-if="esError" xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
            <circle cx="12" cy="12" r="10"></circle>
            <line x1="12" y1="8" x2="12" y2="12"></line>
            <line x1="12" y1="16" x2="12.01" y2="16"></line>
          </svg>
          <svg v-else xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
            <path d="M22 11.08V12a10 10 0 1 1-5.93-9.14"></path>
            <polyline points="22 4 12 14.01 9 11.01"></polyline>
          </svg>
          <span>{{ mensaje }}</span>
        </div>

        <button type="submit" class="btn-primary" style="margin-top: 8px;">
          <span>Registrar Usuario</span>
          <svg class="btn-icon" xmlns="http://www.w3.org/2000/svg" width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
            <line x1="5" y1="12" x2="19" y2="12"></line>
            <polyline points="12 5 19 12 12 19"></polyline>
          </svg>
        </button>
        
        <div class="register-link">
          <span class="text-muted">¿Ya tienes una cuenta?</span>
          <router-link to="/login" class="link-primary">Inicia sesión</router-link>
        </div>
      </form>
    </div>
  </div>
</template>

<script setup>
import { ref } from 'vue';
import { useRouter } from 'vue-router';
import api from '../services/api';

const router = useRouter();
const form = ref({ nombre: '', email: '', password: '', id_rol: '2' });
const mensaje = ref('');
const esError = ref(false);

const registrarUsuario = async () => {
  mensaje.value = '';
  try {
    await api.register(form.value);
    esError.value = false;
    mensaje.value = '¡Usuario registrado con éxito! Redirigiendo...';
    setTimeout(() => router.push('/login'), 2000);
  } catch (err) {
    esError.value = true;
    mensaje.value = err.response?.data?.error || 'Error al registrar usuario';
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
  padding: 20px;
}

/* --- Fondo decorativo SaaS --- */
.bg-shape { position: absolute; border-radius: 50%; filter: blur(80px); z-index: 0; opacity: 0.5; }
.shape-1 { width: 400px; height: 400px; background: #e0e7ff; top: -100px; left: -100px; }
.shape-2 { width: 300px; height: 300px; background: #fce7f3; bottom: -50px; right: -50px; }

/* --- Tarjeta Auth --- */
.login-card {
  background: var(--bg-surface); padding: 48px 40px; border-radius: 20px;
  box-shadow: var(--shadow-lg); width: 100%; z-index: 1;
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
.register-link { text-align: center; margin-top: 8px; font-size: 0.9rem; }

/* Mensaje de Éxito Local (El de error ya está en style.css global) */
.success-msg {
  display: flex; align-items: center; gap: 8px;
  background-color: #ecfdf5; color: #059669;
  padding: 10px 14px; border-radius: var(--radius-md);
  font-size: 0.85rem; font-weight: 500; border: 1px solid #a7f3d0;
  animation: slideUp 0.3s ease-out;
}

/* Ajuste específico para el select con ícono */
select { cursor: pointer; appearance: none; }
</style>