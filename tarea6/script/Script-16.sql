SELECT 
    u.nombre AS nombre_usuario,               
    p.contenido AS contenido_publicacion,      
    c.comentario AS texto_comentario,         
    c.fecha_comentario AS fecha_comentario    
FROM 
    usuarios u                                 
INNER JOIN 
    publicaciones p ON u.id_usuario = p.id_usuario
INNER JOIN 
    comentarios c ON p.id_publicacion = c.id_publicacion
ORDER BY 
    c.fecha_comentario DESC;
