-- 1. Insertar usuarios 
INSERT INTO usuarios (id_usuario, nombre_completo, correo_institucional, carrera_programa, estado_cuenta) VALUES 
(1, 'Ana Gómez', 'ana.gomez@pascualbravo.edu.co', 'Ingeniería de Software', 'Activo'),
(2, 'Carlos Pérez', 'carlos.perez@pascualbravo.edu.co', 'Ingeniería de Sistemas', 'Activo'),
(3, 'María Rodríguez', 'maria.rodriguez@pascualbravo.edu.co', 'Tecnología en Desarrollo de Software', 'Activo'),
(4, 'Juan Taborda', 'juan.taborda@pascualbravo.edu.co', 'Ingeniería Electrónica', 'Activo')
ON DUPLICATE KEY UPDATE nombre_completo = VALUES(nombre_completo);

-- 2. Insertar perfiles de usuario
INSERT INTO perfiles_usuario (id_perfil, id_usuario, biografia, semestre_actual, url_foto_perfil, intereses_academicos) VALUES 
(1, 1, 'Estudiante de Software apasionada por las bases de datos.', 5, 'https://fotos.com/ana.png', 'Bases de Datos, Desarrollo Web'),
(2, 2, 'Amante de la programación competitiva.', 6, 'https://fotos.com/carlos.png', 'Algoritmos, Java, Python'),
(3, 3, 'Representante estudiantil de la facultad.', 4, 'https://fotos.com/maria.png', 'Gestión de Proyectos, Liderazgo'),
(4, 4, 'Interesado en internet de las cosas e infraestructuras.', 7, 'https://fotos.com/juan.png', 'IoT, Redes, Sistemas Operativos')
ON DUPLICATE KEY UPDATE biografia = VALUES(biografia);

-- 3. Insertar publicaciones
INSERT INTO publicaciones (id_publicacion, id_usuario_autor, categoria_post, contenido_texto) VALUES 
(1, 1, 'Académico', '¿Alguien tiene apuntes para el parcial de cálculo diferencial? ¡Ayuda por favor!'),
(2, 2, 'Programación', 'Nuevo récord personal resolviendo ejercicios en LeetCode. ¡La práctica hace al maestro!'),
(3, 1, 'Grupo de Estudio', 'Organizando grupo de estudio para bases de datos avanzadas este jueves.'),
(4, 4, 'IoT Campus', 'Prueba de telemetría exitosa en el laboratorio de redes inteligente del bloque C.')
ON DUPLICATE KEY UPDATE contenido_texto = VALUES(contenido_texto);

-- 4. Insertar comentarios
INSERT INTO comentarios (id_comentario, id_publicacion, id_usuario, texto_comentario) VALUES 
(1, 1, 2, 'Hola Ana, yo te puedo pasar los apuntes de la clase pasada.'),
(2, 1, 3, 'También los tengo digitalizados, te los comparto por correo.'),
(3, 3, 2, 'Me apunto para el grupo de estudio de bases de datos este jueves.')
ON DUPLICATE KEY UPDATE texto_comentario = VALUES(texto_comentario);

-- 5. Insertar registros de telemetría IoT
INSERT INTO logs_telemetria_iot (id_log, id_usuario, datos) VALUES 
(1, 4, '{"dispositivo": "Sensor_NFC_Torniquete", "bloque": "A", "temperatura": 22.5, "estado": "acceso_permitido"}'),
(2, 1, '{"dispositivo": "Sensor_Lab_Redes", "bloque": "C", "temperatura": 24.1, "estado": "activo"}')
ON DUPLICATE KEY UPDATE datos = VALUES(datos);