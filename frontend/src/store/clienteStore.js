import { defineStore } from 'pinia';
import { clienteService } from '../services/clienteService';

export const useClienteStore = defineStore('cliente', {
  state: () => ({
    clientes: [],
    loading: false,
    error: null,
  }),

  actions: {
    async fetchClientes() {
      this.loading = true;
      try {
        this.clientes = await clienteService.obtenerClientes();
      } catch (error) {
        this.error = error.message;
      } finally {
        this.loading = false;
      }
    },

    async updateEstado(id, newEstadoId) {
      try {
        await clienteService.actualizarEstado(id, newEstadoId);
        // Actualizamos localmente para una respuesta instantánea en la UI
        const cliente = this.clientes.find(c => c.id_cliente === id);
        if (cliente) {
          cliente.id_estado_actual = newEstadoId;
        }
      } catch (error) {
        this.error = error.message;
        throw error;
      }
    }
  }
});
