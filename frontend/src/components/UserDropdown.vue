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
      <i class="ti ti-chevron-down chevron-icon" :class="{ 'rotate': isOpen }"></i>
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
              <i class="ti ti-settings"></i>
              Configuración
            </button>
          </li>
          <li>
            <button class="dropdown-item" @click.stop="toggleThemeMode(); closeDropdown()">
              <i :class="themeIconClass"></i>
              Modo: {{ themeText }}
            </button>
          </li>
        </ul>

        <div class="dropdown-divider"></div>

        <ul class="dropdown-list">
          <li>
            <button class="dropdown-item text-danger" @click.stop="$emit('cerrar-sesion')">
              <i class="ti ti-logout"></i>
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
import { useTheme } from '../composables/useTheme';

const { theme, toggleTheme } = useTheme();

const props = defineProps({
  usuario: {
    type: Object,
    required: true
  }
});

defineEmits(['cerrar-sesion', 'abrir-configuracion']);

const isOpen = ref(false);

const toggleDropdown = () => {
  isOpen.value = !isOpen.value;
};

const closeDropdown = () => {
  isOpen.value = false;
};

// Acciones del tema
const toggleThemeMode = () => {
  toggleTheme();
};

const themeText = computed(() => {
  if (theme.value === 'dark') return 'Oscuro';
  if (theme.value === 'light') return 'Claro';
  return 'Sistema';
});

const themeIconClass = computed(() => {
  if (theme.value === 'dark') return 'ti ti-moon';
  if (theme.value === 'light') return 'ti ti-sun';
  return 'ti ti-device-desktop';
});

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
  background-color: var(--bg-element);
  border-color: var(--border-color);
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

.chevron-icon { color: #94a3b8; transition: transform 0.3s ease; font-size: 1.1rem;}
.chevron-icon.rotate { transform: rotate(180deg); }

/* --- MENÚ DESPLEGABLE --- */
.dropdown-menu {
  position: absolute;
  top: calc(100% + 8px);
  right: 0;
  width: 240px;
  background-color: var(--bg-surface);
  border: 1px solid var(--border-color);
  border-radius: 12px;
  box-shadow: 0 10px 25px -5px rgba(0, 0, 0, 0.1), 0 8px 10px -6px rgba(0, 0, 0, 0.1);
  z-index: 1000;
  overflow: hidden;
}

.dropdown-header { padding: 16px; background-color: var(--bg-element); }
.header-name { margin: 0; font-weight: 600; font-size: 0.95rem; color: var(--text-main); }
.header-email { margin: 4px 0 0 0; font-size: 0.8rem; color: var(--text-muted); word-break: break-all; }

.dropdown-divider { height: 1px; background-color: var(--border-color); margin: 0; }

.dropdown-list { list-style: none; margin: 0; padding: 8px; display: flex; flex-direction: column; gap: 4px; }

.dropdown-item {
  display: flex; align-items: center; gap: 10px; width: 100%;
  padding: 10px 12px; background: transparent; border: none; border-radius: 8px;
  color: var(--text-main); font-size: 0.9rem; font-weight: 500; text-align: left;
  cursor: pointer; transition: all 0.2s ease;
}

.dropdown-item:hover { background-color: var(--bg-element-hover); color: var(--primary); }
.dropdown-item i { color: var(--text-muted); font-size: 1.15rem; }

.dropdown-item.text-danger { color: var(--danger-text); }
.dropdown-item.text-danger i { color: var(--danger-text); }
.dropdown-item.text-danger:hover { background-color: var(--danger-bg); }

/* Animación de entrada/salida */
.dropdown-fade-enter-active, .dropdown-fade-leave-active { transition: opacity 0.2s, transform 0.2s; }
.dropdown-fade-enter-from, .dropdown-fade-leave-to { opacity: 0; transform: translateY(-10px); }
</style>