import { defineStore } from 'pinia';
import { authService } from '../services/authService';

export const useAuthStore = defineStore('auth', {
  state: () => ({
    user: JSON.parse(localStorage.getItem('user')) || null,
    token: localStorage.getItem('token') || null,
  }),

  getters: {
    isAuthenticated: (state) => !!state.token,
    isAdmin: (state) => state.user?.rol === 'Admin',
  },

  actions: {
    async login(credentials) {
      try {
        const data = await authService.login(credentials);
        this.user = data.usuario;
        this.token = data.token;
        localStorage.setItem('token', data.token);
        localStorage.setItem('user', JSON.stringify(data.usuario));
        return data;
      } catch (error) {
        throw error;
      }
    },

    logout() {
      this.user = null;
      this.token = null;
      localStorage.removeItem('token');
      localStorage.removeItem('user');
    }
  }
});
