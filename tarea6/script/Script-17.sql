SELECT 
    p.id_publicacion, 
    COUNT(c.id_comentario) AS total_comentarios
FROM 
    publicaciones p
INNER JOIN 
    comentarios c ON p.id_publicacion = c.id_publicacion
WHERE 
    p.fecha_publicacion >= '2026-01-01 00:00:00'
GROUP BY 
    p.id_publicacion
HAVING 
    COUNT(c.id_comentario) > 0
ORDER BY 
    total_comentarios DESC;
