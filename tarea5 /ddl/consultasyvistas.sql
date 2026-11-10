SELECT 
    u.nombre_completo AS autor_publicacion,       
    p.contenido_texto AS cuerpo_publicacion,      
    c.texto_comentario AS comentario_recibido,        
    c.fecha_comentario AS fecha_interaccion    
FROM 
    usuarios u                                 
INNER JOIN 
    publicaciones p ON u.id_usuario = p.id_usuario_autor
INNER JOIN 
    comentarios c ON p.id_publicacion = c.id_publicacion
ORDER BY 
    c.fecha_comentario DESC;

-- Consulta 2

SELECT 
    u.id_usuario, 
    u.nombre_completo,
    u.correo_institucional
FROM 
    usuarios u
WHERE 
    u.id_usuario NOT IN (
        SELECT p.id_usuario_autor 
        FROM publicaciones p
    );
-- Consulta 3 
SELECT 
    p.id_publicacion AS id_post, 
    p.categoria_post AS categoria,
    COUNT(c.id_comentario) AS total_comentarios
FROM 
    publicaciones p
INNER JOIN 
    comentarios c ON p.id_publicacion = c.id_publicacion
WHERE 
    p.fecha_publicacion >= '2026-01-01 00:00:00'
GROUP BY 
    p.id_publicacion, 
    p.categoria_post
HAVING 
    COUNT(c.id_comentario) > 0
ORDER BY 
    total_comentarios DESC;

-- Consulta 4
SELECT 
    u.id_usuario AS id_estudiante, 
    u.nombre_completo AS usuario_activo, 
    u.carrera_programa AS programa_academico
FROM 
    usuarios u
WHERE EXISTS (
    SELECT 1 
    FROM logs_telemetria_iot l
    WHERE l.id_usuario = u.id_usuario
);

-- Consulta 5
SELECT 
    u.carrera_programa AS programa_academico,
    pf.semestre_actual AS nivel_semestre,
    COUNT(u.id_usuario) AS cantidad_estudiantes
FROM 
    usuarios u
INNER JOIN 
    perfiles_usuario pf ON u.id_usuario = pf.id_usuario
GROUP BY 
    u.carrera_programa, 
    pf.semestre_actual
ORDER BY 
    cantidad_estudiantes DESC;

-- Vista 1
CREATE VIEW vw_perfiles_estudiantes AS
SELECT 
    u.id_usuario,
    u.nombre_completo AS nombre_estudiante,
    u.correo_institucional,
    u.carrera_programa,
    p.semestre_actual,
    p.intereses_academicos
FROM 
    usuarios u
INNER JOIN 
    perfiles_usuario p ON u.id_usuario = p.id_usuario;
SELECT * FROM vw_perfiles_estudiantes WHERE semestre_actual >= 4;

-- Vista 2
CREATE VIEW vw_resumen_publicaciones AS
SELECT 
    u.id_usuario,
    u.nombre_completo AS autor,
    p.categoria_post,
    COUNT(p.id_publicacion) AS total_publicaciones
FROM 
    usuarios u
INNER JOIN 
    publicaciones p ON u.id_usuario = p.id_usuario_autor
GROUP BY 
    u.id_usuario, 
    u.nombre_completo, 
    p.categoria_post;
SELECT * FROM vw_resumen_publicaciones ORDER BY total_publicaciones DESC;

-- Vista 3
CREATE VIEW vw_telemetria_usuarios AS
SELECT 
    u.id_usuario,
    u.nombre_completo AS estudiante,
    u.carrera_programa,
    l.datos AS registro_telemetria_json,
    l.fecha_registro
FROM 
    usuarios u
INNER JOIN 
    logs_telemetria_iot l ON u.id_usuario = l.id_usuario;
SELECT * FROM vw_telemetria_usuarios;