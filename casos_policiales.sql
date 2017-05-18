-- phpMyAdmin SQL Dump
-- version 4.5.1
-- http://www.phpmyadmin.net
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 18-04-2017 a las 12:44:47
-- Versión del servidor: 10.1.16-MariaDB
-- Versión de PHP: 5.6.24

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `casos_policiales`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `caso_policial`
--

CREATE TABLE `caso_policial` (
  `codCaso` char(4) NOT NULL,
  `nombre` varchar(100) DEFAULT NULL,
  `fecha_inicio` date DEFAULT NULL,
  `fecha_fin` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `caso_policial`
--

INSERT INTO `caso_policial` (`codCaso`, `nombre`, `fecha_inicio`, `fecha_fin`) VALUES
('C001', 'Estudio en Escarlata', '2010-01-01', '2012-01-10'),
('C002', 'El valle del terror', '2011-07-11', '2012-05-14'),
('C003', 'El signo de los cuatro', '2012-10-09', NULL),
('C004', 'Los crímenes de la calle Morgue', '2012-10-14', NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `colabora`
--

CREATE TABLE `colabora` (
  `codExperto` char(4) NOT NULL,
  `codCaso` char(4) NOT NULL,
  `fecha` date NOT NULL,
  `descripcion_colaboracion` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `colabora`
--

INSERT INTO `colabora` (`codExperto`, `codCaso`, `fecha`, `descripcion_colaboracion`) VALUES
('E001', 'C001', '2010-01-02', 'Análisis de huesos'),
('E001', 'C002', '2011-11-07', 'Análisis de huesos'),
('E001', 'C002', '2011-11-08', 'Análisis de huesos'),
('E001', 'C002', '2011-11-09', 'Análisis de huesos'),
('E001', 'C002', '2011-11-10', 'Autopsia'),
('E002', 'C001', '2011-01-07', 'Análisis de insectos'),
('E002', 'C001', '2011-01-08', 'Análisis de insectos'),
('E002', 'C004', '2012-10-15', 'Análisis de insectos'),
('E003', 'C004', '2012-10-15', 'Determinación de trayectoria balística'),
('E003', 'C004', '2012-10-16', 'Identificación de arma'),
('E004', 'C003', '2012-10-15', 'Prueba de lenguaje no verbal'),
('E004', 'C003', '2012-10-16', 'Identificación de mentira'),
('E004', 'C003', '2012-10-17', 'Identificación de mentira'),
('E004', 'C003', '2012-10-18', 'Identificación de mentira'),
('E004', 'C003', '2012-10-19', 'Identificación de mentira'),
('E005', 'C001', '2012-01-01', 'Análisis de conducta'),
('E005', 'C001', '2012-01-05', 'Estudio de perfil psicológico'),
('E005', 'C002', '2012-05-13', 'Estudio de perfil psicológico'),
('E005', 'C002', '2012-05-14', 'Estudio de perfil psicológico'),
('E005', 'C003', '2012-10-14', 'Estudio de perfil psicológico'),
('E005', 'C004', '2012-10-14', 'Estudio de perfil psicológico'),
('E007', 'C004', '2012-10-27', 'Informe acceso a base de datos');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `experto`
--

CREATE TABLE `experto` (
  `codExperto` char(4) NOT NULL,
  `nombre` varchar(50) NOT NULL,
  `pais` varchar(50) NOT NULL,
  `sexo` char(1) DEFAULT NULL,
  `especialidad` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `experto`
--

INSERT INTO `experto` (`codExperto`, `nombre`, `pais`, `sexo`, `especialidad`) VALUES
('E001', 'Temperance Brennan', 'EEUU', 'F', 'Antropología'),
('E002', 'Gil Grissom', 'EEUU', 'M', 'Entomología'),
('E003', 'Calleigh Duquesne', 'EEUU', 'F', 'Armas'),
('E004', 'Cal Lightman', 'Inglaterra', 'M', 'Lenguaje Corporal'),
('E005', 'Spencer Reid', 'EEUU', 'M', 'Psicoloanálisis'),
('E006', 'Penélope García', 'EEUU', 'F', 'Técnico Informático'),
('E007', 'Adelino Gutiérrez', 'España', 'M', 'Criminología');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `caso_policial`
--
ALTER TABLE `caso_policial`
  ADD PRIMARY KEY (`codCaso`);

--
-- Indices de la tabla `colabora`
--
ALTER TABLE `colabora`
  ADD PRIMARY KEY (`codExperto`,`codCaso`,`fecha`),
  ADD KEY `colaboraAjena2` (`codCaso`);

--
-- Indices de la tabla `experto`
--
ALTER TABLE `experto`
  ADD PRIMARY KEY (`codExperto`),
  ADD UNIQUE KEY `nombreUnico` (`nombre`);

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `colabora`
--
ALTER TABLE `colabora`
  ADD CONSTRAINT `colaboraAjena1` FOREIGN KEY (`codExperto`) REFERENCES `experto` (`codExperto`) ON DELETE CASCADE,
  ADD CONSTRAINT `colaboraAjena2` FOREIGN KEY (`codCaso`) REFERENCES `caso_policial` (`codCaso`) ON DELETE CASCADE;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
