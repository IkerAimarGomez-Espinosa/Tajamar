object Main extends App {
  val jugadores = List("Alex", "Chen", "Marta", "Sindhu", "Luis")
  val puntuaciones = Array(18, 24, 21, 20, 26)
  val puntuacionesRonda2 = Array(22, 19, 20, 21, 17)
  def bust(puntuacion: Int): Boolean = {
    puntuacion > 21
  }
  def estadoMano(puntuacion: Int): String = {
    if (bust(puntuacion)) "BUST"
    else "VALIDA"
  }
  def mejorMano(handA: Int, handB: Int): Int = {
    if (handA > 21 && handB > 21) 0
    else if (handA > 21) handB
    else if (handB > 21) handA
    else if (handA > handB) handA
    else handB
  }
  def mostrarRondaWhile(nombres: List[String], puntuacion: Array[Int]): Unit = {
    var i = 0
    while (i < puntuacion.length) {
      println(nombres(i) + puntuacion(i) + estadoMano(puntuacion(i)))
      i += 1
    }
  }
  def mostrarRondaForeach(puntuacion: Array[Int]): Unit = {
    puntuacion.foreach(p => println(p + estadoMano(p)))
  }
  def contarValidas(puntuacion: Array[Int]): Int = {
    var i = 0
    var validas = 0
    while (i < puntuacion.length) {
      if (!bust(puntuacion(i))) validas += 1
      i += 1
    }
    validas
  }
  def contarBust(puntuacion: Array[Int]): Int = {
    puntuacion.length - contarValidas(puntuacion)
  }
  def mejorPuntuacionValida(puntuacion: Array[Int]): Int = {
    var mejor = 0
    var i = 0
    while (i < puntuacion.length) {
      mejor = mejorMano(mejor, puntuacion(i))
      i += 1
    }
    mejor
  }
  def mostrarResumen(puntuacion: Array[Int]): Unit = {
    println()
    println("===== Resumen de la ronda =====")
    println()
    println("Jugadores: " + puntuacion.length)
    println("Manos válidas: " + contarValidas(puntuacion))
    println("Bust: " + contarBust(puntuacion))
    println("Mejor puntuación válida: " + mejorPuntuacionValida(puntuacion))
    println()
  }
  println("===== RONDA 1 =====")
  mostrarRondaWhile(jugadores, puntuaciones)
  mostrarResumen(puntuaciones)
  println("===== RONDA 1 =====")
  mostrarRondaForeach(puntuaciones)
  println()
  println("===== RONDA 2 =====")
  mostrarRondaWhile(jugadores, puntuacionesRonda2)
  mostrarResumen(puntuacionesRonda2)
  println("===== RONDA 2 =====")
  mostrarRondaForeach(puntuacionesRonda2)
  println()
  val mejor1 = mejorPuntuacionValida(puntuaciones)
  val mejor2 = mejorPuntuacionValida(puntuacionesRonda2)
  println("===== COMPARACIÓN DE RONDAS =====")
  println("Mejor puntuación ronda 1: " + mejor1)
  println("Mejor puntuación ronda 2: " + mejor2)
  if (mejor1 > mejor2) println("La ronda 1 tuvo la mejor puntuación.")
  else if (mejor2 > mejor1) println("La ronda 2 tuvo la mejor puntuación.")
  else println("Ambas rondas tuvieron la misma mejor puntuación.")
}
