SELECT 
    u.id_usuario, 
    u.nombre, 
    u.email
FROM 
    usuarios u
WHERE EXISTS (
    SELECT 1 
    FROM logs_telemetria_iot l
    WHERE l.id_usuario = u.id_usuario
);
