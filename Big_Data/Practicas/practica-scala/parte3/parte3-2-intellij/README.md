# Mini proyecto 3.2 — Analizador de Notas

## Entorno

- IntelliJ IDEA Community
- Plugin de Scala
- Scala 2.12.21
- JDK 17
- sbt

## Descripción

Aplicación en Scala que analiza las calificaciones de un grupo de estudiantes en dos evaluaciones.
Almacena los nombres y las notas, determina quién aprueba y quién suspende.

## Estructura

![build.properties](./project/build.properties)
![build.sbt](./build.sbt)
![Main](./src/main/scala/Main.scala)

## Funciones utilizadas

- aprobado
- estadoNota
- maxNota
- clasificacion
- listarEstudiantes
- listarClasificacion
- contarAprobados
- contarSuspensos
- mejorNota
- mostrarResumen

## Ejecución

```bash
sbt compile
sbt run
```
