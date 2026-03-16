<script setup>
import { computed } from 'vue';

const props = defineProps({
    cliente: {
        type: Object,
        required: true
    },
    // Recibimos los eventos ya ordenados desde el más reciente al más antiguo
    historial: {
        type: Array,
        default: () => []
    }
});

defineEmits(['cerrar']);

// --- UTILIDADES PARA FORMATEAR DATOS ---

const formatearFechaCorto = (fechaStr) => {
    if (!fechaStr) return 'Fecha desconocida';
    const opciones = { day: '2-digit', month: '2-digit', year: 'numeric' };
    return new Date(fechaStr).toLocaleDateString('es-ES', opciones);
};

const formatearFecha = (fechaStr) => {
    if (!fechaStr) return '';
    const opciones = { day: '2-digit', month: '2-digit', year: 'numeric', hour: '2-digit', minute: '2-digit', hour12: true };
    return new Date(fechaStr).toLocaleString('es-ES', opciones).toUpperCase();
};

const iconoPorTipo = (tipo) => {
    const iconos = {
        'creacion': 'ti ti-star',
        'cambio_fase': 'ti ti-arrows-exchange',
        'cambio_asesor': 'ti ti-user-share',
        'anotacion': 'ti ti-note',
        'cita': 'ti ti-calendar-time'
    };
    return iconos[tipo] || 'ti ti-point';
};

const clasePorTipo = (tipo) => {
    const clases = {
        'creacion': 'dot-success',
        'cambio_fase': 'dot-warning',
        'cambio_asesor': 'dot-info',
        'anotacion': 'dot-primary',
        'cita': 'dot-purple'
    };
    return clases[tipo] || 'dot-default';
};
</script>
<template>
    <div class="modal-overlay" @click.self="$emit('cerrar')">
        <div class="modal-content">

            <div class="modal-header">
                <div class="header-top">
                    <h2>Histórico</h2>
                    <button class="btn-close" @click="$emit('cerrar')">
                        <i class="ti ti-x"></i>
                    </button>
                </div>

                <div class="cliente-info">
                    <h3 class="cliente-nombre">{{ cliente?.nombres }} {{ cliente?.apellidos }}</h3>
                    <div class="cliente-tags">
                        <span class="tag"><i class="ti ti-building"></i> {{ cliente?.producto || 'Sin producto'
                        }}</span>
                        <span class="tag"><i class="ti ti-speakerphone"></i> {{ cliente?.origen || 'Sin origen'
                        }}</span>
                        <span class="tag"><i class="ti ti-calendar"></i> {{ formatearFechaCorto(cliente?.fecha_creacion)
                        }}</span>
                    </div>
                </div>
            </div>

            <div class="modal-body">
                <div class="timeline">

                    <div v-for="(evento, index) in historial" :key="index" class="timeline-item">

                        <div class="timeline-dot" :class="clasePorTipo(evento.tipo)">
                            <i :class="iconoPorTipo(evento.tipo)"></i>
                        </div>

                        <div class="timeline-content">
                            <div class="evento-header">
                                <span class="evento-autor">{{ evento.autor }}</span>
                                <span class="evento-fecha">{{ formatearFecha(evento.fecha) }}</span>
                            </div>

                            <div class="evento-body">
                                <p class="evento-titulo">{{ evento.titulo }}</p>
                                <p v-if="evento.descripcion" class="evento-descripcion">{{ evento.descripcion }}</p>

                                <div v-if="evento.tipo === 'cita' && evento.detalle_extra" class="cita-card">
                                    <i class="ti ti-calendar-event"></i>
                                    <span>{{ evento.detalle_extra }}</span>
                                </div>
                            </div>
                        </div>

                    </div>

                    <div v-if="!historial || historial.length === 0" class="empty-state">
                        <i class="ti ti-history"></i>
                        <p>No hay eventos registrados para este prospecto.</p>
                    </div>

                </div>
            </div>

        </div>
    </div>
</template>

<style scoped>
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
}

.modal-content {
    background: var(--bg-surface, #ffffff);
    width: 100%;
    max-width: 600px;
    height: 85vh;
    max-height: 800px;
    display: flex;
    flex-direction: column;
    border-radius: 12px;
    box-shadow: 0 20px 25px -5px rgba(0, 0, 0, 0.1);
    overflow: hidden;
}

/* --- ENCABEZADO --- */
.modal-header {
    padding: 24px;
    border-bottom: 1px solid var(--border-color, #e2e8f0);
    background-color: var(--bg-element-light, #f8fafc);
}

.header-top {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 16px;
}

.header-top h2 {
    margin: 0;
    font-size: 1.5rem;
    color: var(--text-main);
    font-weight: 700;
}

.btn-close {
    background: none;
    border: none;
    font-size: 1.5rem;
    color: var(--text-muted);
    cursor: pointer;
    transition: color 0.2s;
}

.btn-close:hover {
    color: #ef4444;
}

.cliente-nombre {
    margin: 0 0 8px 0;
    font-size: 1.2rem;
    color: var(--text-main);
}

.cliente-tags {
    display: flex;
    flex-wrap: wrap;
    gap: 12px;
}

.tag {
    font-size: 0.85rem;
    color: var(--text-muted);
    display: flex;
    align-items: center;
    gap: 4px;
    background: white;
    padding: 4px 10px;
    border-radius: 20px;
    border: 1px solid #e2e8f0;
}

/* --- CUERPO Y LÍNEA DE TIEMPO --- */
.modal-body {
    padding: 32px 24px;
    overflow-y: auto;
    flex: 1;
    background-color: var(--bg-surface, #ffffff);
}

.timeline {
    position: relative;
    padding-left: 24px;
}

/* La línea vertical que conecta todo */
.timeline::before {
    content: '';
    position: absolute;
    left: 0;
    top: 2px;
    bottom: 0;
    width: 2px;
    background-color: var(--border-color, #e2e8f0);
}

.timeline-item {
    position: relative;
    margin-bottom: 28px;
}

.timeline-item:last-child {
    margin-bottom: 0;
}

/* Puntos de la línea de tiempo */
.timeline-dot {
    position: absolute;
    left: -34px;
    top: 2px;
    width: 24px;
    height: 24px;
    border-radius: 50%;
    display: flex;
    justify-content: center;
    align-items: center;
    font-size: 0.9rem;
    color: white;
    z-index: 1;
    border: 3px solid white;
    box-shadow: 0 0 0 1px #e2e8f0;
}

.dot-success {
    background-color: #10b981;
}

.dot-warning {
    background-color: #f59e0b;
}

.dot-info {
    background-color: #3b82f6;
}

.dot-primary {
    background-color: #6366f1;
}

.dot-purple {
    background-color: #8b5cf6;
}

.dot-default {
    background-color: #94a3b8;
}

/* Contenido del Evento */
.timeline-content {
    background: var(--bg-element-light, #f8fafc);
    padding: 16px;
    border-radius: 8px;
    border: 1px solid var(--border-color, #e2e8f0);
}

.evento-header {
    display: flex;
    justify-content: space-between;
    margin-bottom: 8px;
    font-size: 0.85rem;
}

.evento-autor {
    font-weight: 600;
    color: var(--text-main);
}

.evento-fecha {
    color: var(--text-muted);
}

.evento-body p {
    margin: 0;
}

.evento-titulo {
    font-weight: 500;
    color: var(--text-main);
    margin-bottom: 4px;
}

.evento-descripcion {
    font-size: 0.9rem;
    color: var(--text-muted);
    font-style: italic;
}

.cita-card {
    margin-top: 12px;
    padding: 10px;
    background: white;
    border: 1px solid #cbd5e1;
    border-radius: 6px;
    display: flex;
    align-items: center;
    gap: 8px;
    font-size: 0.9rem;
    color: var(--primary, #6366f1);
    font-weight: 500;
}

.empty-state {
    text-align: center;
    color: #94a3b8;
    padding: 40px 0;
}

.empty-state i {
    font-size: 2.5rem;
    margin-bottom: 12px;
    display: block;
}
</style>