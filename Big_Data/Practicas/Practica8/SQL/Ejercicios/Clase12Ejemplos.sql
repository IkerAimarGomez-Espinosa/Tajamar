USE SonoraDB
GO

---- Ejemplo 9

--SELECT TOP (3) c.titulo, COUNT(*) AS reproducciones_validas
--FROM (SELECT cancion_id FROM dbo.reproducciones
--    WHERE tipo_contenido = N'Canción' AND segundos_escuchados >= 30
--) AS v
--JOIN dbo.canciones AS c ON c.cancion_id = v.cancion_id
--GROUP BY c.titulo ORDER BY reproducciones_validas DESC, c.titulo;

---- Ejemplo 10

--SELECT genero, reproducciones, minutos
--FROM (SELECT genero,
--    COUNT(*) AS reproducciones,
--    CAST(SUM(segundos_escuchados) / 60.0 AS decimal(6,1)) AS minutos
--    FROM (SELECT l.segundos_escuchados, g.nombre AS genero
--        FROM (SELECT cancion_id, segundos_escuchados FROM dbo.reproducciones
--            WHERE tipo_contenido = N'Canción' AND segundos_escuchados >= 30
--        ) AS l
--        JOIN dbo.canciones AS c ON c.cancion_id = l.cancion_id
--        JOIN dbo.generos   AS g ON g.genero_id  = c.genero_id
--    ) AS enriquecidas GROUP BY genero
--) AS agregadas ORDER BY minutos DESC, genero;

-- Ejemplo 11

--SELECT g0.genero_id, g0.nombre,
--    CASE WHEN g0.genero_padre_id IS NULL THEN 0
--        WHEN g1.genero_padre_id IS NULL THEN 1
--        WHEN g2.genero_padre_id IS NULL THEN 2
--        ELSE 3 END AS nivel,
--    CONCAT(COALESCE(g3.nombre + N' > ', N''),
--        COALESCE(g2.nombre + N' > ', N''),
--        COALESCE(g1.nombre + N' > ', N''),
--        g0.nombre) AS ruta
--FROM dbo.generos AS g0
--LEFT JOIN dbo.generos AS g1 ON g1.genero_id = g0.genero_padre_id
--LEFT JOIN dbo.generos AS g2 ON g2.genero_id = g1.genero_padre_id
--LEFT JOIN dbo.generos AS g3 ON g3.genero_id = g2.genero_padre_id
--ORDER BY ruta;

-- Ejercicio 12

--SELECT gr.nombre AS genero_principal,
--    COUNT(r.reproduccion_id) AS reproducciones_validas
--FROM (SELECT g.genero_id,
--    CASE WHEN g.genero_padre_id  = raiz.genero_id THEN g.genero_id
--        WHEN p1.genero_padre_id = raiz.genero_id THEN p1.genero_id
--        WHEN p2.genero_padre_id = raiz.genero_id THEN p2.genero_id
--        WHEN p3.genero_padre_id = raiz.genero_id THEN p3.genero_id
--        END AS raiz_id
--    FROM dbo.generos AS g
--    CROSS JOIN (SELECT genero_id FROM dbo.generos WHERE genero_padre_id IS NULL) AS raiz
--    LEFT JOIN dbo.generos AS p1 ON p1.genero_id = g.genero_padre_id
--    LEFT JOIN dbo.generos AS p2 ON p2.genero_id = p1.genero_padre_id
--    LEFT JOIN dbo.generos AS p3 ON p3.genero_id = p2.genero_padre_id
--) AS a JOIN dbo.generos AS gr ON gr.genero_id = a.raiz_id
--LEFT JOIN dbo.canciones AS c ON c.genero_id = a.genero_id
--LEFT JOIN dbo.reproducciones AS r ON r.cancion_id = c.cancion_id
--AND r.tipo_contenido = N'Canción' AND r.segundos_escuchados >= 30
--GROUP BY gr.nombre ORDER BY reproducciones_validas DESC;

-- Ejemplo 13

--SELECT d.dia, COUNT(r.reproduccion_id) AS reproducciones
--FROM ( SELECT DATEADD(DAY, n, CAST('2026-09-14' AS date)) AS dia
--    FROM (VALUES (0),(1),(2),(3),(4),(5),(6),(7),(8)) AS t(n)
--) AS d
--LEFT JOIN dbo.reproducciones AS r
--ON CAST(r.fecha_hora AS date) = d.dia
--AND r.tipo_contenido = N'Canción'
--GROUP BY d.dia
--ORDER BY d.dia;