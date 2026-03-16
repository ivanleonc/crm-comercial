<template>
  <div class="dropdown-container" @click.stop="toggleDropdown" v-click-outside="closeDropdown">
    
    <button class="profile-trigger" :class="{ 'is-active': isOpen }">
      <div class="avatar">
        {{ iniciales }}
      </div>
      <div class="user-info">
        <span class="user-name">{{ usuario.nombre }}</span>
        <span class="user-role">{{ usuario.rol }}</span>
      </div>
      <svg class="chevron-icon" :class="{ 'rotate': isOpen }" xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
        <polyline points="6 9 12 15 18 9"></polyline>
      </svg>
    </button>

    <transition name="dropdown-fade">
      <div v-if="isOpen" class="dropdown-menu">
        <div class="dropdown-header">
          <p class="header-name">{{ usuario.nombre }}</p>
          <p class="header-email">{{ usuario.email || 'usuario@crm.com' }}</p>
        </div>

        <div class="dropdown-divider"></div>

        <ul class="dropdown-list">
          <li>
            <button class="dropdown-item" @click.stop="$emit('abrir-configuracion'); closeDropdown()">
              <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><circle cx="12" cy="12" r="3"></circle><path d="M19.4 15a1.65 1.65 0 0 0 .33 1.82l.06.06a2 2 0 0 1 0 2.83 2 2 0 0 1-2.83 0l-.06-.06a1.65 1.65 0 0 0-1.82-.33 1.65 1.65 0 0 0-1 1.51V21a2 2 0 0 1-2 2 2 2 0 0 1-2-2v-.09A1.65 1.65 0 0 0 9 19.4a1.65 1.65 0 0 0-1.82.33l-.06.06a2 2 0 0 1-2.83 0 2 2 0 0 1 0-2.83l.06-.06a1.65 1.65 0 0 0 .33-1.82 1.65 1.65 0 0 0-1.51-1H3a2 2 0 0 1-2-2 2 2 0 0 1 2-2h.09A1.65 1.65 0 0 0 4.6 9a1.65 1.65 0 0 0-.33-1.82l-.06-.06a2 2 0 0 1 0-2.83 2 2 0 0 1 2.83 0l.06.06a1.65 1.65 0 0 0 1.82.33H9a1.65 1.65 0 0 0 1-1.51V3a2 2 0 0 1 2-2 2 2 0 0 1 2 2v.09a1.65 1.65 0 0 0 1 1.51 1.65 1.65 0 0 0 1.82-.33l.06-.06a2 2 0 0 1 2.83 0 2 2 0 0 1 0 2.83l-.06.06a1.65 1.65 0 0 0-.33 1.82V9a1.65 1.65 0 0 0 1.51 1H21a2 2 0 0 1 2 2 2 2 0 0 1-2 2h-.09a1.65 1.65 0 0 0-1.51 1z"></path></svg>
              Configuración
            </button>
          </li>
          <li>
            <button class="dropdown-item" @click.stop="$emit('toggle-tema'); closeDropdown()">
              <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M21 12.79A9 9 0 1 1 11.21 3 7 7 0 0 0 21 12.79z"></path></svg>
              Modo Oscuro
            </button>
          </li>
        </ul>

        <div class="dropdown-divider"></div>

        <ul class="dropdown-list">
          <li>
            <button class="dropdown-item text-danger" @click.stop="$emit('cerrar-sesion')">
              <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M9 21H5a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h4"></path><polyline points="16 17 21 12 16 7"></polyline><line x1="21" y1="12" x2="9" y2="12"></line></svg>
              Cerrar Sesión
            </button>
          </li>
        </ul>
      </div>
    </transition>
  </div>
</template>

<script setup>
import { ref, computed, onMounted, onUnmounted } from 'vue';

const props = defineProps({
  usuario: {
    type: Object,
    required: true
  }
});

defineEmits(['cerrar-sesion', 'abrir-configuracion', 'toggle-tema']);

const isOpen = ref(false);

const toggleDropdown = () => {
  isOpen.value = !isOpen.value;
};

const closeDropdown = () => {
  isOpen.value = false;
};

// Computamos las iniciales (Ej: "Ivan Leon" -> "IL")
const iniciales = computed(() => {
  if (!props.usuario || !props.usuario.nombre) return 'U';
  const partes = props.usuario.nombre.trim().split(' ');
  if (partes.length > 1) {
    return (partes[0][0] + partes[1][0]).toUpperCase();
  }
  return props.usuario.nombre.substring(0, 2).toUpperCase();
});

// Directiva simple para cerrar al hacer clic afuera
const vClickOutside = {
  mounted(el, binding) {
    el.clickOutsideEvent = function(event) {
      if (!(el === event.target || el.contains(event.target))) {
        binding.value(event, el);
      }
    };
    document.body.addEventListener('click', el.clickOutsideEvent);
  },
  unmounted(el) {
    document.body.removeEventListener('click', el.clickOutsideEvent);
  }
};
</script>

<style scoped>
.dropdown-container {
  position: relative;
  display: inline-block;
}

/* --- TRIGGER DEL MENÚ (Perfil) --- */
.profile-trigger {
  display: flex;
  align-items: center;
  gap: 12px;
  background: transparent;
  border: 1px solid transparent;
  padding: 6px 12px;
  border-radius: 12px;
  cursor: pointer;
  transition: all 0.2s ease;
}

.profile-trigger:hover, .profile-trigger.is-active {
  background-color: #f8fafc;
  border-color: #e2e8f0;
}

.avatar {
  display: flex; align-items: center; justify-content: center;
  width: 36px; height: 36px;
  background: linear-gradient(135deg, var(--primary) 0%, #6366f1 100%);
  color: white; border-radius: 50%; font-weight: 700; font-size: 0.9rem;
}

.user-info { display: flex; flex-direction: column; text-align: left; }
.user-name { font-weight: 600; font-size: 0.9rem; color: var(--text-main); line-height: 1.2; }
.user-role { font-size: 0.75rem; color: #64748b; line-height: 1.2; margin-top: 2px; }

.chevron-icon { color: #94a3b8; transition: transform 0.3s ease; }
.chevron-icon.rotate { transform: rotate(180deg); }

/* --- MENÚ DESPLEGABLE --- */
.dropdown-menu {
  position: absolute;
  top: calc(100% + 8px);
  right: 0;
  width: 240px;
  background-color: #ffffff;
  border: 1px solid #e2e8f0;
  border-radius: 12px;
  box-shadow: 0 10px 25px -5px rgba(0, 0, 0, 0.1), 0 8px 10px -6px rgba(0, 0, 0, 0.1);
  z-index: 1000;
  overflow: hidden;
}

.dropdown-header { padding: 16px; background-color: #f8fafc; }
.header-name { margin: 0; font-weight: 600; font-size: 0.95rem; color: #1e293b; }
.header-email { margin: 4px 0 0 0; font-size: 0.8rem; color: #64748b; word-break: break-all; }

.dropdown-divider { height: 1px; background-color: #e2e8f0; margin: 0; }

.dropdown-list { list-style: none; margin: 0; padding: 8px; display: flex; flex-direction: column; gap: 4px; }

.dropdown-item {
  display: flex; align-items: center; gap: 10px; width: 100%;
  padding: 10px 12px; background: transparent; border: none; border-radius: 8px;
  color: #475569; font-size: 0.9rem; font-weight: 500; text-align: left;
  cursor: pointer; transition: all 0.2s ease;
}

.dropdown-item:hover { background-color: #f1f5f9; color: #1e293b; }
.dropdown-item svg { color: #64748b; }

.dropdown-item.text-danger { color: #ef4444; }
.dropdown-item.text-danger svg { color: #ef4444; }
.dropdown-item.text-danger:hover { background-color: #fef2f2; }

/* Animación de entrada/salida */
.dropdown-fade-enter-active, .dropdown-fade-leave-active { transition: opacity 0.2s, transform 0.2s; }
.dropdown-fade-enter-from, .dropdown-fade-leave-to { opacity: 0; transform: translateY(-10px); }
</style>