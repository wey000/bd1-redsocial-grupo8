-- =============================================================================
-- INSTITUCIÓN UNIVERSITARIA PASCUAL BRAVO
-- Asignatura: Bases de Datos I
-- Proyecto: Red Social Estudiantil Pascualina
-- Entregable: Tarea 3 - Modelo Físico (DDL)
-- =============================================================================

-- 1. Borrar la base de datos por completo para limpiar cualquier residuo anterior
DROP DATABASE IF EXISTS bd_redsocial_pascualina;

-- 2. Crear y seleccionar la base de datos limpia
CREATE DATABASE bd_redsocial_pascualina;
USE bd_redsocial_pascualina;

-- =============================================================================
-- 3. CREACIÓN DE TABLAS (MODELO FÍSICO)
-- =============================================================================

-- Tabla: usuarios
CREATE TABLE usuarios (
    id_usuario INT AUTO_INCREMENT PRIMARY KEY,
    nombre_completo VARCHAR(100) NOT NULL,
    correo_institucional VARCHAR(100) NOT NULL UNIQUE,
    carrera_programa VARCHAR(100) NOT NULL,
    intereses_deportes VARCHAR(255) NULL,
    fecha_registro DATETIME DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Tabla: conexiones_seguidores
CREATE TABLE conexiones_seguidores (
    id_conexion INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario_seguidor INT NOT NULL,
    id_usuario_seguido INT NOT NULL,
    tipo_conexion VARCHAR(20) NOT NULL,
    fecha_conexion DATETIME DEFAULT CURRENT_TIMESTAMP,
    
    CONSTRAINT fk_conexion_seguidor 
        FOREIGN KEY (id_usuario_seguidor) REFERENCES usuarios(id_usuario) 
        ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_conexion_seguido 
        FOREIGN KEY (id_usuario_seguido) REFERENCES usuarios(id_usuario) 
        ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT chk_no_autoseguimiento CHECK (id_usuario_seguidor <> id_usuario_seguido)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Tabla: publicaciones
CREATE TABLE publicaciones (
    id_publicacion INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario_autor INT NOT NULL,
    tipo_categoria VARCHAR(30) NOT NULL,
    contenido_texto TEXT NOT NULL,
    url_multimedia VARCHAR(255) NULL,
    fecha_publicacion DATETIME DEFAULT CURRENT_TIMESTAMP,
    
    CONSTRAINT fk_publicacion_autor 
        FOREIGN KEY (id_usuario_autor) REFERENCES usuarios(id_usuario) 
        ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Tabla: grupos
CREATE TABLE grupos (
    id_grupo INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario_creador INT NOT NULL,
    nombre_grupo VARCHAR(100) NOT NULL,
    descripcion TEXT NULL,
    tipo_grupo VARCHAR(50) NOT NULL,
    
    CONSTRAINT fk_grupo_creador 
        FOREIGN KEY (id_usuario_creador) REFERENCES usuarios(id_usuario) 
        ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Tabla: miembros_grupo
CREATE TABLE miembros_grupo (
    id_miembro_grupo INT AUTO_INCREMENT PRIMARY KEY,
    id_grupo INT NOT NULL,
    id_usuario INT NOT NULL,
    rol_miembro VARCHAR(30) DEFAULT 'miembro',
    fecha_ingreso DATETIME DEFAULT CURRENT_TIMESTAMP,
    
    CONSTRAINT fk_miembro_grupo 
        FOREIGN KEY (id_grupo) REFERENCES grupos(id_grupo) 
        ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_miembro_usuario 
        FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario) 
        ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT uk_usuario_grupo UNIQUE (id_grupo, id_usuario)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Tabla: eventos
CREATE TABLE eventos (
    id_evento INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario_organizador INT NOT NULL,
    id_grupo INT NULL,
    titulo_evento VARCHAR(150) NOT NULL,
    tipo_evento VARCHAR(50) NOT NULL,
    fecha_inicio DATETIME NOT NULL,
    
    CONSTRAINT fk_evento_organizador 
        FOREIGN KEY (id_usuario_organizador) REFERENCES usuarios(id_usuario) 
        ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_evento_grupo 
        FOREIGN KEY (id_grupo) REFERENCES grupos(id_grupo) 
        ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Tabla: asistentes_evento
CREATE TABLE asistentes_evento (
    id_asistencia INT AUTO_INCREMENT PRIMARY KEY,
    id_evento INT NOT NULL,
    id_usuario INT NOT NULL,
    estado_confirmacion VARCHAR(20) DEFAULT 'confirmado',
    
    CONSTRAINT fk_asistencia_evento 
        FOREIGN KEY (id_evento) REFERENCES eventos(id_evento) 
        ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_asistencia_usuario 
        FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario) 
        ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT uk_usuario_evento UNIQUE (id_evento, id_usuario)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;