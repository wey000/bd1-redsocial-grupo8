SELECT 
    u.nombre_completo AS nombre_usuario,               
    p.contenido_texto AS contenido_publicacion,      
    c.texto_comentario AS texto_comentario,         
    c.fecha_comentario AS fecha_comentario    
FROM 
    usuarios u                                 
INNER JOIN 
    publicaciones p ON u.id_usuario = p.id_usuario_autor
INNER JOIN 
    comentarios c ON p.id_publicacion = c.id_publicacion
ORDER BY 
    c.fecha_comentario DESC;
