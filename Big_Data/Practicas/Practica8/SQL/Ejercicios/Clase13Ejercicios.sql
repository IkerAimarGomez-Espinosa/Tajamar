USE SonoraDB
GO

---- Ejercicio 1

CREATE OR ALTER VIEW dbo.vw_anuncios AS
SELECT reproduccion_id, usuario_id, fecha_hora, dispositivo FROM dbo.reproducciones
WHERE tipo_contenido = N'Anuncio';
GO

SELECT dispositivo,
    COUNT(*) AS anuncios,
    COUNT(DISTINCT usuario_id) AS usuarios
FROM dbo.vw_anuncios GROUP BY dispositivo
ORDER BY anuncios DESC, dispositivo;
GO

---- Ejercicio 2

CREATE OR ALTER VIEW dbo.vw_usuarios_pago AS
SELECT usuario_id, nombre_usuario, pais, plan_suscripcion, fecha_alta
FROM dbo.usuarios WHERE plan_suscripcion IN (N'Premium', N'Familiar');
GO

SELECT usuario_id, nombre_usuario, pais, plan_suscripcion, fecha_alta
FROM dbo.vw_usuarios_pago ORDER BY fecha_alta;
GO

---- Ejercicio 3

CREATE OR ALTER VIEW dbo.vw_saltos AS
SELECT reproduccion_id, usuario_id, cancion_id, fecha_hora, segundos_escuchados
FROM dbo.reproducciones WHERE tipo_contenido = N'Canción'
AND segundos_escuchados < 30;
GO

SELECT u.nombre_usuario, c.titulo, s.segundos_escuchados, s.fecha_hora
FROM dbo.vw_saltos AS s
JOIN dbo.usuarios  AS u ON u.usuario_id = s.usuario_id
JOIN dbo.canciones AS c ON c.cancion_id = s.cancion_id
ORDER BY s.fecha_hora;
GO

---- Ejercicio 4

CREATE OR ALTER VIEW dbo.vw_catalogo_detalle AS
SELECT c.cancion_id, c.titulo, a.nombre AS artista, a.pais AS pais_artista, g.nombre AS genero, c.duracion_seg,
    CAST(c.duracion_seg / 60.0 AS decimal(4,1)) AS duracion_min
FROM dbo.canciones AS c
JOIN dbo.artistas  AS a ON a.artista_id = c.artista_id
JOIN dbo.generos   AS g ON g.genero_id  = c.genero_id;
GO

SELECT titulo, artista, genero, duracion_seg, duracion_min
FROM dbo.vw_catalogo_detalle WHERE pais_artista = 'ES' ORDER BY titulo;
GO

---- Ejercicio 5

CREATE OR ALTER VIEW dbo.vw_canciones_por_dispositivo AS
SELECT dispositivo, COUNT(*) AS reproducciones
FROM dbo.reproducciones WHERE tipo_contenido = N'Canción'
GROUP BY dispositivo;
GO

SELECT dispositivo, reproducciones
FROM dbo.vw_canciones_por_dispositivo
ORDER BY reproducciones DESC;
GO

---- Ejercicio 6

CREATE OR ALTER VIEW dbo.vw_kpi_usuario AS
SELECT u.usuario_id,
    u.nombre_usuario,
    u.plan_suscripcion,
    u.pais,
    COUNT(v.reproduccion_id) AS reproducciones_validas,
    CAST(COALESCE(SUM(v.segundos_escuchados), 0) / 60.0 AS decimal(6,1)) AS minutos,
    MAX(v.fecha_hora) AS ultima_reproduccion_valida
FROM dbo.usuarios AS u
LEFT JOIN dbo.vw_reproducciones_validas AS v ON v.usuario_id = u.usuario_id
GROUP BY u.usuario_id, u.nombre_usuario, u.plan_suscripcion, u.pais;
GO

SELECT nombre_usuario, plan_suscripcion, reproducciones_validas, minutos, ultima_reproduccion_valida
FROM dbo.vw_kpi_usuario WHERE reproducciones_validas = 0;

SELECT nombre_usuario, plan_suscripcion, reproducciones_validas, minutos
FROM dbo.vw_kpi_usuario
WHERE plan_suscripcion IN (N'Premium', N'Familiar')
ORDER BY minutos DESC;
GO

---- Ejercicio 7

CREATE OR ALTER VIEW dbo.vw_organigrama AS
WITH org AS (SELECT empleado_id, nombre, puesto, 0 AS nivel, CAST(nombre AS nvarchar(400)) AS ruta
    FROM dbo.empleados
    WHERE jefe_id IS NULL
    UNION ALL
    SELECT e.empleado_id, e.nombre, e.puesto, o.nivel + 1, CAST(o.ruta + N' > ' + e.nombre AS nvarchar(400))
    FROM dbo.empleados AS e
    JOIN org AS o ON e.jefe_id = o.empleado_id
)
SELECT empleado_id, nombre, puesto, nivel, ruta FROM org;
GO

SELECT nombre, puesto, nivel FROM dbo.vw_organigrama
WHERE ruta LIKE N'%Raúl Benet > %' ORDER BY nombre;
SELECT nivel, COUNT(*) AS empleados
FROM dbo.vw_organigrama GROUP BY nivel ORDER BY nivel;
GO

---- Ejercicio 8

CREATE OR ALTER VIEW dbo.vw_canciones_2026 AS
SELECT cancion_id, titulo, artista_id, genero_id, duracion_seg, fecha_lanzamiento
FROM dbo.canciones WHERE fecha_lanzamiento >= '2026-01-01'
WITH CHECK OPTION;
GO

/* Predicción:
   a) (1 row affected)  Humo Violeta es de 2026 y sigue cumpliendo el WHERE.
   b) Msg 550           La fecha 2025-12-15 sacaría la fila de la vista.
   c) (0 rows affected) Neón es de 2025: no está en la vista, el WHERE no la ve.
   d) Msg 550           Insertar una canción de 2025 no cumple el WHERE.
   e) (1 row affected)  2026-10-02 sí cumple el WHERE. */
BEGIN TRAN;
GO
-- a)
UPDATE dbo.vw_canciones_2026 SET duracion_seg = 170 WHERE titulo = N'Humo Violeta';
GO
-- b)
UPDATE dbo.vw_canciones_2026 SET fecha_lanzamiento = '2025-12-15' WHERE titulo = N'Humo Violeta';
GO
-- c)
UPDATE dbo.vw_canciones_2026 SET duracion_seg = 210 WHERE titulo = N'Neón';
GO
-- d)
INSERT INTO dbo.vw_canciones_2026 (cancion_id, titulo, artista_id, genero_id, duracion_seg, fecha_lanzamiento)
VALUES (116, N'Eco Antiguo', 9, 2, 190, '2025-10-01');
GO
-- e)
INSERT INTO dbo.vw_canciones_2026 (cancion_id, titulo, artista_id, genero_id, duracion_seg, fecha_lanzamiento)
VALUES (117, N'Primer Vuelo', 9, 2, 195, '2026-10-02');
GO

ROLLBACK;
GO

---- Ejercicio 9

/* Predicción:
   a) (1 row affected)  duracion_seg es de canciones: una sola tabla base.
   b) Msg 4405          titulo (canciones) y artista (artistas) a la vez.
   c) Msg 4406          duracion_min es una expresión calculada.
   d) (1 row affected)  artista es de artistas: una sola tabla base. */
BEGIN TRAN;
GO
-- a)
UPDATE dbo.vw_catalogo_detalle SET duracion_seg = 205 WHERE titulo = N'Neón';
GO
-- b)
UPDATE dbo.vw_catalogo_detalle
SET titulo = N'Neón (Remix)', artista = N'Luna Roja & DJ Coral'
WHERE titulo = N'Neón';
GO
-- c)
UPDATE dbo.vw_catalogo_detalle SET duracion_min = 3.5 WHERE titulo = N'Neón';
GO
-- d)
UPDATE dbo.vw_catalogo_detalle SET artista = N'Luna Roja Oficial' WHERE titulo = N'Neón';
GO

SELECT titulo, artista, duracion_seg
FROM dbo.vw_catalogo_detalle
WHERE artista LIKE N'Luna Roja%'
ORDER BY titulo;
GO

ROLLBACK;
GO

/* ¿Por qué cambia también Verano en Bucle?
   La columna artista de la vista es artistas.nombre. El UPDATE se traduce en
   UPDATE artistas SET nombre = ... para la fila de artistas que cumple el
   filtro (Luna Roja, artista_id 1). Esa fila es UNA sola y la comparten sus
   dos canciones, así que al releer la vista las dos muestran el nombre nuevo.
   Filtrar por titulo selecciona la fila de la vista, no limita el cambio a
   esa canción: se modifica el dato del lado "uno" de la relación. */

---- Ejercicio 10

/* a) Tres problemas de la vista del compañero:
      1) SELECT * no se admite con SCHEMABINDING (Msg 1054).
      2) "artistas" sin esquema: hacen falta nombres de dos partes, dbo.artistas
         (Msg 4512).
      3) Con * habría columnas repetidas (nombre y genero_id existen en las dos
         tablas) y una vista exige nombres de columna únicos (Msg 4506):
         hay que listar columnas y poner alias. */
CREATE OR ALTER VIEW dbo.vw_artistas_ficha
WITH SCHEMABINDING
AS
SELECT a.artista_id,
       a.nombre AS artista,
       a.pais,
       g.nombre AS genero
FROM dbo.artistas AS a
JOIN dbo.generos  AS g ON g.genero_id = a.genero_id;
GO

SELECT artista, pais, genero
FROM dbo.vw_artistas_ficha
WHERE pais = 'ES'
ORDER BY artista;
GO

-- b) ERROR ESPERADO: Msg 5074 (una por vista enlazada) + Msg 4922
ALTER TABLE dbo.artistas ALTER COLUMN nombre nvarchar(150) NOT NULL;
GO
/* Salen dos Msg 5074 (vw_artistas_ficha y vw_catalogo_canciones) porque ambas
   están creadas WITH SCHEMABINDING y usan artistas.nombre (la segunda es la del
   Ejemplo 11, con a.nombre AS artista). Mientras una vista enlazada use la
   columna, SQL Server no deja alterarla. La tabla queda sin cambios. */

-- c) Vistas que dependen directamente de dbo.artistas
SELECT referencing_schema_name, referencing_entity_name
FROM sys.dm_sql_referencing_entities(N'dbo.artistas', N'OBJECT')
ORDER BY referencing_entity_name;
/* vw_artistas_ficha, vw_catalogo_canciones, vw_catalogo_detalle,
   vw_kpi_cancion, vw_reproducciones_detalle
   Impiden el cambio: SOLO vw_artistas_ficha y vw_catalogo_canciones (las que
   tienen SCHEMABINDING). Las otras tres dependen de la tabla, pero sin
   enlace al esquema SQL Server no las protege: el ALTER se permitiría y
   solo habría que ejecutar sp_refreshview sobre ellas para actualizar sus
   metadatos. */
GO

---- Ejercicio 11
/* a) El intento original falla en CREATE UNIQUE CLUSTERED INDEX (Msg 10125):
      una vista indexada no admite AVG (tampoco MIN, MAX, DISTINCT, TOP...) y,
      al tener GROUP BY, debe incluir COUNT_BIG(*). Se guardan COUNT_BIG(*) y
      SUM, y la media se calcula al consultar (segundos / reproducciones). */
DROP VIEW IF EXISTS dbo.vw_ix_consumo_dispositivo;
GO

CREATE VIEW dbo.vw_ix_consumo_dispositivo
WITH SCHEMABINDING
AS
SELECT dispositivo,
       COUNT_BIG(*)             AS reproducciones_validas,
       SUM(segundos_escuchados) AS segundos
FROM dbo.reproducciones
WHERE tipo_contenido = N'Canción'
  AND segundos_escuchados >= 30
GROUP BY dispositivo;
GO

CREATE UNIQUE CLUSTERED INDEX IX_vw_ix_consumo_dispositivo
    ON dbo.vw_ix_consumo_dispositivo (dispositivo);
GO

-- b)
SELECT dispositivo,
       reproducciones_validas,
       CAST(segundos / 60.0 AS decimal(6,1))                    AS minutos,
       CAST(segundos * 1.0 / reproducciones_validas AS decimal(6,1)) AS media_segundos
FROM dbo.vw_ix_consumo_dispositivo WITH (NOEXPAND)
ORDER BY reproducciones_validas DESC, dispositivo;
GO

-- c)
BEGIN TRAN;

INSERT INTO dbo.reproducciones
    (reproduccion_id, usuario_id, cancion_id, fecha_hora, segundos_escuchados, dispositivo, tipo_contenido)
VALUES (44, 6, 102, '2026-09-22 21:00', 201, N'Smart TV', N'Canción');

SELECT dispositivo, reproducciones_validas, segundos
FROM dbo.vw_ix_consumo_dispositivo WITH (NOEXPAND)
WHERE dispositivo = N'Smart TV';