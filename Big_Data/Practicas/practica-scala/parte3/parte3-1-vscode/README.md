# Torneo Twenty-One

## Entorno

- Visual Studio Code
- Metals
- Scala 2.12.21
- JDK 17
- sbt

## Descripción 

Pequeño programa de consola escrito en Scala que simula dos rondas de un
torneo de Blackjack. Muestra el estado de cada mano, cuenta las manos
válidas y las que hacen but, y compara la mejor puntuación de cada ronda.

## Estructura

![build.properties](./project/build.properties)
![build.sbt](./build.sbt)
![Main](./src/main/scala)

## Funciones Utilizadas

- estadoMano
- mejorMano
- mostrarRondaWhile
- mostrarRondaForeach
- contarValidas
- contarBust
- mostrarResumen

## Ejecución

```bash
sbt compile
sbt run
```
