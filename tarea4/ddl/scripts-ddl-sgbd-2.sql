CREATE TABLE IF NOT EXISTS usuarios (
    id_usuario SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    correo_institucional VARCHAR(150) UNIQUE NOT NULL,
    contrasena VARCHAR(255) NOT NULL,
    fecha_registro TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS perfiles_usuario (
    id_perfil SERIAL PRIMARY KEY,
    id_usuario INT UNIQUE NOT NULL,
    biografia TEXT,
    foto_perfil VARCHAR(255),
    CONSTRAINT fk_perfil_usuario FOREIGN KEY (id_usuario) 
        REFERENCES usuarios(id_usuario) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS roles_sistema (
    id_rol SERIAL PRIMARY KEY,
    nombre_rol VARCHAR(50) UNIQUE NOT NULL
);

CREATE TABLE IF NOT EXISTS usuario_roles (
    id_usuario INT NOT NULL,
    id_rol INT NOT NULL,
    PRIMARY KEY (id_usuario, id_rol),
    CONSTRAINT fk_ur_usuario FOREIGN KEY (id_usuario) 
        REFERENCES usuarios(id_usuario) ON DELETE CASCADE,
    CONSTRAINT fk_ur_rol FOREIGN KEY (id_rol) 
        REFERENCES roles_sistema(id_rol) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS conexiones_seguidores (
    id_seguidor INT NOT NULL,
    id_seguido INT NOT NULL,
    fecha_seguimiento TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id_seguidor, id_seguido),
    CONSTRAINT fk_cs_seguidor FOREIGN KEY (id_seguidor) 
        REFERENCES usuarios(id_usuario) ON DELETE CASCADE,
    CONSTRAINT fk_cs_seguido FOREIGN KEY (id_seguido) 
        REFERENCES usuarios(id_usuario) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS publicaciones (
    id_publicacion SERIAL PRIMARY KEY,
    id_usuario INT NOT NULL,
    contenido TEXT NOT NULL,
    fecha_publicacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_pub_usuario FOREIGN KEY (id_usuario) 
        REFERENCES usuarios(id_usuario) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS multimedia_publicacion (
    id_multimedia SERIAL PRIMARY KEY,
    id_publicacion INT NOT NULL,
    url_archivo VARCHAR(255) NOT NULL,
    tipo_archivo VARCHAR(50),
    CONSTRAINT fk_multi_pub FOREIGN KEY (id_publicacion) 
        REFERENCES publicaciones(id_publicacion) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS comentarios (
    id_comentario SERIAL PRIMARY KEY,
    id_publicacion INT NOT NULL,
    id_usuario INT NOT NULL,
    comentario TEXT NOT NULL,
    fecha_comentario TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_com_pub FOREIGN KEY (id_publicacion) 
        REFERENCES publicaciones(id_publicacion) ON DELETE CASCADE,
    CONSTRAINT fk_com_usuario FOREIGN KEY (id_usuario) 
        REFERENCES usuarios(id_usuario) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS reacciones (
    id_reaccion SERIAL PRIMARY KEY,
    id_publicacion INT NOT NULL,
    id_usuario INT NOT NULL,
    tipo_reaccion VARCHAR(30) NOT NULL,
    CONSTRAINT fk_reac_pub FOREIGN KEY (id_publicacion) 
        REFERENCES publicaciones(id_publicacion) ON DELETE CASCADE,
    CONSTRAINT fk_reac_usuario FOREIGN KEY (id_usuario) 
        REFERENCES usuarios(id_usuario) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS grupos (
    id_grupo SERIAL PRIMARY KEY,
    id_usuario_creador INT NOT NULL,
    nombre_grupo VARCHAR(100) NOT NULL,
    descripcion TEXT,
    CONSTRAINT fk_grupo_usuario FOREIGN KEY (id_usuario_creador) 
        REFERENCES usuarios(id_usuario) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS miembros_grupo (
    id_grupo INT NOT NULL,
    id_usuario INT NOT NULL,
    PRIMARY KEY (id_grupo, id_usuario),
    CONSTRAINT fk_mg_grupo FOREIGN KEY (id_grupo) 
        REFERENCES grupos(id_grupo) ON DELETE CASCADE,
    CONSTRAINT fk_mg_usuario FOREIGN KEY (id_usuario) 
        REFERENCES usuarios(id_usuario) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS eventos (
    id_evento SERIAL PRIMARY KEY,
    id_usuario_creador INT NOT NULL,
    nombre_evento VARCHAR(100) NOT NULL,
    fecha_evento TIMESTAMP NOT NULL,
    CONSTRAINT fk_evento_usuario FOREIGN KEY (id_usuario_creador) 
        REFERENCES usuarios(id_usuario) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS asistentes_evento (
    id_evento INT NOT NULL,
    id_usuario INT NOT NULL,
    PRIMARY KEY (id_evento, id_usuario),
    CONSTRAINT fk_ae_evento FOREIGN KEY (id_evento) 
        REFERENCES eventos(id_evento) ON DELETE CASCADE,
    CONSTRAINT fk_ae_usuario FOREIGN KEY (id_usuario) 
        REFERENCES usuarios(id_usuario) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS logs_telemetria_iot (
    id_log SERIAL PRIMARY KEY,
    id_usuario INT NOT NULL,
    datos JSONB, -- Tipo semiestructurado NoSQL para métricas e IoT
    fecha_registro TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_log_usuario FOREIGN KEY (id_usuario) 
        REFERENCES usuarios(id_usuario) ON DELETE CASCADE
);
