<template>
  <nav class="crm-nav">
    <div class="nav-left">
      <div class="nav-brand">
        <div class="brand-logo">
          <i class="ti ti-brand-appstore brand-icon"></i>
        </div>
        <span>CRM Comercial</span>
      </div>

      <div class="slash-divider">/</div>

      <div class="company-dropdown-container" v-click-outside="cerrarSelectorEmpresa">
        <div class="context-switcher" @click="toggleSelectorEmpresa" :class="{ 'is-active': selectorEmpresaAbierto }">
          <div class="company-avatar">
            <i class="ti ti-building"></i>
          </div>
          <span class="selected-text">{{ empresaSeleccionadaTexto }}</span>
          <i class="ti ti-selector switcher-icon"></i>
        </div>

        <transition name="dropdown-fade">
          <div v-if="selectorEmpresaAbierto" class="custom-dropdown-menu">
            <div class="dropdown-header">
              <span class="header-title">Espacio de trabajo</span>
            </div>

            <ul class="dropdown-list">
              <li>
                <button class="dropdown-item" :class="{ 'active': !empresaSeleccionada }"
                  @click="seleccionarEmpresa(null)">
                  <span>Todas las empresas</span>
                  <i v-if="!empresaSeleccionada" class="ti ti-check check-icon"></i>
                </button>
              </li>

              <div class="dropdown-divider"></div>

              <li v-for="empresa in empresas" :key="empresa.id">
                <button class="dropdown-item" :class="{ 'active': empresaSeleccionada === empresa.id }"
                  @click="seleccionarEmpresa(empresa)">
                  <span>{{ empresa.nombre }}</span>
                  <i v-if="empresaSeleccionada === empresa.id" class="ti ti-check check-icon"></i>
                </button>
              </li>
            </ul>
          </div>
        </transition>
      </div>

      <div class="vertical-divider"></div>

      <ul class="nav-menu">
        <li>
          <a href="#" class="nav-link" @click.prevent="$emit('abrir-reportes')">
            <i class="ti ti-chart-bar nav-icon"></i>
            Reportes
          </a>
        </li>
      </ul>
    </div>

    <div class="nav-right">
      <div class="nav-search">
        <i class="ti ti-search search-icon"></i>
        <input type="text" placeholder="Buscar prospectos..." @input="$emit('buscar', $event.target.value)" />
        <kbd class="shortcut">⌘K</kbd>
      </div>

      <button class="icon-btn notification-btn" title="Notificaciones">
        <i class="ti ti-bell"></i>
        <span class="notification-badge">3</span>
      </button>

      <div class="vertical-divider"></div>

      <div class="nav-user-section">
        <UserDropdown :usuario="usuario" @cerrar-sesion="$emit('cerrar-sesion')"
          @abrir-configuracion="$emit('abrir-configuracion')" @abrir-perfil="$emit('abrir-perfil')"
          @toggle-tema="$emit('toggle-tema')" />
      </div>
    </div>
  </nav>
</template>

<script setup>
import { ref, computed } from 'vue';
import UserDropdown from './UserDropdown.vue';

const props = defineProps({
  usuario: {
    type: Object,
    required: true
  },
  empresas: {
    type: Array,
    default: () => [
      { id: 1, nombre: 'Tech Corp' },
      { id: 2, nombre: 'Global Logistics' },
      { id: 3, nombre: 'Agencia Creativa' }
    ]
  }
});

const emit = defineEmits([
  'abrir-registro',
  'abrir-reportes',
  'cerrar-sesion',
  'abrir-configuracion',
  'abrir-perfil',
  'toggle-tema',
  'buscar',
  'cambiar-empresa'
]);

// --- LÓGICA DEL SELECTOR PERSONALIZADO ---
const selectorEmpresaAbierto = ref(false);
const empresaSeleccionada = ref(null); // null = Todas las empresas

const empresaSeleccionadaTexto = computed(() => {
  if (!empresaSeleccionada.value) return 'Todas las empresas';
  const empresa = props.empresas.find(e => e.id === empresaSeleccionada.value);
  return empresa ? empresa.nombre : 'Todas las empresas';
});

const toggleSelectorEmpresa = () => {
  selectorEmpresaAbierto.value = !selectorEmpresaAbierto.value;
};

const cerrarSelectorEmpresa = () => {
  selectorEmpresaAbierto.value = false;
};

const seleccionarEmpresa = (empresa) => {
  const idEmpresa = empresa ? empresa.id : '';
  empresaSeleccionada.value = idEmpresa || null;
  emit('cambiar-empresa', idEmpresa);
  cerrarSelectorEmpresa();
};

// Directiva para cerrar al hacer clic afuera
const vClickOutside = {
  mounted(el, binding) {
    el.clickOutsideEvent = function (event) {
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
/* --- CONTENEDOR PRINCIPAL --- */
.crm-nav {
  background-color: var(--bg-surface);
  backdrop-filter: blur(12px);
  -webkit-backdrop-filter: blur(12px);
  border-bottom: 1px solid var(--border-color);
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 0 32px;
  height: 72px;
  position: fixed;
  top: 0;
  left: 0;
  width: 100%;
  box-sizing: border-box;
  z-index: 900;
  box-shadow: var(--shadow-sm);
}

.nav-left,
.nav-right {
  display: flex;
  align-items: center;
  gap: 16px;
}

/* --- LOGO Y MARCA --- */
.nav-brand {
  font-size: 1.25rem;
  font-weight: 700;
  color: var(--text-main);
  display: flex;
  align-items: center;
  gap: 12px;
  letter-spacing: -0.025em;
}

.brand-logo {
  display: flex;
  align-items: center;
  justify-content: center;
  width: 36px;
  height: 36px;
  background: linear-gradient(135deg, var(--primary) 0%, #6366f1 100%);
  color: white;
  border-radius: 10px;
  box-shadow: 0 4px 6px -1px rgba(79, 70, 229, 0.2);
}

.brand-icon {
  font-size: 1.4rem;
}

/* Separadores */
.vertical-divider {
  width: 1px;
  height: 24px;
  background-color: var(--border-color);
  margin: 0 8px;
}

.slash-divider {
  color: var(--border-color);
  font-size: 1.2rem;
  font-weight: 300;
  margin: 0 4px;
  user-select: none;
}

/* --- CONTEXT SWITCHER PERSONALIZADO --- */
.company-dropdown-container {
  position: relative;
}

.context-switcher {
  display: flex;
  align-items: center;
  padding: 4px 8px 4px 4px;
  border-radius: 8px;
  background-color: transparent;
  transition: all 0.2s ease;
  cursor: pointer;
  user-select: none;
}

.context-switcher:hover,
.context-switcher.is-active {
  background-color: var(--bg-element);
}

.company-avatar {
  width: 24px;
  height: 24px;
  background-color: var(--bg-surface);
  border: 1px solid var(--border-color);
  border-radius: 6px;
  display: flex;
  align-items: center;
  justify-content: center;
  margin-right: 8px;
  color: var(--text-muted);
  font-size: 0.85rem;
  box-shadow: 0 1px 2px rgba(0, 0, 0, 0.05);
}

.selected-text {
  color: var(--text-main);
  font-weight: 600;
  font-size: 0.95rem;
  padding-right: 20px;
  max-width: 160px;
  white-space: nowrap;
  text-overflow: ellipsis;
  overflow: hidden;
}

.switcher-icon {
  position: absolute;
  right: 6px;
  color: var(--text-muted);
  font-size: 1rem;
  opacity: 0.5;
  transition: opacity 0.2s ease;
}

.context-switcher:hover .switcher-icon,
.context-switcher.is-active .switcher-icon {
  opacity: 1;
  color: var(--text-main);
}

/* Menú Flotante del Selector */
.custom-dropdown-menu {
  position: absolute;
  top: calc(100% + 8px);
  left: 0;
  width: 220px;
  background-color: var(--bg-surface);
  border: 1px solid var(--border-color);
  border-radius: 12px;
  box-shadow: 0 10px 25px -5px rgba(0, 0, 0, 0.1), 0 8px 10px -6px rgba(0, 0, 0, 0.1);
  z-index: 1000;
  overflow: hidden;
}

.dropdown-header {
  padding: 12px 16px;
  background-color: var(--bg-element);
}

.header-title {
  font-size: 0.75rem;
  font-weight: 700;
  color: var(--text-muted);
  text-transform: uppercase;
  letter-spacing: 0.5px;
}

.dropdown-divider {
  height: 1px;
  background-color: var(--border-color);
  margin: 4px 0;
}

.dropdown-list {
  list-style: none;
  margin: 0;
  padding: 8px;
  display: flex;
  flex-direction: column;
  gap: 2px;
}

.dropdown-item {
  display: flex;
  align-items: center;
  justify-content: space-between;
  width: 100%;
  padding: 8px 12px;
  background: transparent;
  border: none;
  border-radius: 8px;
  color: var(--text-main);
  font-size: 0.9rem;
  font-weight: 500;
  text-align: left;
  cursor: pointer;
  transition: all 0.2s ease;
}

.dropdown-item:hover {
  background-color: var(--bg-element-hover);
}

.dropdown-item.active {
  color: var(--primary);
  background-color: #eef2ff;
}

/* Ajusta el color si tu primario no es índigo */
.check-icon {
  font-size: 1.1rem;
  color: var(--primary);
}

/* Animación de entrada/salida */
.dropdown-fade-enter-active,
.dropdown-fade-leave-active {
  transition: opacity 0.2s, transform 0.2s;
}

.dropdown-fade-enter-from,
.dropdown-fade-leave-to {
  opacity: 0;
  transform: translateY(-10px);
}

/* --- MENÚ CENTRAL --- */
.nav-menu {
  list-style: none;
  display: flex;
  gap: 8px;
  margin: 0;
  padding: 0;
}

.nav-link {
  display: flex;
  align-items: center;
  gap: 8px;
  color: var(--text-muted);
  text-decoration: none;
  font-weight: 500;
  font-size: 0.95rem;
  padding: 8px 16px;
  border-radius: var(--radius-md);
  transition: all 0.2s ease;
}

.nav-icon {
  transition: transform 0.2s ease;
  font-size: 1.15rem;
}

.nav-link:hover {
  background-color: var(--bg-element);
  color: var(--primary);
}

.nav-link:hover .nav-icon {
  transform: scale(1.1);
}

/* --- BUSCADOR --- */
.nav-search {
  position: relative;
  display: flex;
  align-items: center;
}

.search-icon {
  position: absolute;
  left: 12px;
  color: var(--text-muted);
  font-size: 1.1rem;
}

.nav-search input {
  background-color: var(--bg-element);
  border: 1px solid transparent;
  color: var(--text-main);
  padding: 8px 12px 8px 36px;
  border-radius: var(--radius-md);
  font-size: 0.9rem;
  width: 200px;
  transition: all 0.2s ease;
}

.nav-search input:focus {
  outline: none;
  background-color: var(--bg-surface);
  border-color: var(--primary);
  width: 250px;
  box-shadow: 0 0 0 3px rgba(99, 102, 241, 0.1);
}

.nav-search input::placeholder {
  color: var(--text-muted);
}

.shortcut {
  position: absolute;
  right: 8px;
  background-color: var(--bg-surface);
  border: 1px solid var(--border-color);
  color: var(--text-muted);
  font-size: 0.7rem;
  padding: 2px 6px;
  border-radius: 4px;
  pointer-events: none;
}

/* --- BOTÓN ICONO (Notificaciones) --- */
.icon-btn {
  position: relative;
  display: flex;
  align-items: center;
  justify-content: center;
  width: 40px;
  height: 40px;
  border-radius: var(--radius-md);
  background: transparent;
  border: 1px solid transparent;
  color: var(--text-muted);
  font-size: 1.3rem;
  cursor: pointer;
  transition: all 0.2s ease;
}

.icon-btn:hover {
  background-color: var(--bg-element);
  color: var(--text-main);
}

.notification-badge {
  position: absolute;
  top: 4px;
  right: 4px;
  background-color: var(--danger-text, #ef4444);
  color: white;
  font-size: 0.65rem;
  font-weight: 700;
  width: 16px;
  height: 16px;
  border-radius: 50%;
  display: flex;
  justify-content: center;
  align-items: center;
  border: 2px solid var(--bg-surface);
}

/* --- SECCIÓN DE USUARIO --- */
.nav-user-section {
  display: flex;
  align-items: center;
}
</style>