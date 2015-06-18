-- phpMyAdmin SQL Dump
-- version 3.4.10.1
-- http://www.phpmyadmin.net
--
-- Servidor: localhost
-- Tiempo de generación: 18-06-2015 a las 13:16:12
-- Versión del servidor: 5.5.20
-- Versión de PHP: 5.3.10

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Base de datos: `rekotest`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `authassignment`
--

CREATE TABLE IF NOT EXISTS `authassignment` (
  `itemname` varchar(64) NOT NULL,
  `userid` varchar(64) NOT NULL,
  `bizrule` text,
  `data` text,
  PRIMARY KEY (`itemname`,`userid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `authitem`
--

CREATE TABLE IF NOT EXISTS `authitem` (
  `name` varchar(64) NOT NULL,
  `type` int(11) NOT NULL,
  `description` text,
  `bizrule` text,
  `data` text,
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `authitem`
--

INSERT INTO `authitem` (`name`, `type`, `description`, `bizrule`, `data`) VALUES
('administracionrol', 2, NULL, NULL, NULL),
('administracionusuario', 2, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `authitemchild`
--

CREATE TABLE IF NOT EXISTS `authitemchild` (
  `parent` varchar(64) NOT NULL,
  `child` varchar(64) NOT NULL,
  PRIMARY KEY (`parent`,`child`),
  KEY `child` (`child`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `privilegio_administrador`
--

CREATE TABLE IF NOT EXISTS `privilegio_administrador` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(45) DEFAULT NULL,
  `descripcion` varchar(45) DEFAULT NULL,
  `authitem_name` varchar(64) NOT NULL,
  PRIMARY KEY (`id`,`authitem_name`),
  KEY `fk_privilegio_administrador_authitem1_idx` (`authitem_name`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=7 ;

--
-- Volcado de datos para la tabla `privilegio_administrador`
--

INSERT INTO `privilegio_administrador` (`id`, `nombre`, `descripcion`, `authitem_name`) VALUES
(1, 'index', NULL, 'administracionrol'),
(1, 'index', NULL, 'administracionusuario'),
(2, 'view', NULL, 'administracionrol'),
(2, 'view', NULL, 'administracionusuario'),
(3, 'admin', NULL, 'administracionrol'),
(3, 'admin', NULL, 'administracionusuario'),
(4, 'create', NULL, 'administracionrol'),
(4, 'create', NULL, 'administracionusuario'),
(5, 'update', NULL, 'administracionrol'),
(5, 'update', NULL, 'administracionusuario'),
(6, 'delete', NULL, 'administracionrol'),
(6, 'delete', NULL, 'administracionusuario');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `rol_administrador`
--

CREATE TABLE IF NOT EXISTS `rol_administrador` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(45) DEFAULT NULL,
  `descripcion` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=3 ;

--
-- Volcado de datos para la tabla `rol_administrador`
--

INSERT INTO `rol_administrador` (`id`, `nombre`, `descripcion`) VALUES
(1, 'superadministrador', NULL),
(2, 'administrador_usuario_rol', NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `rol_administrador_has_authitem`
--

CREATE TABLE IF NOT EXISTS `rol_administrador_has_authitem` (
  `rol_administrador_id` int(11) NOT NULL,
  `authitem_name` varchar(64) NOT NULL,
  PRIMARY KEY (`rol_administrador_id`,`authitem_name`),
  KEY `fk_rol_administrador_has_authitem_authitem1_idx` (`authitem_name`),
  KEY `fk_rol_administrador_has_authitem_rol_administrador1_idx` (`rol_administrador_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `rol_administrador_has_authitem`
--

INSERT INTO `rol_administrador_has_authitem` (`rol_administrador_id`, `authitem_name`) VALUES
(1, 'administracionusuario'),
(2, 'administracionrol'),
(2, 'administracionusuario');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuario_administrador`
--

CREATE TABLE IF NOT EXISTS `usuario_administrador` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `usuario` varchar(45) DEFAULT NULL,
  `clave` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=4 ;

--
-- Volcado de datos para la tabla `usuario_administrador`
--

INSERT INTO `usuario_administrador` (`id`, `usuario`, `clave`) VALUES
(1, 'john', '123'),
(2, 'diego', '123'),
(3, 'christian', '123');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuario_administrador_has_rol_administrador`
--

CREATE TABLE IF NOT EXISTS `usuario_administrador_has_rol_administrador` (
  `usuario_administrador_id` int(11) NOT NULL,
  `rol_administrador_id` int(11) NOT NULL,
  PRIMARY KEY (`usuario_administrador_id`,`rol_administrador_id`),
  KEY `fk_usuario_administrador_has_rol_administrador_rol_administ_idx` (`rol_administrador_id`),
  KEY `fk_usuario_administrador_has_rol_administrador_usuario_admi_idx` (`usuario_administrador_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `usuario_administrador_has_rol_administrador`
--

INSERT INTO `usuario_administrador_has_rol_administrador` (`usuario_administrador_id`, `rol_administrador_id`) VALUES
(1, 1);

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `authassignment`
--
ALTER TABLE `authassignment`
  ADD CONSTRAINT `authassignment_ibfk_1` FOREIGN KEY (`itemname`) REFERENCES `authitem` (`name`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `authitemchild`
--
ALTER TABLE `authitemchild`
  ADD CONSTRAINT `authitemchild_ibfk_1` FOREIGN KEY (`parent`) REFERENCES `authitem` (`name`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `authitemchild_ibfk_2` FOREIGN KEY (`child`) REFERENCES `authitem` (`name`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `privilegio_administrador`
--
ALTER TABLE `privilegio_administrador`
  ADD CONSTRAINT `fk_privilegio_administrador_authitem1` FOREIGN KEY (`authitem_name`) REFERENCES `authitem` (`name`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `rol_administrador_has_authitem`
--
ALTER TABLE `rol_administrador_has_authitem`
  ADD CONSTRAINT `fk_rol_administrador_has_authitem_authitem1` FOREIGN KEY (`authitem_name`) REFERENCES `authitem` (`name`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_rol_administrador_has_authitem_rol_administrador1` FOREIGN KEY (`rol_administrador_id`) REFERENCES `rol_administrador` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `usuario_administrador_has_rol_administrador`
--
ALTER TABLE `usuario_administrador_has_rol_administrador`
  ADD CONSTRAINT `fk_usuario_administrador_has_rol_administrador_rol_administra1` FOREIGN KEY (`rol_administrador_id`) REFERENCES `rol_administrador` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_usuario_administrador_has_rol_administrador_usuario_admini1` FOREIGN KEY (`usuario_administrador_id`) REFERENCES `usuario_administrador` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
