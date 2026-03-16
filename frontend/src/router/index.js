import { createRouter, createWebHistory } from 'vue-router';
import Login from '../views/Login.vue';
// Vamos a mover temporalmente la lógica de tu App.vue a una vista separada
import Dashboard from '../views/Dashboard.vue'; 
import Registro from '../views/Registro.vue';

const routes = [
  {
    path: '/login',
    name: 'Login',
    component: Login
  },
  {
    path: '/registro',
    name: 'Registro',
    component: Registro
  },
  {
    path: '/',
    name: 'Dashboard',
    component: Dashboard,
    meta: { requiresAuth: true } // 🔒 Esta ruta requiere estar logueado
  }
];

const router = createRouter({
  history: createWebHistory(),
  routes
});

// "Guardia de Seguridad" del Frontend
router.beforeEach((to, from, next) => {
  // Verificamos si la ruta a la que quiere ir requiere autenticación
  const requiereAuth = to.matched.some(record => record.meta.requiresAuth);
  
  // Buscamos si existe un token guardado en el navegador
  const token = localStorage.getItem('token');

  if (requiereAuth && !token) {
    // Si requiere auth y NO hay token, lo mandamos al login
    next('/login');
  } else if (to.path === '/login' && token) {
    // Si ya tiene token e intenta ir al login, lo mandamos al dashboard
    next('/');
  } else {
    // En cualquier otro caso, lo dejamos pasar
    next();
  }
});

export default router;