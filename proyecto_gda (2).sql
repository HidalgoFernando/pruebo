-- phpMyAdmin SQL Dump
-- version 6.0.0-dev+20230530.f110beb5f3
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 04-07-2023 a las 08:10:18
-- Versión del servidor: 10.4.24-MariaDB
-- Versión de PHP: 8.1.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `proyecto_gda`
--

DELIMITER $$
--
-- Procedimientos
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `DarAltaAlumno` (IN `nombre` VARCHAR(50), IN `apellido` VARCHAR(50), IN `documento` INT(20))   BEGIN
	INSERT INTO alumnos(Nombre,Apellido,Documento) VALUES (nombre,apellido,documento)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `DarAltaResponsable` (IN `nombre` VARCHAR(50), IN `apellido` VARCHAR(50), IN `documento` INT(20), IN `telefono` INT(11), IN `correo` VARCHAR(50), IN `firma` VARCHAR(150), IN `idAlumno` INT(11))   BEGIN
	DECLARE ultimo_responsable_id INT DEFAULT 0$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `DarAltaUsuario` (IN `usuario` VARCHAR(50), IN `contrasena` VARCHAR(50), IN `rol` INT(11))   BEGIN
	INSERT INTO usuarios VALUES (NULL, usuario, contrasena, rol, NULL)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `DarBajaAlumno` (IN `id` INT(11))   BEGIN
	UPDATE alumnos SET alumnos.DadoDeBaja = CURRENT_TIMESTAMP() WHERE alumnos.ID = id$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `DarBajaResponsable` (IN `id` INT(11))   BEGIN
	UPDATE responsables SET responsables.DadoDeBaja = CURRENT_TIMESTAMP() WHERE responsables.ID = id$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `DarBajaUsuario` (IN `id` INT(11))   BEGIN
	UPDATE usuarios SET usuarios.DadoDeBaja = CURRENT_TIMESTAMP() WHERE usuarios.ID = id$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `ModificarAlumno` (IN `id` INT(11), IN `nombre` VARCHAR(50), IN `apellido` VARCHAR(50), IN `documento` INT(20))   BEGIN
	UPDATE alumnos SET alumnos.Nombre = nombre, alumnos.Apellido = apellido, alumnos.Documento = documento WHERE alumnos.ID = id$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `ModificarResponsable` (IN `id` INT(11), IN `nombre` VARCHAR(50), IN `apellido` VARCHAR(50), IN `documento` INT(20), IN `telefono` INT(11), IN `correo` VARCHAR(50), IN `firma` VARCHAR(150))   BEGIN
	UPDATE responsables SET responsables.Nombre = nombre, responsables.Apellido = apellido, responsables.Documento = documento, responsables.Telefono = telefono, responsables.CorreoElectronico = correo, responsables.Firma = Firma WHERE responsables.ID = id$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `ModificarUsuario` (IN `id` INT(11), IN `usuario` VARCHAR(50), IN `contrasena` VARCHAR(50), IN `rol` INT(11))   BEGIN
	UPDATE usuarios SET usuarios.Usuario = usuario, usuarios.Contrasena = contrasena, usuarios.ID_rol = rol WHERE usuarios.ID = id$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `VerAlumnos` (IN `nombre` VARCHAR(50), IN `apellido` VARCHAR(50), IN `documento` VARCHAR(20))   BEGIN
	IF LENGTH(nombre) > 0 AND LENGTH(apellido) > 0 AND LENGTH(documento) > 0 THEN 
    	SELECT alumnos.ID AS 'N°', alumnos.Nombre AS 'Nombre', alumnos.Apellido AS 'Apellido', alumnos.Documento AS 'Documento' FROM alumnos WHERE alumnos.Nombre LIKE CONCAT("%",nombre,"%") AND alumnos.Apellido LIKE CONCAT("%",apellido,"%") AND alumnos.Documento LIKE CONCAT("%",documento,"%") AND DadoDeBaja IS NULL$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `VerResponsables` (IN `idAlumno` INT(11))   BEGIN
	SELECT responsables.ID AS 'N°', responsables.Nombre AS 'Nombre', responsables.Apellido AS 'Apellido', responsables.Documento AS 'Documento', responsables.Telefono AS 'Telefono', responsables.CorreoElectronico AS 'Correo', responsables.Firma AS 'Firma' FROM responsables INNER JOIN union_res_alumno ON responsables.ID = union_res_alumno.ID_responsable WHERE union_res_alumno.ID_alumno = idAlumno AND responsables.DadoDeBaja IS NULL$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `VerRoles` ()   BEGIN
	SELECT permisos.ID, permisos.rol FROM `permisos`$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `VerUsuarios` ()   BEGIN
	SELECT usuarios.ID AS 'N°', usuarios.Usuario AS 'Nombre de usuario', usuarios.Contrasena AS 'Contraseña', usuarios.ID_rol AS 'N° rol', permisos.rol AS 'Roles' FROM `usuarios` INNER JOIN `permisos` ON usuarios.ID_rol = permisos.ID WHERE usuarios.DadoDeBaja IS NULL$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `alumnos`
--

CREATE TABLE `alumnos` (
  `ID` int(11) NOT NULL,
  `Nombre` varchar(50) NOT NULL,
  `Apellido` varchar(50) NOT NULL,
  `Documento` int(20) NOT NULL,
  `DadoDeBaja` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `alumnos`
--

INSERT INTO `alumnos` (`ID`, `Nombre`, `Apellido`, `Documento`, `DadoDeBaja`) VALUES
(1, 'Jose', 'Perez', 46247682, NULL),
(2, 'Perez', 'Carlos', 54621462, NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `motivos`
--

CREATE TABLE `motivos` (
  `ID` int(11) NOT NULL,
  `Responsable` int(11) NOT NULL,
  `Curso` varchar(50) NOT NULL,
  `Turno` varchar(30) NOT NULL,
  `Preceptor` varchar(50) NOT NULL,
  `Descripcion` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `permisos`
--

CREATE TABLE `permisos` (
  `ID` int(11) NOT NULL,
  `Rol` varchar(20) NOT NULL,
  `Descripcion` varchar(300) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `permisos`
--

INSERT INTO `permisos` (`ID`, `Rol`, `Descripcion`) VALUES
(1, 'Administrador', ''),
(2, 'Regente', ''),
(3, 'Administrativo', ''),
(4, 'DOE', '');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `responsables`
--

CREATE TABLE `responsables` (
  `ID` int(11) NOT NULL,
  `Nombre` varchar(50) NOT NULL,
  `Apellido` varchar(50) NOT NULL,
  `Documento` int(20) NOT NULL,
  `Telefono` int(11) NOT NULL,
  `CorreoElectronico` varchar(50) NOT NULL,
  `Firma` varchar(150) NOT NULL,
  `DadoDeBaja` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `responsables`
--

INSERT INTO `responsables` (`ID`, `Nombre`, `Apellido`, `Documento`, `Telefono`, `CorreoElectronico`, `Firma`, `DadoDeBaja`) VALUES
(1, 'Jose', 'Rios', 26321458, 1122223333, 'JoseRios@gmail.com', 'C:\\Users\\...\\Desktop\\archivo.pdf', NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `reuniones_doe`
--

CREATE TABLE `reuniones_doe` (
  `ID` int(11) NOT NULL,
  `NombrePsicologa` varchar(200) NOT NULL,
  `Fecha` datetime NOT NULL,
  `NombreAlumno` varchar(200) NOT NULL,
  `Documento` int(20) NOT NULL,
  `descripcion` varchar(1000) NOT NULL,
  `resolucion` varchar(1000) NOT NULL,
  `ObraSocial` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `sanciones`
--

CREATE TABLE `sanciones` (
  `ID` int(11) NOT NULL,
  `Tipo` varchar(50) NOT NULL,
  `Fecha` date NOT NULL,
  `Descripcion` varchar(500) NOT NULL,
  `IntegrantesConsejoConvivencia` int(11) NOT NULL,
  `Hora` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `Resolucion` varchar(500) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `seguimiento`
--

CREATE TABLE `seguimiento` (
  `ID` int(11) NOT NULL,
  `Union` int(11) NOT NULL,
  `Alumno` int(11) NOT NULL,
  `Responsable` int(11) NOT NULL,
  `Motivos` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `union_res_alumno`
--

CREATE TABLE `union_res_alumno` (
  `ID` int(11) NOT NULL,
  `ID_alumno` int(11) NOT NULL,
  `ID_responsable` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `union_res_alumno`
--

INSERT INTO `union_res_alumno` (`ID`, `ID_alumno`, `ID_responsable`) VALUES
(1, 1, 1),
(2, 2, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios`
--

CREATE TABLE `usuarios` (
  `ID` int(11) NOT NULL,
  `Usuario` varchar(50) NOT NULL,
  `Contrasena` varchar(50) NOT NULL,
  `ID_rol` int(11) NOT NULL,
  `DadoDeBaja` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `usuarios`
--

INSERT INTO `usuarios` (`ID`, `Usuario`, `Contrasena`, `ID_rol`, `DadoDeBaja`) VALUES
(1, 'root', '111', 1, NULL),
(2, 'Jorge', '222', 2, NULL),
(3, 'Perez', '333', 3, NULL),
(4, 'Mauricio', '444', 4, NULL);

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `alumnos`
--
ALTER TABLE `alumnos`
  ADD PRIMARY KEY (`ID`);

--
-- Indices de la tabla `motivos`
--
ALTER TABLE `motivos`
  ADD PRIMARY KEY (`ID`) USING BTREE,
  ADD KEY `FK_MOT_RESPONS` (`Responsable`);

--
-- Indices de la tabla `permisos`
--
ALTER TABLE `permisos`
  ADD PRIMARY KEY (`ID`);

--
-- Indices de la tabla `responsables`
--
ALTER TABLE `responsables`
  ADD PRIMARY KEY (`ID`) USING BTREE,
  ADD UNIQUE KEY `Documento` (`Documento`) USING BTREE;

--
-- Indices de la tabla `reuniones_doe`
--
ALTER TABLE `reuniones_doe`
  ADD PRIMARY KEY (`ID`) USING BTREE;

--
-- Indices de la tabla `sanciones`
--
ALTER TABLE `sanciones`
  ADD PRIMARY KEY (`ID`) USING BTREE;

--
-- Indices de la tabla `seguimiento`
--
ALTER TABLE `seguimiento`
  ADD PRIMARY KEY (`ID`) USING BTREE,
  ADD KEY `FK_SEG_ALUMNO` (`Alumno`),
  ADD KEY `FK_SEG_RESPONS` (`Responsable`),
  ADD KEY `FK_SEG_MOTIVOS` (`Motivos`) USING BTREE,
  ADD KEY `FK_UNION` (`Union`) USING BTREE;

--
-- Indices de la tabla `union_res_alumno`
--
ALTER TABLE `union_res_alumno`
  ADD PRIMARY KEY (`ID`) USING BTREE,
  ADD KEY `FK_AL_RES` (`ID_alumno`,`ID_responsable`),
  ADD KEY `ID_respons` (`ID_responsable`);

--
-- Indices de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`ID`) USING BTREE,
  ADD KEY `FK_US_ROL` (`ID_rol`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `alumnos`
--
ALTER TABLE `alumnos`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `motivos`
--
ALTER TABLE `motivos`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `permisos`
--
ALTER TABLE `permisos`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `responsables`
--
ALTER TABLE `responsables`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT de la tabla `reuniones_doe`
--
ALTER TABLE `reuniones_doe`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `sanciones`
--
ALTER TABLE `sanciones`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `seguimiento`
--
ALTER TABLE `seguimiento`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `union_res_alumno`
--
ALTER TABLE `union_res_alumno`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `seguimiento`
--
ALTER TABLE `seguimiento`
  ADD CONSTRAINT `alumno_ibfk_1` FOREIGN KEY (`Alumno`) REFERENCES `alumnos` (`ID`),
  ADD CONSTRAINT `seguimiento_ibfk_1` FOREIGN KEY (`Motivos`) REFERENCES `motivos` (`ID`);

--
-- Filtros para la tabla `union_res_alumno`
--
ALTER TABLE `union_res_alumno`
  ADD CONSTRAINT `union_res_alumno_ibfk_1` FOREIGN KEY (`ID_alumno`) REFERENCES `alumnos` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `union_res_alumno_ibfk_2` FOREIGN KEY (`ID_responsable`) REFERENCES `responsables` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD CONSTRAINT `usuarios_ibfk_1` FOREIGN KEY (`ID_rol`) REFERENCES `permisos` (`ID`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
