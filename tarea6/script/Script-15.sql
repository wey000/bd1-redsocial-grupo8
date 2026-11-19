-- 1. Creación de la tabla de logs de telemetría IoT con soporte JSON
DROP TABLE IF EXISTS logs_telemetria_iot;
CREATE TABLE IF NOT EXISTS logs_telemetria_iot (
    id_log INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT NOT NULL,
    dispositivo_sensor VARCHAR(100) NOT NULL,
    fecha_registro TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    datos_payload JSON NOT NULL
);

-- 2. Inserción de registros de prueba semiestructurados (NoSQL / IoT)
INSERT INTO logs_telemetria_iot (id_usuario, dispositivo_sensor, datos_payload) VALUES
(1, 'Sensor_Acceso_Lab_101', '{"evento": "INGRESO_LABORATORIO", "ubicacion": "Bloque P - Aula 101", "temperatura": 22.5, "duracion_minutos": 120}'),
(1, 'AP_WiFi_Biblioteca_Central', '{"evento": "CONEXION_WIFI", "ancho_banda_mb": 450, "dispositivo": "Laptop Dell", "protocolo": "802.11ax"}'),
(1, 'Torniquete_Entrada_Principal', '{"evento": "CONTROL_ACCESO", "tipo_credencial": "Carnet_Digital", "autorizado": true}');

-- Consulta para extraer insights y atributos del campo JSON semiestructurado
SELECT 
    id_log,
    id_usuario,
    dispositivo_sensor,
    JSON_UNQUOTE(JSON_EXTRACT(datos_payload, '$.evento')) AS tipo_evento,
    JSON_UNQUOTE(JSON_EXTRACT(datos_payload, '$.ubicacion')) AS ubicacion_sensor,
    fecha_registro
FROM 
    logs_telemetria_iot
WHERE 
    JSON_EXTRACT(datos_payload, '$.evento') IS NOT NULL;