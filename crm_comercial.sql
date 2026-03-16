-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 16-03-2026 a las 07:20:15
-- Versión del servidor: 10.4.32-MariaDB
-- Versión de PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `crm_comercial`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `actividades_simples`
--

CREATE TABLE `actividades_simples` (
  `id_actividad` int(11) NOT NULL,
  `id_cliente` int(11) DEFAULT NULL,
  `id_asesor` int(11) DEFAULT NULL,
  `tipo_actividad` varchar(20) DEFAULT NULL,
  `descripcion` text DEFAULT NULL,
  `fecha_recordatorio` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Volcado de datos para la tabla `actividades_simples`
--

INSERT INTO `actividades_simples` (`id_actividad`, `id_cliente`, `id_asesor`, `tipo_actividad`, `descripcion`, `fecha_recordatorio`) VALUES
(1, 1, 2, 'Tarea', 'Llamar para verificar recepción de correo', '2024-06-20 10:00:00'),
(2, 2, 2, 'Anotación', 'El cliente prefiere contacto por WhatsApp', NULL),
(3, 3, 3, 'Tarea', 'Enviar brochure actualizado', '2024-06-21 15:30:00'),
(4, 1, 2, 'Tarea', 'Llamar para verificar recepción de correo', '2024-06-20 10:00:00'),
(5, 2, 2, 'Anotación', 'El cliente prefiere contacto por WhatsApp', NULL),
(6, 3, 3, 'Tarea', 'Enviar brochure actualizado', '2024-06-21 15:30:00'),
(7, 1, 2, 'Tarea', 'Llamar para verificar recepción de correo', '2024-06-20 10:00:00'),
(8, 2, 2, 'Anotación', 'El cliente prefiere contacto por WhatsApp', NULL),
(9, 3, 3, 'Tarea', 'Enviar brochure actualizado', '2024-06-21 15:30:00');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `campanas_origen`
--

CREATE TABLE `campanas_origen` (
  `id_campana` int(11) NOT NULL,
  `nombre` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Volcado de datos para la tabla `campanas_origen`
--

INSERT INTO `campanas_origen` (`id_campana`, `nombre`) VALUES
(1, 'Facebook Ads'),
(2, 'Google Search'),
(3, 'Referido'),
(4, 'LinkedIn'),
(5, 'Llamada Fría');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `citas`
--

CREATE TABLE `citas` (
  `id_cita` int(11) NOT NULL,
  `id_cliente` int(11) DEFAULT NULL,
  `id_asesor` int(11) DEFAULT NULL,
  `id_estado_cita` int(11) DEFAULT NULL,
  `fecha_hora_cita` datetime DEFAULT NULL,
  `notas_resultado` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Volcado de datos para la tabla `citas`
--

INSERT INTO `citas` (`id_cita`, `id_cliente`, `id_asesor`, `id_estado_cita`, `fecha_hora_cita`, `notas_resultado`) VALUES
(1, 1, 2, 1, '2024-06-25 09:00:00', 'Presentación inicial del ERP'),
(2, 5, 3, 2, '2024-06-15 14:00:00', 'Cita exitosa, solicitaron cotización formal'),
(3, 1, 2, 1, '2024-06-25 09:00:00', 'Presentación inicial del ERP'),
(4, 5, 3, 2, '2024-06-15 14:00:00', 'Cita exitosa, solicitaron cotización formal');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `clientes_oportunidades`
--

CREATE TABLE `clientes_oportunidades` (
  `id_cliente` int(11) NOT NULL,
  `nombres` varchar(100) NOT NULL,
  `apellidos` varchar(100) NOT NULL,
  `celular_1` varchar(20) DEFAULT NULL,
  `empresa` varchar(100) DEFAULT NULL,
  `correo_1` varchar(100) DEFAULT NULL,
  `id_campana_origen` int(11) DEFAULT NULL,
  `id_tipo_producto` int(11) DEFAULT NULL,
  `id_nivel_interes` int(11) DEFAULT NULL,
  `id_estado_actual` int(11) DEFAULT NULL,
  `id_asesor_inicial` int(11) DEFAULT NULL,
  `id_asesor_cierre` int(11) DEFAULT NULL,
  `fecha_creacion` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Volcado de datos para la tabla `clientes_oportunidades`
--

INSERT INTO `clientes_oportunidades` (`id_cliente`, `nombres`, `apellidos`, `celular_1`, `empresa`, `correo_1`, `id_campana_origen`, `id_tipo_producto`, `id_nivel_interes`, `id_estado_actual`, `id_asesor_inicial`, `id_asesor_cierre`, `fecha_creacion`) VALUES
(1, 'Juan', 'Pérez', '555-0101', 'Tech Solutions', 'jperez@tech.com', 1, 1, 3, 1, 2, NULL, '2026-03-07 09:42:46'),
(2, 'Marta', 'Sánchez', '555-0202', 'Global Logistics', 'marta.s@globallog.com', 2, 2, 4, 1, 2, NULL, '2026-03-07 09:42:46'),
(3, 'Diego', 'López', '555-0303', 'Eco Friendly', 'dlopez@eco.com', 3, 1, 2, 1, 3, NULL, '2026-03-07 09:42:46'),
(4, 'Elena', 'Rivas', '555-0404', 'Innova Corp', 'erivas@innova.com', 4, 4, 1, 6, 5, NULL, '2026-03-07 09:42:46'),
(5, 'Sofía', 'Castro', '555-0505', 'Alpha Group', 'scastro@alpha.com', 1, 3, 4, 4, 3, NULL, '2026-03-07 09:42:46'),
(6, 'Luis', 'Mendoza', '555-0606', 'Mendoza & Asoc', 'luis@mendoza.com', 5, 2, 3, 1, 2, NULL, '2026-03-07 09:42:46'),
(7, 'Ivan', 'Capote', NULL, 'Ca', NULL, NULL, NULL, NULL, 3, 2, NULL, '2026-03-07 10:46:42'),
(8, 'Julian', 'Rodriguez', NULL, 'CEO', NULL, NULL, NULL, NULL, 3, 2, NULL, '2026-03-07 10:53:57'),
(9, 'prueba', 'prueba', NULL, 'CAE', NULL, NULL, 2, NULL, 3, 2, NULL, '2026-03-07 11:39:58'),
(10, 'ivan', 'leon', NULL, 'Cari ', NULL, NULL, 1, NULL, 4, 3, NULL, '2026-03-07 15:25:29'),
(11, 'cccc', 'ccc', NULL, 'cccc', NULL, NULL, 2, NULL, 3, 1, NULL, '2026-03-15 17:57:46'),
(12, 'Leon', 'Ivan', NULL, 'CariAI', NULL, NULL, 2, NULL, 2, 5, NULL, '2026-03-16 00:30:52');

--
-- Disparadores `clientes_oportunidades`
--
DELIMITER $$
CREATE TRIGGER `tg_historial_estado` AFTER UPDATE ON `clientes_oportunidades` FOR EACH ROW BEGIN
    -- Solo inserta si el estado realmente cambió
    IF OLD.id_estado_actual <> NEW.id_estado_actual THEN
        INSERT INTO historial_estados_cliente (id_cliente, id_estado_anterior, id_estado_nuevo, id_asesor_cambio, justificacion)
        VALUES (NEW.id_cliente, OLD.id_estado_actual, NEW.id_estado_actual, NEW.id_asesor_inicial, 'Cambio automático detectado');
    END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `empleados`
--

CREATE TABLE `empleados` (
  `id_empleado` int(11) NOT NULL,
  `id_equipo` int(11) DEFAULT NULL,
  `rol` varchar(20) DEFAULT NULL,
  `nombre_completo` varchar(100) NOT NULL,
  `email_corporativo` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Volcado de datos para la tabla `empleados`
--

INSERT INTO `empleados` (`id_empleado`, `id_equipo`, `rol`, `nombre_completo`, `email_corporativo`) VALUES
(1, 1, 'Administrador', 'Roberto Gomez', 'rgomez@empresa.com'),
(2, 1, 'Asesor', 'Ana Martínez', 'amartinez@empresa.com'),
(3, 1, 'Asesor', 'Carlos Ruiz', 'cruiz@empresa.com'),
(4, 2, 'Administrador', 'Laura Peña', 'lpena@empresa.com'),
(5, 2, 'Asesor', 'Julián Toro', 'jtoro@empresa.com');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `equipos`
--

CREATE TABLE `equipos` (
  `id_equipo` int(11) NOT NULL,
  `nombre_equipo` varchar(50) NOT NULL,
  `id_administrador` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Volcado de datos para la tabla `equipos`
--

INSERT INTO `equipos` (`id_equipo`, `nombre_equipo`, `id_administrador`) VALUES
(1, 'Equipo Norte', 1),
(2, 'Equipo Sur', 4);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `estados_cita`
--

CREATE TABLE `estados_cita` (
  `id_estado_cita` int(11) NOT NULL,
  `nombre` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Volcado de datos para la tabla `estados_cita`
--

INSERT INTO `estados_cita` (`id_estado_cita`, `nombre`) VALUES
(1, 'Programada'),
(2, 'Realizada'),
(3, 'Cancelada'),
(4, 'Re-programada');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `estados_embudo`
--

CREATE TABLE `estados_embudo` (
  `id_estado_embudo` int(11) NOT NULL,
  `nombre` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Volcado de datos para la tabla `estados_embudo`
--

INSERT INTO `estados_embudo` (`id_estado_embudo`, `nombre`) VALUES
(1, 'Prospecto'),
(2, 'Contacto Inicial'),
(3, 'Propuesta Enviada'),
(4, 'Negociación'),
(5, 'Cerrado Ganado'),
(6, 'Cerrado Perdido');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `historial_estados_cliente`
--

CREATE TABLE `historial_estados_cliente` (
  `id_historial` int(11) NOT NULL,
  `id_cliente` int(11) DEFAULT NULL,
  `id_estado_anterior` int(11) DEFAULT NULL,
  `id_estado_nuevo` int(11) DEFAULT NULL,
  `id_asesor_cambio` int(11) DEFAULT NULL,
  `fecha_cambio` datetime DEFAULT current_timestamp(),
  `justificacion` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Volcado de datos para la tabla `historial_estados_cliente`
--

INSERT INTO `historial_estados_cliente` (`id_historial`, `id_cliente`, `id_estado_anterior`, `id_estado_nuevo`, `id_asesor_cambio`, `fecha_cambio`, `justificacion`) VALUES
(1, 1, 1, 3, 2, '2026-03-07 09:46:04', 'Cambio automático detectado'),
(2, 7, 1, 2, 2, '2026-03-07 10:58:55', 'Cambio automático detectado'),
(3, 8, 2, 3, 2, '2026-03-07 10:59:05', 'Cambio automático detectado'),
(4, 8, 3, 4, 2, '2026-03-07 10:59:06', 'Cambio automático detectado'),
(5, 7, 2, 1, 2, '2026-03-07 10:59:09', 'Cambio automático detectado'),
(6, 8, 4, 2, 2, '2026-03-07 10:59:42', 'Cambio automático detectado'),
(7, 8, 2, 4, 2, '2026-03-07 10:59:45', 'Cambio automático detectado'),
(8, 3, 2, 3, 3, '2026-03-07 11:06:40', 'Cambio automático detectado'),
(9, 3, 3, 2, 3, '2026-03-07 11:06:46', 'Cambio automático detectado'),
(10, 7, 1, 2, 2, '2026-03-07 11:27:31', 'Cambio automático detectado'),
(11, 1, 3, 1, 2, '2026-03-07 11:27:36', 'Cambio automático detectado'),
(12, 3, 2, 1, 3, '2026-03-07 11:27:37', 'Cambio automático detectado'),
(13, 7, 2, 1, 2, '2026-03-07 11:27:38', 'Cambio automático detectado'),
(14, 2, 3, 1, 2, '2026-03-07 11:27:40', 'Cambio automático detectado'),
(15, 5, 4, 1, 3, '2026-03-07 11:27:41', 'Cambio automático detectado'),
(16, 8, 4, 1, 2, '2026-03-07 11:27:42', 'Cambio automático detectado'),
(17, 6, 5, 2, 2, '2026-03-07 11:28:09', 'Cambio automático detectado'),
(18, 6, 2, 1, 2, '2026-03-07 11:28:12', 'Cambio automático detectado'),
(19, 2, 1, 2, 2, '2026-03-07 11:28:21', 'Cambio automático detectado'),
(20, 5, 1, 3, 3, '2026-03-07 11:28:22', 'Cambio automático detectado'),
(21, 7, 1, 4, 2, '2026-03-07 11:28:23', 'Cambio automático detectado'),
(22, 6, 1, 2, 2, '2026-03-07 11:28:25', 'Cambio automático detectado'),
(23, 8, 1, 2, 2, '2026-03-07 11:35:48', 'Cambio automático detectado'),
(24, 6, 2, 3, 2, '2026-03-07 11:35:50', 'Cambio automático detectado'),
(25, 8, 2, 1, 2, '2026-03-07 11:35:51', 'Cambio automático detectado'),
(26, 1, 1, 2, 2, '2026-03-07 11:43:09', 'Cambio automático detectado'),
(27, 1, 2, 1, 2, '2026-03-07 11:43:11', 'Cambio automático detectado'),
(28, 9, 2, 1, 2, '2026-03-07 11:43:17', 'Cambio automático detectado'),
(29, 7, 4, 3, 2, '2026-03-07 11:47:27', 'Cambio automático detectado'),
(30, 2, 2, 3, 2, '2026-03-07 11:47:29', 'Cambio automático detectado'),
(31, 3, 1, 2, 3, '2026-03-07 11:47:30', 'Cambio automático detectado'),
(32, 1, 1, 2, 2, '2026-03-07 11:50:35', 'Cambio automático detectado'),
(33, 9, 1, 2, 2, '2026-03-07 11:50:36', 'Cambio automático detectado'),
(34, 3, 2, 1, 3, '2026-03-07 11:50:37', 'Cambio automático detectado'),
(35, 3, 1, 2, 3, '2026-03-07 11:56:51', 'Cambio automático detectado'),
(36, 1, 2, 1, 2, '2026-03-07 11:56:53', 'Cambio automático detectado'),
(37, 9, 2, 1, 2, '2026-03-07 11:56:54', 'Cambio automático detectado'),
(38, 8, 1, 2, 2, '2026-03-07 11:56:57', 'Cambio automático detectado'),
(39, 10, 2, 3, 3, '2026-03-07 15:25:52', 'Cambio automático detectado'),
(40, 7, 3, 4, 2, '2026-03-07 15:25:56', 'Cambio automático detectado'),
(41, 7, 4, 5, 2, '2026-03-07 15:25:58', 'Cambio automático detectado'),
(42, 7, 5, 2, 2, '2026-03-07 15:26:01', 'Cambio automático detectado'),
(43, 8, 2, 1, 2, '2026-03-14 15:32:34', 'Cambio automático detectado'),
(44, 3, 2, 3, 3, '2026-03-14 15:32:36', 'Cambio automático detectado'),
(45, 2, 3, 2, 2, '2026-03-14 15:32:37', 'Cambio automático detectado'),
(46, 7, 2, 3, 2, '2026-03-14 15:32:39', 'Cambio automático detectado'),
(47, 5, 3, 2, 3, '2026-03-14 23:06:36', 'Cambio automático detectado'),
(48, 7, 3, 2, 2, '2026-03-14 23:06:37', 'Cambio automático detectado'),
(49, 1, 1, 2, 2, '2026-03-14 23:06:59', 'Cambio automático detectado'),
(50, 2, 2, 1, 2, '2026-03-14 23:07:00', 'Cambio automático detectado'),
(51, 9, 1, 4, 2, '2026-03-14 23:07:04', 'Cambio automático detectado'),
(52, 5, 2, 3, 3, '2026-03-15 17:29:49', 'Cambio automático detectado'),
(53, 7, 2, 3, 2, '2026-03-15 17:29:50', 'Cambio automático detectado'),
(54, 1, 2, 3, 2, '2026-03-15 17:29:52', 'Cambio automático detectado'),
(55, 1, 3, 2, 2, '2026-03-15 17:29:54', 'Cambio automático detectado'),
(56, 5, 3, 2, 3, '2026-03-15 17:29:55', 'Cambio automático detectado'),
(57, 6, 3, 2, 2, '2026-03-15 17:29:56', 'Cambio automático detectado'),
(58, 3, 3, 4, 3, '2026-03-15 17:43:17', 'Cambio automático detectado'),
(59, 10, 3, 2, 3, '2026-03-15 17:43:19', 'Cambio automático detectado'),
(60, 8, 1, 2, 2, '2026-03-15 17:43:20', 'Cambio automático detectado'),
(61, 2, 1, 3, 2, '2026-03-15 17:43:22', 'Cambio automático detectado'),
(62, 1, 2, 1, 2, '2026-03-15 17:43:23', 'Cambio automático detectado'),
(63, 6, 2, 1, 2, '2026-03-15 17:43:24', 'Cambio automático detectado'),
(64, 1, 1, 2, 2, '2026-03-15 17:57:11', 'Cambio automático detectado'),
(65, 1, 2, 3, 2, '2026-03-15 17:57:13', 'Cambio automático detectado'),
(66, 2, 3, 1, 2, '2026-03-15 17:57:14', 'Cambio automático detectado'),
(67, 10, 2, 1, 3, '2026-03-15 17:57:15', 'Cambio automático detectado'),
(68, 5, 2, 3, 3, '2026-03-15 17:57:17', 'Cambio automático detectado'),
(69, 8, 2, 3, 2, '2026-03-15 17:57:18', 'Cambio automático detectado'),
(70, 3, 4, 2, 3, '2026-03-15 17:57:20', 'Cambio automático detectado'),
(71, 8, 3, 2, 2, '2026-03-15 17:57:33', 'Cambio automático detectado'),
(72, 9, 4, 2, 2, '2026-03-15 17:57:36', 'Cambio automático detectado'),
(73, 11, 2, 1, 1, '2026-03-15 17:57:55', 'Cambio automático detectado'),
(74, 3, 2, 3, 3, '2026-03-15 18:03:59', 'Cambio automático detectado'),
(75, 3, 3, 2, 3, '2026-03-15 18:04:00', 'Cambio automático detectado'),
(76, 9, 2, 3, 2, '2026-03-15 18:04:04', 'Cambio automático detectado'),
(77, 11, 1, 2, 1, '2026-03-15 18:04:05', 'Cambio automático detectado'),
(78, 2, 1, 2, 2, '2026-03-15 18:37:05', 'Cambio automático detectado'),
(79, 2, 2, 1, 2, '2026-03-15 18:37:06', 'Cambio automático detectado'),
(80, 11, 2, 1, 1, '2026-03-15 18:37:08', 'Cambio automático detectado'),
(81, 8, 2, 3, 2, '2026-03-15 18:38:46', 'Cambio automático detectado'),
(82, 5, 3, 2, 3, '2026-03-15 18:38:47', 'Cambio automático detectado'),
(83, 1, 3, 2, 2, '2026-03-15 18:38:49', 'Cambio automático detectado'),
(84, 3, 2, 3, 3, '2026-03-15 18:38:50', 'Cambio automático detectado'),
(85, 5, 2, 3, 3, '2026-03-15 18:38:51', 'Cambio automático detectado'),
(86, 5, 3, 2, 3, '2026-03-15 18:45:33', 'Cambio automático detectado'),
(87, 8, 3, 2, 2, '2026-03-15 18:45:35', 'Cambio automático detectado'),
(88, 3, 3, 4, 3, '2026-03-15 18:45:36', 'Cambio automático detectado'),
(89, 10, 1, 2, 3, '2026-03-15 18:52:54', 'Cambio automático detectado'),
(90, 5, 2, 4, 3, '2026-03-15 18:52:56', 'Cambio automático detectado'),
(91, 1, 2, 3, 2, '2026-03-15 18:53:02', 'Cambio automático detectado'),
(92, 2, 1, 2, 2, '2026-03-15 21:16:39', 'Cambio automático detectado'),
(93, 1, 3, 1, 2, '2026-03-15 21:16:43', 'Cambio automático detectado'),
(94, 10, 2, 3, 3, '2026-03-15 21:16:45', 'Cambio automático detectado'),
(95, 2, 2, 3, 2, '2026-03-15 22:07:31', 'Cambio automático detectado'),
(96, 8, 2, 3, 2, '2026-03-15 22:07:33', 'Cambio automático detectado'),
(97, 2, 3, 2, 2, '2026-03-15 22:07:34', 'Cambio automático detectado'),
(98, 7, 3, 2, 2, '2026-03-15 22:07:36', 'Cambio automático detectado'),
(99, 9, 3, 2, 2, '2026-03-15 22:07:37', 'Cambio automático detectado'),
(100, 9, 2, 5, 2, '2026-03-15 22:34:29', 'Cambio automático detectado'),
(101, 11, 1, 5, 1, '2026-03-15 22:34:30', 'Cambio automático detectado'),
(102, 7, 2, 5, 2, '2026-03-15 23:12:39', 'Cambio automático detectado'),
(103, 9, 5, 2, 2, '2026-03-15 23:12:40', 'Cambio automático detectado'),
(104, 10, 3, 4, 3, '2026-03-15 23:58:01', 'Cambio automático detectado'),
(105, 12, 1, 2, 5, '2026-03-16 00:31:09', 'Cambio automático detectado'),
(106, 12, 2, 4, 5, '2026-03-16 00:31:29', 'Cambio automático detectado'),
(107, 12, 4, 5, 5, '2026-03-16 00:31:44', 'Cambio automático detectado'),
(108, 12, 5, 1, 5, '2026-03-16 00:32:34', 'Cambio automático detectado'),
(109, 12, 1, 3, 5, '2026-03-16 00:45:55', 'Cambio automático detectado'),
(110, 12, 3, 2, 5, '2026-03-16 01:01:29', 'Cambio automático detectado'),
(111, 7, 5, 3, 2, '2026-03-16 01:01:32', 'Cambio automático detectado'),
(112, 11, 5, 3, 1, '2026-03-16 01:01:33', 'Cambio automático detectado'),
(113, 3, 4, 1, 3, '2026-03-16 01:01:35', 'Cambio automático detectado'),
(114, 2, 2, 1, 2, '2026-03-16 01:11:46', 'Cambio automático detectado'),
(115, 9, 2, 3, 2, '2026-03-16 01:19:09', 'Cambio automático detectado');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `niveles_interes`
--

CREATE TABLE `niveles_interes` (
  `id_level` int(11) NOT NULL,
  `nombre` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Volcado de datos para la tabla `niveles_interes`
--

INSERT INTO `niveles_interes` (`id_level`, `nombre`) VALUES
(1, 'Bajo'),
(2, 'Medio'),
(3, 'Alto'),
(4, 'Crítico');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `roles`
--

CREATE TABLE `roles` (
  `id_rol` int(11) NOT NULL,
  `nombre_rol` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `roles`
--

INSERT INTO `roles` (`id_rol`, `nombre_rol`) VALUES
(1, 'Admin'),
(2, 'Asesor'),
(3, 'Lector');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tipos_producto`
--

CREATE TABLE `tipos_producto` (
  `id_producto` int(11) NOT NULL,
  `nombre` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Volcado de datos para la tabla `tipos_producto`
--

INSERT INTO `tipos_producto` (`id_producto`, `nombre`) VALUES
(1, 'Software ERP'),
(2, 'Consultoría IT'),
(3, 'Soporte Premium'),
(4, 'Licencia Anual');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios`
--

CREATE TABLE `usuarios` (
  `id_usuario` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `id_rol` int(11) NOT NULL,
  `fecha_creacion` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `usuarios`
--

INSERT INTO `usuarios` (`id_usuario`, `nombre`, `email`, `password`, `id_rol`, `fecha_creacion`) VALUES
(4, 'admin', 'admin@mail.com', '$2b$10$KtaTpmIxtiwHyzEegd2Vs.aZjo9aO8ociDJ7X48K3On3IlssXNwqC', 1, '2026-03-16 04:10:55'),
(5, 'asesor', 'asesor@mail.com', '$2b$10$sUua2PpwshZ6f4i03D2w.u6VYx/w0OBhcQ7H1qEL2ip3YFzmX3EAu', 2, '2026-03-16 04:11:47'),
(6, 'Sharon', 'sharon@mail.com', '$2b$10$3MO.aUxzGAlIxKmXIzS9p.PlOg7wrnCTPZ1plrpomM8hIU4czuzyi', 1, '2026-03-16 06:18:17');

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `v_reporte_detallado_clientes`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `v_reporte_detallado_clientes` (
`id_cliente` int(11)
,`nombre_cliente` varchar(201)
,`empresa` varchar(100)
,`origen_lead` varchar(50)
,`producto_interes` varchar(50)
,`nivel_urgencia` varchar(20)
,`estado_actual` varchar(50)
,`asesor_asignado` varchar(100)
,`equipo_comercial` varchar(50)
,`fecha_creacion` datetime
);

-- --------------------------------------------------------

--
-- Estructura para la vista `v_reporte_detallado_clientes`
--
DROP TABLE IF EXISTS `v_reporte_detallado_clientes`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_reporte_detallado_clientes`  AS SELECT `c`.`id_cliente` AS `id_cliente`, concat(`c`.`nombres`,' ',`c`.`apellidos`) AS `nombre_cliente`, `c`.`empresa` AS `empresa`, `cp`.`nombre` AS `origen_lead`, `tp`.`nombre` AS `producto_interes`, `ni`.`nombre` AS `nivel_urgencia`, `ee`.`nombre` AS `estado_actual`, `emp`.`nombre_completo` AS `asesor_asignado`, `eq`.`nombre_equipo` AS `equipo_comercial`, `c`.`fecha_creacion` AS `fecha_creacion` FROM ((((((`clientes_oportunidades` `c` left join `campanas_origen` `cp` on(`c`.`id_campana_origen` = `cp`.`id_campana`)) left join `tipos_producto` `tp` on(`c`.`id_tipo_producto` = `tp`.`id_producto`)) left join `niveles_interes` `ni` on(`c`.`id_nivel_interes` = `ni`.`id_level`)) left join `estados_embudo` `ee` on(`c`.`id_estado_actual` = `ee`.`id_estado_embudo`)) left join `empleados` `emp` on(`c`.`id_asesor_inicial` = `emp`.`id_empleado`)) left join `equipos` `eq` on(`emp`.`id_equipo` = `eq`.`id_equipo`)) ;

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `actividades_simples`
--
ALTER TABLE `actividades_simples`
  ADD PRIMARY KEY (`id_actividad`),
  ADD KEY `fk_act_cli` (`id_cliente`);

--
-- Indices de la tabla `campanas_origen`
--
ALTER TABLE `campanas_origen`
  ADD PRIMARY KEY (`id_campana`);

--
-- Indices de la tabla `citas`
--
ALTER TABLE `citas`
  ADD PRIMARY KEY (`id_cita`),
  ADD KEY `fk_cita_cliente` (`id_cliente`),
  ADD KEY `fk_cita_asesor` (`id_asesor`),
  ADD KEY `fk_cita_estado` (`id_estado_cita`);

--
-- Indices de la tabla `clientes_oportunidades`
--
ALTER TABLE `clientes_oportunidades`
  ADD PRIMARY KEY (`id_cliente`),
  ADD KEY `fk_cli_campana` (`id_campana_origen`),
  ADD KEY `fk_cli_prod` (`id_tipo_producto`),
  ADD KEY `fk_cli_nivel` (`id_nivel_interes`),
  ADD KEY `fk_cli_estado` (`id_estado_actual`),
  ADD KEY `fk_cli_asesor_ini` (`id_asesor_inicial`);

--
-- Indices de la tabla `empleados`
--
ALTER TABLE `empleados`
  ADD PRIMARY KEY (`id_empleado`),
  ADD KEY `fk_emp_equipo` (`id_equipo`);

--
-- Indices de la tabla `equipos`
--
ALTER TABLE `equipos`
  ADD PRIMARY KEY (`id_equipo`),
  ADD KEY `fk_equipo_admin` (`id_administrador`);

--
-- Indices de la tabla `estados_cita`
--
ALTER TABLE `estados_cita`
  ADD PRIMARY KEY (`id_estado_cita`);

--
-- Indices de la tabla `estados_embudo`
--
ALTER TABLE `estados_embudo`
  ADD PRIMARY KEY (`id_estado_embudo`);

--
-- Indices de la tabla `historial_estados_cliente`
--
ALTER TABLE `historial_estados_cliente`
  ADD PRIMARY KEY (`id_historial`),
  ADD KEY `fk_hist_cli` (`id_cliente`);

--
-- Indices de la tabla `niveles_interes`
--
ALTER TABLE `niveles_interes`
  ADD PRIMARY KEY (`id_level`);

--
-- Indices de la tabla `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`id_rol`),
  ADD UNIQUE KEY `nombre_rol` (`nombre_rol`);

--
-- Indices de la tabla `tipos_producto`
--
ALTER TABLE `tipos_producto`
  ADD PRIMARY KEY (`id_producto`);

--
-- Indices de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`id_usuario`),
  ADD UNIQUE KEY `email` (`email`),
  ADD KEY `id_rol` (`id_rol`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `actividades_simples`
--
ALTER TABLE `actividades_simples`
  MODIFY `id_actividad` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT de la tabla `campanas_origen`
--
ALTER TABLE `campanas_origen`
  MODIFY `id_campana` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `citas`
--
ALTER TABLE `citas`
  MODIFY `id_cita` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `clientes_oportunidades`
--
ALTER TABLE `clientes_oportunidades`
  MODIFY `id_cliente` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT de la tabla `empleados`
--
ALTER TABLE `empleados`
  MODIFY `id_empleado` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `equipos`
--
ALTER TABLE `equipos`
  MODIFY `id_equipo` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `estados_cita`
--
ALTER TABLE `estados_cita`
  MODIFY `id_estado_cita` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `estados_embudo`
--
ALTER TABLE `estados_embudo`
  MODIFY `id_estado_embudo` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de la tabla `historial_estados_cliente`
--
ALTER TABLE `historial_estados_cliente`
  MODIFY `id_historial` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=116;

--
-- AUTO_INCREMENT de la tabla `niveles_interes`
--
ALTER TABLE `niveles_interes`
  MODIFY `id_level` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `roles`
--
ALTER TABLE `roles`
  MODIFY `id_rol` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `tipos_producto`
--
ALTER TABLE `tipos_producto`
  MODIFY `id_producto` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `id_usuario` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `actividades_simples`
--
ALTER TABLE `actividades_simples`
  ADD CONSTRAINT `fk_act_cli` FOREIGN KEY (`id_cliente`) REFERENCES `clientes_oportunidades` (`id_cliente`);

--
-- Filtros para la tabla `citas`
--
ALTER TABLE `citas`
  ADD CONSTRAINT `fk_cita_asesor` FOREIGN KEY (`id_asesor`) REFERENCES `empleados` (`id_empleado`),
  ADD CONSTRAINT `fk_cita_cliente` FOREIGN KEY (`id_cliente`) REFERENCES `clientes_oportunidades` (`id_cliente`),
  ADD CONSTRAINT `fk_cita_estado` FOREIGN KEY (`id_estado_cita`) REFERENCES `estados_cita` (`id_estado_cita`);

--
-- Filtros para la tabla `clientes_oportunidades`
--
ALTER TABLE `clientes_oportunidades`
  ADD CONSTRAINT `fk_cli_asesor_ini` FOREIGN KEY (`id_asesor_inicial`) REFERENCES `empleados` (`id_empleado`),
  ADD CONSTRAINT `fk_cli_campana` FOREIGN KEY (`id_campana_origen`) REFERENCES `campanas_origen` (`id_campana`),
  ADD CONSTRAINT `fk_cli_estado` FOREIGN KEY (`id_estado_actual`) REFERENCES `estados_embudo` (`id_estado_embudo`),
  ADD CONSTRAINT `fk_cli_nivel` FOREIGN KEY (`id_nivel_interes`) REFERENCES `niveles_interes` (`id_level`),
  ADD CONSTRAINT `fk_cli_prod` FOREIGN KEY (`id_tipo_producto`) REFERENCES `tipos_producto` (`id_producto`);

--
-- Filtros para la tabla `empleados`
--
ALTER TABLE `empleados`
  ADD CONSTRAINT `fk_emp_equipo` FOREIGN KEY (`id_equipo`) REFERENCES `equipos` (`id_equipo`);

--
-- Filtros para la tabla `equipos`
--
ALTER TABLE `equipos`
  ADD CONSTRAINT `fk_equipo_admin` FOREIGN KEY (`id_administrador`) REFERENCES `empleados` (`id_empleado`);

--
-- Filtros para la tabla `historial_estados_cliente`
--
ALTER TABLE `historial_estados_cliente`
  ADD CONSTRAINT `fk_hist_cli` FOREIGN KEY (`id_cliente`) REFERENCES `clientes_oportunidades` (`id_cliente`);

--
-- Filtros para la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD CONSTRAINT `usuarios_ibfk_1` FOREIGN KEY (`id_rol`) REFERENCES `roles` (`id_rol`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
