---- Ejemplo 1 Paso 1

--SELECT AVG(duracion_seg) FROM dbo.canciones;

---- Ejemplo 1 Paso 2

--SELECT titulo, duracion_seg
--FROM dbo.canciones
--WHERE duracion_seg > (SELECT AVG(duracion_seg) FROM dbo.canciones)
--ORDER BY duracion_seg DESC;

---- Ejemplo 2

--SELECT titulo,
--       duracion_seg,
--       (SELECT AVG(duracion_seg) FROM dbo.canciones) AS media_catalogo,
--       duracion_seg - (SELECT AVG(duracion_seg) FROM dbo.canciones) AS diferencia
--FROM dbo.canciones
--WHERE artista_id = 1;

---- Ejemplo 3

--SELECT nombre_usuario, plan_suscripcion
--FROM dbo.usuarios
--WHERE usuario_id IN (
--    SELECT usuario_id
--    FROM dbo.reproducciones
--    WHERE cancion_id IN (
--        SELECT cancion_id
--        FROM dbo.canciones
--        WHERE artista_id = (SELECT artista_id FROM dbo.artistas WHERE nombre = N'Nébula')
--    )
--)
--ORDER BY nombre_usuario;

---- Ejemplo 4

--SELECT u.nombre_usuario, u.plan_suscripcion, t.num_reproducciones
--FROM (
--    SELECT usuario_id, COUNT(*) AS num_reproducciones
--    FROM dbo.reproducciones
--    WHERE tipo_contenido = N'Canción'
--    GROUP BY usuario_id
--) AS t
--JOIN dbo.usuarios AS u ON u.usuario_id = t.usuario_id
--WHERE t.num_reproducciones >= 5
--ORDER BY t.num_reproducciones DESC, u.nombre_usuario;

---- Ejemplo 5

--SELECT u.nombre_usuario, r.fecha_hora, c.titulo
--FROM dbo.reproducciones AS r
--JOIN dbo.usuarios AS u ON u.usuario_id = r.usuario_id
--LEFT JOIN dbo.canciones AS c ON c.cancion_id = r.cancion_id
--WHERE r.fecha_hora = (
--    SELECT MAX(r2.fecha_hora)
--    FROM dbo.reproducciones AS r2
--    WHERE r2.usuario_id = r.usuario_id
--)
--ORDER BY r.fecha_hora;

---- Ejemplo 6

--SELECT a.nombre, a.pais
--FROM dbo.artistas AS a
--WHERE EXISTS (
--    SELECT 1
--    FROM dbo.canciones AS c
--    WHERE c.artista_id = a.artista_id
--      AND c.fecha_lanzamiento >= '2026-01-01'
--)
--ORDER BY a.nombre;

---- Ejemplo 7 Paso 1

--SELECT cancion_id, titulo
--FROM dbo.canciones
--WHERE cancion_id NOT IN (SELECT cancion_id FROM dbo.reproducciones);

---- Ejemplo 7 Paso 3

--SELECT c.cancion_id, c.titulo
--FROM dbo.canciones AS c
--WHERE NOT EXISTS (
--    SELECT 1
--    FROM dbo.reproducciones AS r
--    WHERE r.cancion_id = c.cancion_id
--);

---- Ejemplo 8 Paso 1

--SELECT s.reproduccion_id, s.usuario_id, s.cancion_id, s.fecha_hora
--FROM dbo.stg_reproducciones AS s
--WHERE NOT EXISTS (
--    SELECT 1
--    FROM dbo.reproducciones AS r
--    WHERE r.reproduccion_id = s.reproduccion_id
--)
--ORDER BY s.reproduccion_id;

---- Ejemplo 8 Paso 2

--INSERT INTO dbo.reproducciones
--    (reproduccion_id, usuario_id, cancion_id, fecha_hora, segundos_escuchados, dispositivo, tipo_contenido)
--SELECT s.reproduccion_id, s.usuario_id, s.cancion_id, s.fecha_hora,
--       s.segundos_escuchados, s.dispositivo, s.tipo_contenido
--FROM dbo.stg_reproducciones AS s
--WHERE NOT EXISTS (
--    SELECT 1
--    FROM dbo.reproducciones AS r
--    WHERE r.reproduccion_id = s.reproduccion_id
--);