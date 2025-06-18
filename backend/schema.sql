-- phpMyAdmin SQL Dump
-- version 5.2.2
-- https://www.phpmyadmin.net/
--
-- Host: mysql-iaranievas.alwaysdata.net
-- Generation Time: Jun 18, 2025 at 12:34 AM
-- Server version: 10.11.13-MariaDB
-- PHP Version: 7.4.33

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `iaranievas_artesanos`
--

-- --------------------------------------------------------

--
-- Table structure for table `albumes`
--

CREATE TABLE `albumes` (
  `id` int(11) NOT NULL,
  `id_usuario` int(11) NOT NULL,
  `titulo` varchar(255) NOT NULL,
  `fecha_creacion` timestamp NOT NULL DEFAULT current_timestamp(),
  `id_amigo` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `albumes`
--

INSERT INTO `albumes` (`id`, `id_usuario`, `titulo`, `fecha_creacion`, `id_amigo`) VALUES
(8, 1, 'PAISAJES', '2025-06-12 14:25:25', NULL),
(9, 2, 'COSAS', '2025-06-12 23:28:59', NULL),
(15, 8, 'Personal', '2025-06-15 23:33:31', NULL),
(17, 11, 'Random', '2025-06-16 00:40:34', NULL),
(22, 11, 'Lili Ejemplo', '2025-06-16 20:39:53', 8),
(23, 8, 'Carla Díaz', '2025-06-16 20:41:56', 11),
(24, 11, 'Lucía Pérez', '2025-06-16 21:59:39', 9),
(25, 9, 'Martín Gómez', '2025-06-16 23:34:51', 10),
(26, 10, 'Lucía Pérez', '2025-06-16 23:37:52', 9),
(27, 9, 'Lili Ejemplo', '2025-06-16 23:39:18', 8),
(29, 8, 'Martín Gómez', '2025-06-16 23:40:40', 10),
(30, 9, 'Carla Díaz', '2025-06-16 23:41:59', 11),
(31, 10, 'Carla Díaz', '2025-06-16 23:42:01', 11),
(32, 8, 'Lucía Pérez', '2025-06-16 23:44:45', 9),
(33, 11, 'mora', '2025-06-16 23:45:08', 1),
(34, 2, 'mora', '2025-06-16 23:45:09', 1),
(35, 1, 'Iara Nievas', '2025-06-16 23:45:59', 2),
(39, 10, 'Detalles en cerámica', '2025-06-17 11:16:24', NULL),
(40, 11, 'Martín Gómez', '2025-06-17 11:18:22', 10);

-- --------------------------------------------------------

--
-- Table structure for table `amistades`
--

CREATE TABLE `amistades` (
  `id` int(11) NOT NULL,
  `id_usuario` int(11) NOT NULL,
  `id_amigo` int(11) NOT NULL,
  `fecha_amistad` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `amistades`
--

INSERT INTO `amistades` (`id`, `id_usuario`, `id_amigo`, `fecha_amistad`) VALUES
(13, 11, 8, '2025-06-16 20:39:53'),
(14, 8, 11, '2025-06-16 20:41:56'),
(15, 11, 9, '2025-06-16 21:59:39'),
(16, 9, 10, '2025-06-16 23:34:51'),
(17, 10, 9, '2025-06-16 23:37:52'),
(18, 9, 8, '2025-06-16 23:39:18'),
(20, 8, 10, '2025-06-16 23:40:40'),
(21, 9, 11, '2025-06-16 23:41:59'),
(22, 10, 11, '2025-06-16 23:42:00'),
(23, 8, 9, '2025-06-16 23:44:45'),
(24, 11, 1, '2025-06-16 23:45:08'),
(25, 2, 1, '2025-06-16 23:45:09'),
(26, 1, 2, '2025-06-16 23:45:59'),
(27, 11, 10, '2025-06-17 11:18:22');

-- --------------------------------------------------------

--
-- Table structure for table `comentarios`
--

CREATE TABLE `comentarios` (
  `id` int(11) NOT NULL,
  `id_imagen` int(11) NOT NULL,
  `id_usuario` int(11) NOT NULL,
  `comentario` text NOT NULL,
  `fecha_comentario` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `comentarios`
--

INSERT INTO `comentarios` (`id`, `id_imagen`, `id_usuario`, `comentario`, `fecha_comentario`) VALUES
(1, 9, 2, 'Hermoso', '2025-06-13 00:32:57'),
(2, 13, 10, 'Bello', '2025-06-16 01:22:38'),
(3, 13, 8, 'Wao', '2025-06-16 03:37:59'),
(4, 15, 10, 'Full Irlanda', '2025-06-17 03:40:32'),
(5, 14, 10, 'Bellisimo', '2025-06-17 10:32:48'),
(6, 15, 10, 'Genial', '2025-06-17 11:15:23'),
(7, 24, 11, 'Muy bueno!', '2025-06-17 11:24:16'),
(8, 24, 11, 'Muy bueno!', '2025-06-17 11:24:28'),
(11, 25, 10, 'Genial', '2025-06-17 11:50:44');

-- --------------------------------------------------------

--
-- Table structure for table `eventos`
--

CREATE TABLE `eventos` (
  `id` int(11) NOT NULL,
  `id_usuario` int(11) NOT NULL,
  `titulo` varchar(255) NOT NULL,
  `descripcion` text DEFAULT NULL,
  `fecha_evento` date NOT NULL,
  `lugar` varchar(255) DEFAULT NULL,
  `fecha_publicacion` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `imagenes`
--

CREATE TABLE `imagenes` (
  `id` int(11) NOT NULL,
  `id_album` int(11) NOT NULL,
  `id_usuario` int(11) NOT NULL,
  `url_archivo` varchar(255) NOT NULL,
  `descripcion` text DEFAULT NULL,
  `visibilidad` enum('publica','privada','compartida') DEFAULT 'publica',
  `fecha_subida` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `imagenes`
--

INSERT INTO `imagenes` (`id`, `id_album`, `id_usuario`, `url_archivo`, `descripcion`, `visibilidad`, `fecha_subida`) VALUES
(5, 8, 1, '/uploads/1749763314993-Festival-de-Halloween-en-Derry-Londonderry.jpg', 'fes', 'publica', '2025-06-12 21:21:55'),
(8, 8, 1, '/uploads/1749770770509-191bbf0060c54a5dbfd61a27ec661392.jpg', 'Bella Irlanda', 'publica', '2025-06-12 23:26:10'),
(9, 8, 1, '/uploads/1749770789502-descarga.jpeg', 'Irlanda', 'privada', '2025-06-12 23:26:29'),
(10, 9, 2, '/uploads/1749770951814-IMG_9842.jpg', '', 'publica', '2025-06-12 23:29:11'),
(11, 9, 2, '/uploads/1749770968412-hq720.jpg', '', 'privada', '2025-06-12 23:29:28'),
(12, 15, 8, '/uploads/1750030506010-doble-exposicion-de-mujer-y-arboles-de-tiro-medio (1).jpg', '', 'publica', '2025-06-15 23:35:06'),
(13, 17, 11, '/uploads/1750034454995-doble-exposicion-de-mujer-y-arboles-de-tiro-medio (2).jpg', '', 'publica', '2025-06-16 00:40:55'),
(14, 17, 11, '/uploads/1750046894363-nick-fewings-D68vlyckZhs-unsplash.jpg', '', 'publica', '2025-06-16 04:08:14'),
(15, 17, 11, '/uploads/1750048725308-allec-gomes-jvMcNnh20Ow-unsplash.jpg', '', 'publica', '2025-06-16 04:38:45'),
(24, 39, 10, '/uploads/1750159019237-263fc7f2-4f0f-4304-bba5-78858de1a3dc.jpeg', 'Creaciones', 'publica', '2025-06-17 11:16:59'),
(25, 17, 11, '/uploads/1750160918659-humphrey-m-ap6RwTFUCFU-unsplash.jpg', '', 'publica', '2025-06-17 11:48:39');

-- --------------------------------------------------------

--
-- Table structure for table `imagenes_compartidas`
--

CREATE TABLE `imagenes_compartidas` (
  `id_imagen` int(11) NOT NULL,
  `id_usuario` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `imagenes_tags`
--

CREATE TABLE `imagenes_tags` (
  `id_imagen` int(11) NOT NULL,
  `id_tag` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `inscripciones_evento`
--

CREATE TABLE `inscripciones_evento` (
  `id` int(11) NOT NULL,
  `id_evento` int(11) NOT NULL,
  `id_usuario` int(11) NOT NULL,
  `fecha_inscripcion` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `notificaciones`
--

CREATE TABLE `notificaciones` (
  `id` int(11) NOT NULL,
  `id_usuario` int(11) NOT NULL,
  `tipo` enum('amistad','comentario','evento') NOT NULL,
  `mensaje` varchar(255) DEFAULT NULL,
  `url` varchar(255) DEFAULT NULL,
  `leido` tinyint(1) DEFAULT 0,
  `fecha` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `notificaciones`
--

INSERT INTO `notificaciones` (`id`, `id_usuario`, `tipo`, `mensaje`, `url`, `leido`, `fecha`) VALUES
(1, 1, 'amistad', 'Nueva solicitud de amistad', NULL, 1, '2025-06-12 23:28:41'),
(2, 2, 'amistad', 'Tu solicitud de amistad fue aceptada', NULL, 1, '2025-06-12 23:30:12'),
(3, 1, 'comentario', 'Nuevo comentario en tu imagen', '/imagen/9', 1, '2025-06-13 00:32:57'),
(4, 1, 'amistad', 'Nueva solicitud de amistad', NULL, 1, '2025-06-14 13:24:07'),
(5, 2, 'amistad', 'Tu solicitud de amistad fue aceptada', NULL, 1, '2025-06-14 13:24:37'),
(6, 2, 'amistad', 'Nueva solicitud de amistad', NULL, 1, '2025-06-14 13:25:46'),
(7, 1, 'amistad', 'Tu solicitud de amistad fue aceptada', NULL, 1, '2025-06-14 13:25:59'),
(8, 1, 'amistad', 'Nueva solicitud de amistad de Carla Díaz', '/solicitud/4', 1, '2025-06-15 22:58:27'),
(9, 10, 'amistad', 'Nueva solicitud de amistad de Carla Díaz', '/solicitud/5', 1, '2025-06-15 22:58:46'),
(10, 11, 'amistad', 'Tu solicitud de amistad fue rechazada', NULL, 1, '2025-06-15 22:59:21'),
(11, 10, 'amistad', 'Nueva solicitud de amistad de Carla Díaz', '/solicitud/6', 1, '2025-06-15 23:01:03'),
(12, 11, 'amistad', 'Tu solicitud de amistad fue aceptada', NULL, 1, '2025-06-15 23:01:18'),
(13, 11, 'amistad', 'Tu solicitud de amistad fue rechazada', NULL, 1, '2025-06-15 23:01:20'),
(14, 8, 'amistad', 'Nueva solicitud de amistad de Carla Díaz', '/solicitud/7', 1, '2025-06-15 23:24:26'),
(15, 11, 'amistad', 'Tu solicitud de amistad fue aceptada', NULL, 1, '2025-06-15 23:24:43'),
(16, 9, 'amistad', 'Nueva solicitud de amistad de Carla Díaz', '/solicitud/8', 1, '2025-06-15 23:52:38'),
(17, 11, 'amistad', 'Nueva solicitud de amistad de Lili Ejemplo', '/solicitud/9', 1, '2025-06-15 23:52:56'),
(18, 8, 'amistad', '❌ Carla Díaz rechazó tu solicitud de amistad', NULL, 1, '2025-06-15 23:54:41'),
(19, 11, 'amistad', '❌ Rechazaste la solicitud de Lili Ejemplo', NULL, 1, '2025-06-15 23:54:41'),
(20, 11, 'amistad', '❌ Lili Ejemplo rechazó tu solicitud de amistad', NULL, 1, '2025-06-15 23:55:17'),
(21, 8, 'amistad', '❌ Rechazaste la solicitud de Carla Díaz', NULL, 1, '2025-06-15 23:55:17'),
(22, 11, 'amistad', 'Nueva solicitud de amistad de Lili Ejemplo', '/solicitud/10', 1, '2025-06-16 00:05:45'),
(23, 8, 'amistad', '❌ Carla Díaz rechazó tu solicitud de amistad', NULL, 1, '2025-06-16 00:06:10'),
(24, 11, 'amistad', '❌ Rechazaste la solicitud de Lili Ejemplo', NULL, 1, '2025-06-16 00:06:10'),
(25, 11, 'amistad', 'Nueva solicitud de amistad de Lili Ejemplo', '/solicitud/11', 1, '2025-06-16 00:19:39'),
(26, 11, 'amistad', 'Nueva solicitud de amistad de Martín Gómez', '/solicitud/12', 1, '2025-06-16 01:21:31'),
(27, 11, 'comentario', 'Martín Gómez comentó: Bello', '/imagen/13', 1, '2025-06-16 01:22:38'),
(28, 11, 'comentario', 'Lili Ejemplo comentó: Wao', '/perfil.html?usuario_id=11&img=13', 1, '2025-06-16 03:37:59'),
(29, 10, 'amistad', 'Nueva solicitud de amistad de Lili Ejemplo', '/solicitud/13', 1, '2025-06-16 16:30:22'),
(30, 10, 'amistad', 'Nueva solicitud de amistad de Carla Díaz', '/solicitud/14', 1, '2025-06-16 20:23:23'),
(31, 11, 'amistad', '✅ Martín Gómez aceptó tu solicitud de amistad', NULL, 1, '2025-06-16 20:23:42'),
(32, 8, 'amistad', 'Nueva solicitud de amistad de Carla Díaz', '/solicitud/15', 1, '2025-06-16 20:38:38'),
(33, 11, 'amistad', '✅ Lili Ejemplo aceptó tu solicitud de amistad', NULL, 1, '2025-06-16 20:39:53'),
(34, 11, 'amistad', 'Nueva solicitud de amistad de Lili Ejemplo', '/solicitud/16', 1, '2025-06-16 20:41:23'),
(35, 8, 'amistad', '✅ Carla Díaz aceptó tu solicitud de amistad', NULL, 1, '2025-06-16 20:41:56'),
(36, 11, 'amistad', '✅ Lucía Pérez aceptó tu solicitud de amistad', NULL, 1, '2025-06-16 21:59:39'),
(37, 11, 'amistad', 'Nueva solicitud de amistad de Lucía Pérez', '/solicitud/17', 1, '2025-06-16 21:59:56'),
(38, 8, 'amistad', 'Nueva solicitud de amistad de Lucía Pérez', '/solicitud/18', 1, '2025-06-16 22:00:34'),
(39, 10, 'amistad', 'Nueva solicitud de amistad de Lucía Pérez', '/solicitud/19', 1, '2025-06-16 23:34:39'),
(40, 9, 'amistad', '✅ Martín Gómez aceptó tu solicitud de amistad', NULL, 1, '2025-06-16 23:34:51'),
(41, 11, 'amistad', 'Nueva solicitud de amistad de Martín Gómez', '/solicitud/20', 1, '2025-06-16 23:35:58'),
(42, 9, 'amistad', 'Nueva solicitud de amistad de Martín Gómez', '/solicitud/21', 1, '2025-06-16 23:37:21'),
(43, 8, 'amistad', 'Nueva solicitud de amistad de Martín Gómez', '/solicitud/22', 1, '2025-06-16 23:37:35'),
(44, 10, 'amistad', '✅ Lucía Pérez aceptó tu solicitud de amistad', NULL, 1, '2025-06-16 23:37:52'),
(45, 9, 'amistad', '✅ Lili Ejemplo aceptó tu solicitud de amistad', NULL, 1, '2025-06-16 23:39:18'),
(46, 10, 'amistad', '✅ Lili Ejemplo aceptó tu solicitud de amistad', NULL, 1, '2025-06-16 23:39:18'),
(47, 10, 'amistad', 'Nueva solicitud de amistad de Lili Ejemplo', '/solicitud/23', 1, '2025-06-16 23:39:45'),
(48, 9, 'amistad', 'Nueva solicitud de amistad de Lili Ejemplo', '/solicitud/24', 1, '2025-06-16 23:39:50'),
(49, 8, 'amistad', '✅ Martín Gómez aceptó tu solicitud de amistad', NULL, 0, '2025-06-16 23:40:40'),
(50, 9, 'amistad', '✅ Carla Díaz aceptó tu solicitud de amistad', NULL, 1, '2025-06-16 23:41:59'),
(51, 10, 'amistad', '✅ Carla Díaz aceptó tu solicitud de amistad', NULL, 1, '2025-06-16 23:42:01'),
(52, 1, 'amistad', 'Nueva solicitud de amistad de Iara Nievas', '/solicitud/25', 1, '2025-06-16 23:44:24'),
(53, 8, 'amistad', '✅ Lucía Pérez aceptó tu solicitud de amistad', NULL, 0, '2025-06-16 23:44:45'),
(54, 11, 'amistad', '✅ mora aceptó tu solicitud de amistad', NULL, 1, '2025-06-16 23:45:08'),
(55, 2, 'amistad', '✅ mora aceptó tu solicitud de amistad', NULL, 1, '2025-06-16 23:45:09'),
(56, 2, 'amistad', 'Nueva solicitud de amistad de mora', '/solicitud/26', 1, '2025-06-16 23:45:42'),
(57, 1, 'amistad', '✅ Iara Nievas aceptó tu solicitud de amistad', NULL, 0, '2025-06-16 23:45:59'),
(58, 11, 'comentario', 'Martín Gómez comentó: Full Irlanda', '/perfil.html?usuario_id=11&img=15', 1, '2025-06-17 03:40:32'),
(59, 11, 'comentario', 'Martín Gómez comentó: Bellisimo', '/perfil.html?usuario_id=11&img=14', 1, '2025-06-17 10:32:48'),
(60, 10, 'amistad', 'Nueva solicitud de amistad de Carla Díaz', '/solicitud/27', 1, '2025-06-17 10:36:35'),
(61, 11, 'comentario', 'Martín Gómez comentó: Genial', '/perfil.html?usuario_id=11&img=15', 1, '2025-06-17 11:15:23'),
(62, 11, 'amistad', '✅ Martín Gómez aceptó tu solicitud de amistad', NULL, 1, '2025-06-17 11:18:22'),
(63, 10, 'comentario', 'Carla Díaz comentó: Muy bueno!', '/perfil.html?usuario_id=10&img=24', 0, '2025-06-17 11:24:17'),
(64, 10, 'comentario', 'Carla Díaz comentó: Muy bueno!', '/perfil.html?usuario_id=10&img=24', 0, '2025-06-17 11:24:29'),
(65, 11, 'comentario', 'Martín Gómez comentó: Genial', '/perfil.html?usuario_id=11&img=17', 1, '2025-06-17 11:43:42'),
(66, 11, 'comentario', 'Martín Gómez comentó: Genial', '/perfil.html?usuario_id=11&img=17', 1, '2025-06-17 11:44:35'),
(67, 11, 'comentario', 'Martín Gómez comentó: Genial', '/perfil.html?usuario_id=11&img=25', 1, '2025-06-17 11:50:44');

-- --------------------------------------------------------

--
-- Table structure for table `reportes`
--

CREATE TABLE `reportes` (
  `id` int(11) NOT NULL,
  `id_usuario` int(11) NOT NULL,
  `id_contenido` int(11) NOT NULL,
  `tipo_contenido` enum('imagen','comentario') NOT NULL,
  `motivo` text NOT NULL,
  `fecha_reporte` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `solicitudes_amistad`
--

CREATE TABLE `solicitudes_amistad` (
  `id` int(11) NOT NULL,
  `id_remitente` int(11) NOT NULL,
  `id_destinatario` int(11) NOT NULL,
  `estado` enum('pendiente','aceptada','rechazada') DEFAULT 'pendiente',
  `fecha_solicitud` timestamp NOT NULL DEFAULT current_timestamp(),
  `fecha_respuesta` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `solicitudes_amistad`
--

INSERT INTO `solicitudes_amistad` (`id`, `id_remitente`, `id_destinatario`, `estado`, `fecha_solicitud`, `fecha_respuesta`) VALUES
(1, 2, 1, 'aceptada', '2025-06-12 23:28:41', '2025-06-12 23:30:12'),
(2, 2, 1, 'aceptada', '2025-06-14 13:24:07', '2025-06-14 13:24:37'),
(3, 1, 2, 'aceptada', '2025-06-14 13:25:46', '2025-06-14 13:25:59'),
(4, 11, 1, 'aceptada', '2025-06-15 22:58:27', '2025-06-16 23:45:08'),
(5, 11, 10, 'aceptada', '2025-06-15 22:58:46', '2025-06-15 23:01:39'),
(6, 11, 10, 'aceptada', '2025-06-15 23:01:03', '2025-06-15 23:01:40'),
(7, 11, 8, 'rechazada', '2025-06-15 23:24:26', '2025-06-15 23:55:17'),
(8, 11, 9, 'aceptada', '2025-06-15 23:52:38', '2025-06-16 21:59:39'),
(9, 8, 11, 'rechazada', '2025-06-15 23:52:56', '2025-06-15 23:54:41'),
(10, 8, 11, 'rechazada', '2025-06-16 00:05:45', '2025-06-16 00:06:10'),
(11, 8, 11, 'aceptada', '2025-06-16 00:19:39', '2025-06-16 00:19:43'),
(12, 10, 11, 'aceptada', '2025-06-16 01:21:31', '2025-06-16 01:21:37'),
(13, 8, 10, 'aceptada', '2025-06-16 16:30:22', '2025-06-16 16:30:38'),
(14, 11, 10, 'aceptada', '2025-06-16 20:23:23', '2025-06-16 20:23:42'),
(15, 11, 8, 'aceptada', '2025-06-16 20:38:38', '2025-06-16 20:39:53'),
(16, 8, 11, 'aceptada', '2025-06-16 20:41:23', '2025-06-16 20:41:55'),
(17, 9, 11, 'aceptada', '2025-06-16 21:59:56', '2025-06-16 23:41:59'),
(18, 9, 8, 'aceptada', '2025-06-16 22:00:34', '2025-06-16 23:39:18'),
(19, 9, 10, 'aceptada', '2025-06-16 23:34:39', '2025-06-16 23:34:51'),
(20, 10, 11, 'aceptada', '2025-06-16 23:35:58', '2025-06-16 23:42:00'),
(21, 10, 9, 'aceptada', '2025-06-16 23:37:21', '2025-06-16 23:37:52'),
(22, 10, 8, 'aceptada', '2025-06-16 23:37:35', '2025-06-16 23:39:18'),
(23, 8, 10, 'aceptada', '2025-06-16 23:39:45', '2025-06-16 23:40:40'),
(24, 8, 9, 'aceptada', '2025-06-16 23:39:50', '2025-06-16 23:44:45'),
(25, 2, 1, 'aceptada', '2025-06-16 23:44:24', '2025-06-16 23:45:09'),
(26, 1, 2, 'aceptada', '2025-06-16 23:45:42', '2025-06-16 23:45:59'),
(27, 11, 10, 'aceptada', '2025-06-17 10:36:35', '2025-06-17 11:18:21');

-- --------------------------------------------------------

--
-- Table structure for table `tags`
--

CREATE TABLE `tags` (
  `id` int(11) NOT NULL,
  `nombre` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `usuarios`
--

CREATE TABLE `usuarios` (
  `id` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `imagen_perfil` varchar(255) DEFAULT NULL,
  `intereses` text DEFAULT NULL,
  `antecedentes` text DEFAULT NULL,
  `modo_vitrina` tinyint(1) DEFAULT 0,
  `fecha_registro` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `usuarios`
--

INSERT INTO `usuarios` (`id`, `nombre`, `email`, `password`, `imagen_perfil`, `intereses`, `antecedentes`, `modo_vitrina`, `fecha_registro`) VALUES
(1, 'mora', 'mora@ejemplo.com', '$2b$10$w71o5XrDTPiDG7p4kUK0UuCEvUVMlt5WmA0drzs55Nz6Mgvfp0jDy', NULL, NULL, NULL, 0, '2025-06-12 14:24:45'),
(2, 'Iara Nievas', 'iara@ejemplo.com', '$2b$10$2rZXTtFHWeUczhgEX6n0Jew.h2i5QLU.2ZCxsuwWHwSbUfMdZrLBa', NULL, 'Música y arte.', '', 0, '2025-06-12 23:27:56'),
(8, 'Lili Ejemplo', 'lili@ejemplo.com', '$2b$10$PWdVCNRaitsaH6lR.M82I.G6Skx2.ufFB1bKZOUJOMSvWbd0z9sp2', NULL, NULL, NULL, 0, '2025-06-15 22:26:48'),
(9, 'Lucía Pérez', 'lucia@ejemplo.com', '$2b$10$hTdSedLL4lOAMTmpTojN..arQ2YnoL49NxpX/SooWRa1VkXkjZmVO', NULL, NULL, NULL, 0, '2025-06-15 22:56:16'),
(10, 'Martín Gómez', 'martin@ejemplo.com', '$2b$10$Szvnnr37b/HCD9n0BpA/G.F9sHlNNbd4r/19/XLEIKETh/cGA9w6q', NULL, NULL, NULL, 0, '2025-06-15 22:57:06'),
(11, 'Carla Díaz', 'carla@ejemplo.com', '$2b$10$FOU/M83o/x9SMeUnYo1MW.KbiOSycE6Fvj.9uXFfpAW5i3msDjewS', NULL, NULL, NULL, 0, '2025-06-15 22:57:39');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `albumes`
--
ALTER TABLE `albumes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_usuario_album` (`id_usuario`),
  ADD KEY `fk_albumes_amigo` (`id_amigo`);

--
-- Indexes for table `amistades`
--
ALTER TABLE `amistades`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique_seguidor` (`id_usuario`,`id_amigo`),
  ADD KEY `id_amigo` (`id_amigo`);

--
-- Indexes for table `comentarios`
--
ALTER TABLE `comentarios`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_usuario` (`id_usuario`),
  ADD KEY `idx_imagen_comentario` (`id_imagen`);

--
-- Indexes for table `eventos`
--
ALTER TABLE `eventos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_usuario` (`id_usuario`),
  ADD KEY `idx_evento_fecha` (`fecha_evento`);

--
-- Indexes for table `imagenes`
--
ALTER TABLE `imagenes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_usuario` (`id_usuario`),
  ADD KEY `idx_album_imagen` (`id_album`);

--
-- Indexes for table `imagenes_compartidas`
--
ALTER TABLE `imagenes_compartidas`
  ADD PRIMARY KEY (`id_imagen`,`id_usuario`),
  ADD KEY `id_usuario` (`id_usuario`);

--
-- Indexes for table `imagenes_tags`
--
ALTER TABLE `imagenes_tags`
  ADD PRIMARY KEY (`id_imagen`,`id_tag`),
  ADD KEY `id_tag` (`id_tag`);

--
-- Indexes for table `inscripciones_evento`
--
ALTER TABLE `inscripciones_evento`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_evento` (`id_evento`),
  ADD KEY `id_usuario` (`id_usuario`);

--
-- Indexes for table `notificaciones`
--
ALTER TABLE `notificaciones`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_usuario` (`id_usuario`);

--
-- Indexes for table `reportes`
--
ALTER TABLE `reportes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_usuario` (`id_usuario`);

--
-- Indexes for table `solicitudes_amistad`
--
ALTER TABLE `solicitudes_amistad`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_remitente` (`id_remitente`),
  ADD KEY `id_destinatario` (`id_destinatario`);

--
-- Indexes for table `tags`
--
ALTER TABLE `tags`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `nombre` (`nombre`);

--
-- Indexes for table `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `albumes`
--
ALTER TABLE `albumes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=41;

--
-- AUTO_INCREMENT for table `amistades`
--
ALTER TABLE `amistades`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=28;

--
-- AUTO_INCREMENT for table `comentarios`
--
ALTER TABLE `comentarios`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `eventos`
--
ALTER TABLE `eventos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `imagenes`
--
ALTER TABLE `imagenes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;

--
-- AUTO_INCREMENT for table `inscripciones_evento`
--
ALTER TABLE `inscripciones_evento`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `notificaciones`
--
ALTER TABLE `notificaciones`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=68;

--
-- AUTO_INCREMENT for table `reportes`
--
ALTER TABLE `reportes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `solicitudes_amistad`
--
ALTER TABLE `solicitudes_amistad`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=28;

--
-- AUTO_INCREMENT for table `tags`
--
ALTER TABLE `tags`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `albumes`
--
ALTER TABLE `albumes`
  ADD CONSTRAINT `albumes_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_albumes_amigo` FOREIGN KEY (`id_amigo`) REFERENCES `usuarios` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `amistades`
--
ALTER TABLE `amistades`
  ADD CONSTRAINT `amistades_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `amistades_ibfk_2` FOREIGN KEY (`id_amigo`) REFERENCES `usuarios` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `comentarios`
--
ALTER TABLE `comentarios`
  ADD CONSTRAINT `comentarios_ibfk_1` FOREIGN KEY (`id_imagen`) REFERENCES `imagenes` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `comentarios_ibfk_2` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `eventos`
--
ALTER TABLE `eventos`
  ADD CONSTRAINT `eventos_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `imagenes`
--
ALTER TABLE `imagenes`
  ADD CONSTRAINT `imagenes_ibfk_1` FOREIGN KEY (`id_album`) REFERENCES `albumes` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `imagenes_ibfk_2` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `imagenes_compartidas`
--
ALTER TABLE `imagenes_compartidas`
  ADD CONSTRAINT `imagenes_compartidas_ibfk_1` FOREIGN KEY (`id_imagen`) REFERENCES `imagenes` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `imagenes_compartidas_ibfk_2` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `imagenes_tags`
--
ALTER TABLE `imagenes_tags`
  ADD CONSTRAINT `imagenes_tags_ibfk_1` FOREIGN KEY (`id_imagen`) REFERENCES `imagenes` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `imagenes_tags_ibfk_2` FOREIGN KEY (`id_tag`) REFERENCES `tags` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `inscripciones_evento`
--
ALTER TABLE `inscripciones_evento`
  ADD CONSTRAINT `inscripciones_evento_ibfk_1` FOREIGN KEY (`id_evento`) REFERENCES `eventos` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `inscripciones_evento_ibfk_2` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `notificaciones`
--
ALTER TABLE `notificaciones`
  ADD CONSTRAINT `notificaciones_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `reportes`
--
ALTER TABLE `reportes`
  ADD CONSTRAINT `reportes_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `solicitudes_amistad`
--
ALTER TABLE `solicitudes_amistad`
  ADD CONSTRAINT `solicitudes_amistad_ibfk_1` FOREIGN KEY (`id_remitente`) REFERENCES `usuarios` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `solicitudes_amistad_ibfk_2` FOREIGN KEY (`id_destinatario`) REFERENCES `usuarios` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
