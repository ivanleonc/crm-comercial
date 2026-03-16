<template>
    <div class="modal-overlay" @click.self="$emit('cerrar')">
        <div class="modal-container">

            <div class="modal-header">
                <div>
                    <h2 class="modal-title">Configuración</h2>
                    <p class="modal-subtitle">Administra tu cuenta y preferencias del CRM.</p>
                </div>
                <button class="close-btn" @click="$emit('cerrar')">
                    <i class="ti ti-x"></i>
                </button>
            </div>

            <div class="modal-body">
                <aside class="settings-sidebar">
                    <nav>
                        <button class="nav-item" :class="{ 'active': activeTab === 'perfil' }"
                            @click="activeTab = 'perfil'">
                            <i class="ti ti-user-circle"></i> Mi Perfil
                        </button>
                        <button class="nav-item" :class="{ 'active': activeTab === 'notificaciones' }"
                            @click="activeTab = 'notificaciones'">
                            <i class="ti ti-bell"></i> Notificaciones
                        </button>
                        <button class="nav-item" :class="{ 'active': activeTab === 'seguridad' }"
                            @click="activeTab = 'seguridad'">
                            <i class="ti ti-shield-lock"></i> Seguridad
                        </button>
                    </nav>
                </aside>

                <main class="settings-content">

                    <transition name="fade" mode="out-in">
                        <div v-if="activeTab === 'perfil'" class="tab-pane" key="perfil">
                            <h3 class="section-title">Información Personal</h3>

                            <div class="profile-avatar-section">
                                <div class="avatar-large">{{ iniciales }}</div>
                                <div class="avatar-actions">
                                    <button class="btn btn-secondary">Cambiar foto</button>
                                    <button class="btn btn-text text-danger">Eliminar</button>
                                </div>
                            </div>

                            <div class="form-grid">
                                <div class="form-group">
                                    <label>Nombre Completo</label>
                                    <input type="text" v-model="formData.nombre" class="form-input" />
                                </div>
                                <div class="form-group">
                                    <label>Correo Electrónico</label>
                                    <input type="email" v-model="formData.email" class="form-input" disabled />
                                    <span class="help-text">El correo está vinculado a tu cuenta de
                                        Google/Microsoft.</span>
                                </div>
                                <div class="form-group">
                                    <label>Cargo / Rol</label>
                                    <input type="text" v-model="formData.rol" class="form-input" disabled />
                                </div>
                                <div class="form-group">
                                    <label>Teléfono</label>
                                    <input type="tel" v-model="formData.telefono" class="form-input"
                                        placeholder="+57 300 000 0000" />
                                </div>
                            </div>

                            <div class="form-actions">
                                <button class="btn btn-primary" @click="guardarCambios">Guardar Cambios</button>
                            </div>
                        </div>

                        <div v-else-if="activeTab === 'notificaciones'" class="tab-pane" key="notificaciones">
                            <h3 class="section-title">Preferencias de Notificación</h3>

                            <div class="toggle-list">
                                <div class="toggle-item">
                                    <div class="toggle-info">
                                        <h4>Nuevos Prospectos</h4>
                                        <p>Recibir un correo cuando se asigne un nuevo prospecto a tu embudo.</p>
                                    </div>
                                    <label class="switch">
                                        <input type="checkbox" v-model="notificaciones.nuevosProspectos">
                                        <span class="slider round"></span>
                                    </label>
                                </div>

                                <div class="toggle-divider"></div>

                                <div class="toggle-item">
                                    <div class="toggle-info">
                                        <h4>Recordatorios de Seguimiento</h4>
                                        <p>Notificaciones push en el navegador para tareas que vencen hoy.</p>
                                    </div>
                                    <label class="switch">
                                        <input type="checkbox" v-model="notificaciones.recordatorios">
                                        <span class="slider round"></span>
                                    </label>
                                </div>
                            </div>
                        </div>

                        <div v-else-if="activeTab === 'seguridad'" class="tab-pane" key="seguridad">
                            <h3 class="section-title">Seguridad de la Cuenta</h3>
                            <p class="text-muted">Actualiza tu contraseña para mantener tu cuenta segura.</p>

                            <div class="form-grid" style="margin-top: 24px;">
                                <div class="form-group">
                                    <label>Contraseña Actual</label>
                                    <input type="password" class="form-input" placeholder="••••••••" />
                                </div>
                                <div class="form-group">
                                    <label>Nueva Contraseña</label>
                                    <input type="password" class="form-input" placeholder="••••••••" />
                                </div>
                            </div>

                            <div class="form-actions">
                                <button class="btn btn-primary">Actualizar Contraseña</button>
                            </div>
                        </div>
                    </transition>
                </main>
            </div>
        </div>
    </div>
</template>

<script setup>
import { ref, reactive, computed } from 'vue';

const props = defineProps({
    usuario: {
        type: Object,
        required: true
    }
});

const emit = defineEmits(['cerrar', 'guardar-perfil']);

// Estado de navegación
const activeTab = ref('perfil');

// Estado del formulario (Hacemos una copia local para no mutar la prop directamente)
const formData = reactive({
    nombre: props.usuario.nombre || '',
    email: props.usuario.email || '',
    rol: props.usuario.rol || '',
    telefono: props.usuario.telefono || ''
});

// Estado de los toggles de notificaciones
const notificaciones = reactive({
    nuevosProspectos: true,
    recordatorios: true
});

// Iniciales para el Avatar
const iniciales = computed(() => {
    if (!formData.nombre) return 'U';
    const partes = formData.nombre.trim().split(' ');
    if (partes.length > 1) {
        return (partes[0][0] + partes[1][0]).toUpperCase();
    }
    return formData.nombre.substring(0, 2).toUpperCase();
});

const guardarCambios = () => {
    // Aquí puedes validar datos antes de emitir
    emit('guardar-perfil', { ...formData });
    // Opcional: mostrar un toast de éxito y cerrar
    emit('cerrar');
};
</script>

<style scoped>
/* --- OVERLAY DEL MODAL --- */
.modal-overlay {
    position: fixed;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    background-color: rgba(15, 23, 42, 0.6);
    backdrop-filter: blur(4px);
    display: flex;
    justify-content: center;
    align-items: center;
    z-index: 9999;
    padding: 20px;
    box-sizing: border-box;
}

/* --- CONTENEDOR PRINCIPAL --- */
.modal-container {
    background-color: var(--bg-surface, #ffffff);
    border-radius: 16px;
    width: 100%;
    max-width: 900px;
    height: 85vh;
    max-height: 700px;
    display: flex;
    flex-direction: column;
    box-shadow: 0 25px 50px -12px rgba(0, 0, 0, 0.25);
    overflow: hidden;
    border: 1px solid var(--border-color, #e2e8f0);
}

/* --- HEADER --- */
.modal-header {
    padding: 24px 32px;
    border-bottom: 1px solid var(--border-color, #e2e8f0);
    display: flex;
    justify-content: space-between;
    align-items: flex-start;
    background-color: var(--bg-surface, #ffffff);
}

.modal-title {
    margin: 0;
    font-size: 1.5rem;
    font-weight: 700;
    color: var(--text-main, #0f172a);
}

.modal-subtitle {
    margin: 4px 0 0;
    font-size: 0.9rem;
    color: var(--text-muted, #64748b);
}

.close-btn {
    background: transparent;
    border: none;
    font-size: 1.5rem;
    color: var(--text-muted, #64748b);
    cursor: pointer;
    padding: 4px;
    border-radius: 8px;
    transition: all 0.2s ease;
}

.close-btn:hover {
    background-color: var(--bg-element, #f1f5f9);
    color: var(--text-main, #0f172a);
}

/* --- BODY (Flexbox para Sidebar y Contenido) --- */
.modal-body {
    display: flex;
    flex: 1;
    overflow: hidden;
}

/* --- SIDEBAR --- */
.settings-sidebar {
    width: 240px;
    border-right: 1px solid var(--border-color, #e2e8f0);
    padding: 24px 16px;
    background-color: var(--bg-element-light, #f8fafc);
    overflow-y: auto;
}

.nav-item {
    display: flex;
    align-items: center;
    gap: 12px;
    width: 100%;
    padding: 12px 16px;
    margin-bottom: 8px;
    border: none;
    background: transparent;
    border-radius: 8px;
    color: var(--text-muted, #64748b);
    font-weight: 500;
    font-size: 0.95rem;
    cursor: pointer;
    text-align: left;
    transition: all 0.2s ease;
}

.nav-item i {
    font-size: 1.2rem;
}

.nav-item:hover {
    background-color: var(--bg-element, #e2e8f0);
    color: var(--text-main, #0f172a);
}

.nav-item.active {
    background-color: rgba(99, 102, 241, 0.1);
    color: var(--primary, #6366f1);
    font-weight: 600;
}

/* --- CONTENIDO PRINCIPAL --- */
.settings-content {
    flex: 1;
    padding: 32px;
    overflow-y: auto;
    background-color: var(--bg-surface, #ffffff);
}

.section-title {
    margin: 0 0 24px 0;
    font-size: 1.25rem;
    font-weight: 600;
    color: var(--text-main, #0f172a);
}

.text-muted {
    color: var(--text-muted, #64748b);
    font-size: 0.9rem;
    margin-top: -16px;
    margin-bottom: 24px;
}

/* --- PERFIL: AVATAR --- */
.profile-avatar-section {
    display: flex;
    align-items: center;
    gap: 24px;
    margin-bottom: 32px;
}

.avatar-large {
    width: 80px;
    height: 80px;
    border-radius: 50%;
    background: linear-gradient(135deg, var(--primary, #6366f1) 0%, #4f46e5 100%);
    color: white;
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 2rem;
    font-weight: 700;
    box-shadow: 0 4px 10px rgba(99, 102, 241, 0.3);
}

.avatar-actions {
    display: flex;
    gap: 12px;
}

/* --- FORMULARIOS --- */
.form-grid {
    display: grid;
    grid-template-columns: 1fr 1fr;
    gap: 20px;
}

.form-group {
    display: flex;
    flex-direction: column;
    gap: 8px;
}

.form-group label {
    font-size: 0.85rem;
    font-weight: 600;
    color: var(--text-main, #334155);
}

.form-input {
    padding: 10px 14px;
    border: 1px solid var(--border-color, #cbd5e1);
    border-radius: 8px;
    background-color: var(--bg-surface, #ffffff);
    color: var(--text-main, #0f172a);
    font-size: 0.95rem;
    transition: all 0.2s ease;
}

.form-input:focus {
    outline: none;
    border-color: var(--primary, #6366f1);
    box-shadow: 0 0 0 3px rgba(99, 102, 241, 0.1);
}

.form-input:disabled {
    background-color: var(--bg-element, #f1f5f9);
    color: var(--text-muted, #94a3b8);
    cursor: not-allowed;
}

.help-text {
    font-size: 0.75rem;
    color: var(--text-muted, #64748b);
}

.form-actions {
    margin-top: 32px;
    display: flex;
    justify-content: flex-end;
    padding-top: 24px;
    border-top: 1px solid var(--border-color, #e2e8f0);
}

/* --- BOTONES --- */
.btn {
    padding: 10px 20px;
    border-radius: 8px;
    font-weight: 600;
    font-size: 0.9rem;
    cursor: pointer;
    transition: all 0.2s ease;
    border: none;
}

.btn-primary {
    background-color: var(--primary, #6366f1);
    color: white;
    box-shadow: 0 2px 4px rgba(99, 102, 241, 0.2);
}

.btn-primary:hover {
    background-color: #4f46e5;
    box-shadow: 0 4px 6px rgba(99, 102, 241, 0.3);
}

.btn-secondary {
    background-color: var(--bg-element, #f1f5f9);
    color: var(--text-main, #334155);
    border: 1px solid var(--border-color, #e2e8f0);
}

.btn-secondary:hover {
    background-color: #e2e8f0;
}

.btn-text {
    background: transparent;
    box-shadow: none;
}

.text-danger {
    color: #ef4444;
}

.text-danger:hover {
    background-color: #fef2f2;
}

/* --- TOGGLES (Interruptores) --- */
.toggle-list {
    display: flex;
    flex-direction: column;
    gap: 16px;
}

.toggle-item {
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding: 8px 0;
}

.toggle-info h4 {
    margin: 0 0 4px 0;
    font-size: 1rem;
    color: var(--text-main, #0f172a);
}

.toggle-info p {
    margin: 0;
    font-size: 0.85rem;
    color: var(--text-muted, #64748b);
}

.toggle-divider {
    height: 1px;
    background-color: var(--border-color, #e2e8f0);
}

/* Switch CSS puro */
.switch {
    position: relative;
    display: inline-block;
    width: 44px;
    height: 24px;
}

.switch input {
    opacity: 0;
    width: 0;
    height: 0;
}

.slider {
    position: absolute;
    cursor: pointer;
    top: 0;
    left: 0;
    right: 0;
    bottom: 0;
    background-color: #cbd5e1;
    transition: .3s;
}

.slider:before {
    position: absolute;
    content: "";
    height: 18px;
    width: 18px;
    left: 3px;
    bottom: 3px;
    background-color: white;
    transition: .3s;
}

input:checked+.slider {
    background-color: var(--primary, #6366f1);
}

input:checked+.slider:before {
    transform: translateX(20px);
}

.slider.round {
    border-radius: 24px;
}

.slider.round:before {
    border-radius: 50%;
}

/* --- ANIMACIONES --- */
.fade-enter-active,
.fade-leave-active {
    transition: opacity 0.2s ease, transform 0.2s ease;
}

.fade-enter-from,
.fade-leave-to {
    opacity: 0;
    transform: translateY(10px);
}

/* Responsive básico */
@media (max-width: 768px) {
    .modal-body {
        flex-direction: column;
    }

    .settings-sidebar {
        width: 100%;
        border-right: none;
        border-bottom: 1px solid var(--border-color);
        padding: 16px;
        overflow-x: auto;
    }

    .settings-sidebar nav {
        display: flex;
        gap: 8px;
    }

    .nav-item {
        width: auto;
        white-space: nowrap;
        margin-bottom: 0;
    }

    .form-grid {
        grid-template-columns: 1fr;
    }
}
</style>