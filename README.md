# 🚀 CRM Comercial - Sistema de Gestión de Prospectos

Un moderno sistema CRM (Customer Relationship Management) diseñado para gestionar el flujo de ventas a través de un tablero Kanban interactivo. Construido con una arquitectura cliente-servidor utilizando Vue 3 y Node.js.

## ✨ Características Principales

* **Tablero Kanban Interactivo:** Sistema de arrastrar y soltar (Drag & Drop) fluido con `vuedraggable` para mover clientes entre las distintas fases de venta.
* **Modo Oscuro Integrado:** Soporte completo para temas Claro, Oscuro y Automático (Sistema).
* **Gestión de Prospectos:** Formularios modales organizados para registrar clientes y asignar asesores.
* **Vista de Detalles:** Tarjetas interactivas con información detallada de cada prospecto.
* **UI/UX Premium:** Diseño moderno tipo SaaS con Tabler Icons y variables CSS globales.

---

## 🛠️ Tecnologías Utilizadas

* **Frontend:** Vue 3 (Composition API), Vite, Vue Router, Axios, VueDraggable.
* **Backend:** Node.js, Express, JWT, BcryptJS, MySQL2.
* **Estilos:** CSS Vanilla con Sistema de Variables Globales (Premium Design).

---

## ⚙️ Requisitos Previos

Para ejecutar este proyecto localmente, necesitarás:
* [Node.js](https://nodejs.org/) (v16.x o superior)
* [MySQL Server](https://dev.mysql.com/downloads/mysql/)
* [Git](https://git-scm.com/)

---

## 🚀 Instalación y Configuración

### 1. Clonar el repositorio
```bash
git clone https://github.com/ivanleonc/crm-comercial.git
cd crm-comercial
```

### 2. Configuración de la Base de Datos
1. Abre tu cliente de MySQL (MySQL Workbench, phpMyAdmin, terminal).
2. Crea una base de datos llamada `crm_comercial`.
3. Importa el archivo `crm_comercial.sql` ubicado en la raíz del proyecto.
   ```bash
   mysql -u tu_usuario -p crm_comercial < crm_comercial.sql
   ```

### 3. Configuración del Backend
1. Entra a la carpeta backend:
   ```bash
   cd backend
   ```
2. Instala las dependencias:
   ```bash
   npm install
   ```
3. Configura las variables de entorno:
   - Copia el archivo `.env.example` a `.env`:
     ```bash
     cp .env.example .env
     ```
   - Abre `.env` y configura tus credenciales de MySQL.

### 4. Configuración del Frontend
1. Entra a la carpeta frontend:
   ```bash
   cd ../frontend
   ```
2. Instala las dependencias:
   ```bash
   npm install
   ```

---

## 🏃 Cómo ejecutar el proyecto

### Iniciar el Backend
Desde la carpeta `backend`:
```bash
npm run dev
```
> El servidor se iniciará en `http://localhost:3000`

### Iniciar el Frontend
Desde la carpeta `frontend`:
```bash
npm run dev
```
> La aplicación estará disponible en `http://localhost:5173` (o el puerto indicado por Vite).

---

## 🔑 Usuarios de Prueba
Si importaste el SQL, puedes usar estas credenciales iniciales para el login:
- **Email:** `ivan.leo@gmail.com`
- **Password:** `123456`

---

## 📄 Licencia
Este proyecto es de uso libre bajo la licencia ISC.
