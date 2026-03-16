<template>
  <nav class="crm-nav">
    <div class="nav-brand">
      <div class="brand-logo">
        <svg xmlns="http://www.w3.org/2000/svg" width="22" height="22" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round">
          <path d="M21 16V8a2 2 0 0 0-1-1.73l-7-4a2 2 0 0 0-2 0l-7-4A2 2 0 0 0 3 8v8a2 2 0 0 0 1 1.73l7 4a2 2 0 0 0 2 0l7-4A2 2 0 0 0 21 16z"></path>
          <polyline points="3.27 6.96 12 12.01 20.73 6.96"></polyline>
          <line x1="12" y1="22.08" x2="12" y2="12"></line>
        </svg>
      </div>
      <span>CRM Comercial</span>
    </div>
    
    <ul class="nav-menu">
      <li v-if="usuario.rol !== 'Lector'">
        <a href="#" class="nav-link" @click.prevent="$emit('abrir-registro')">
          <svg class="nav-icon" xmlns="http://www.w3.org/2000/svg" width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
            <line x1="12" y1="5" x2="12" y2="19"></line>
            <line x1="5" y1="12" x2="19" y2="12"></line>
          </svg>
          Nuevo Prospecto
        </a>
      </li>
      <li>
        <a href="#" class="nav-link" @click.prevent="$emit('abrir-reportes')">
          <svg class="nav-icon" xmlns="http://www.w3.org/2000/svg" width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
            <line x1="18" y1="20" x2="18" y2="10"></line>
            <line x1="12" y1="20" x2="12" y2="4"></line>
            <line x1="6" y1="20" x2="6" y2="14"></line>
          </svg>
          Reportes
        </a>
      </li>
    </ul>

    <div class="nav-user-section">
      <UserDropdown 
        :usuario="usuario" 
        @cerrar-sesion="$emit('cerrar-sesion')"
        @abrir-configuracion="$emit('abrir-configuracion')"
        @toggle-tema="$emit('toggle-tema')"
      />
    </div>
  </nav>
</template>

<script setup>
import UserDropdown from './UserDropdown.vue';

defineProps({
  usuario: {
    type: Object,
    required: true
  }
});

defineEmits(['abrir-registro', 'abrir-reportes', 'cerrar-sesion', 'abrir-configuracion', 'toggle-tema']);
</script>

<style scoped>
/* --- CONTENEDOR PRINCIPAL --- */
.crm-nav {
  background-color: rgba(255, 255, 255, 0.85);
  backdrop-filter: blur(12px);
  -webkit-backdrop-filter: blur(12px);
  border-bottom: 1px solid var(--border-color);
  display: flex; justify-content: space-between; align-items: center;
  padding: 0 32px; height: 72px;
  position: fixed; top: 0; left: 0; width: 100%; box-sizing: border-box; z-index: 900;
  box-shadow: var(--shadow-sm);
}

/* --- LOGO Y MARCA --- */
.nav-brand {
  font-size: 1.25rem; font-weight: 700; color: var(--text-main); 
  display: flex; align-items: center; gap: 12px;
  letter-spacing: -0.025em;
}
.brand-logo {
  display: flex; align-items: center; justify-content: center;
  width: 36px; height: 36px;
  background: linear-gradient(135deg, var(--primary) 0%, #6366f1 100%);
  color: white; border-radius: 10px;
  box-shadow: 0 4px 6px -1px rgba(79, 70, 229, 0.2);
}

/* --- MENÚ CENTRAL --- */
.nav-menu { list-style: none; display: flex; gap: 8px; margin: 0; padding: 0; }
.nav-link {
  display: flex; align-items: center; gap: 8px;
  color: var(--text-muted); text-decoration: none; font-weight: 500; font-size: 0.95rem;
  padding: 8px 16px; border-radius: var(--radius-md); transition: all 0.2s ease;
}
.nav-icon { transition: transform 0.2s ease; }
.nav-link:hover { background-color: #f1f5f9; color: var(--primary); }
.nav-link:hover .nav-icon { transform: scale(1.1); } 

/* --- SECCIÓN DE USUARIO --- */
.nav-user-section { 
  display: flex; 
  align-items: center; 
}
</style>