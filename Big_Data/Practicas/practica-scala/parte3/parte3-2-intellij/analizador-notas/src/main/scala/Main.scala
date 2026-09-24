object Main extends App {
  val estudiantes = List("Ana", "Luis", "Marta", "Pedro", "Sofia")
  val notas = Array(8, 4, 10, 6, 3)
  val notasSegundaEvaluacion = Array(9, 5, 8, 7, 6)
  def aprobado(nota: Int): Boolean = {
    nota >= 5
  }
  def estadoNota(nota: Int): String = {
    if (aprobado(nota)) "APROBADO"
    else "SUSPENSO"
  }
  def maxNota(a: Int, b: Int): Int = {
    if (a > b) a
    else b
  }
  def clasificacion(nota: Int): String = {
    if (nota >= 9) "EXCELENTE"
    else if (nota >= 7) "NOTABLE"
    else if (nota >= 5) "APROBADO"
    else "SUSPENSO"
  }
  def listarEstudiantes(nombres: List[String], n: Array[Int]): Unit = {
    var i = 0
    while (i < n.length) {
      println(nombres(i) + " -> " + n(i) + " -> " + estadoNota(n(i)))
      i += 1
    }
  }
  def listarClasificacion(nombres: List[String], n: Array[Int]): Unit = {
    var i = 0
    while (i < n.length) {
      println(nombres(i) + " -> " + n(i) + " -> " + clasificacion(n(i)))
      i += 1
    }
  }
  def contarAprobados(n: Array[Int]): Int = {
    var i = 0
    var aprobados = 0
    while (i < n.length) {
      if (aprobado(n(i))) aprobados += 1
      i += 1
    }
    aprobados
  }
  def contarSuspensos(n: Array[Int]): Int = {
    n.length - contarAprobados(n)
  }
  def mejorNota(n: Array[Int]): Int = {
    var mejor = 0
    var i = 0
    while (i < n.length) {
      mejor = maxNota(mejor, n(i))
      i += 1
    }
    mejor
  }
  def mostrarResumen(n: Array[Int]): Unit = {
    println()
    println("--- Resumen del grupo ---")
    println()
    println("Estudiantes: " + n.length)
    println("Aprobados: " + contarAprobados(n))
    println("Suspensos: " + contarSuspensos(n))
    println("Mejor nota: " + mejorNota(n))
    println()
  }
  println("===== PRIMERA EVALUACIÓN =====")
  listarEstudiantes(estudiantes, notas)
  mostrarResumen(notas)
  println("--- Clasificación ---")
  listarClasificacion(estudiantes, notas)
  println()
  println("===== SEGUNDA EVALUACIÓN =====")
  listarEstudiantes(estudiantes, notasSegundaEvaluacion)
  mostrarResumen(notasSegundaEvaluacion)
  println("--- Clasificación ---")
  listarClasificacion(estudiantes, notasSegundaEvaluacion)
  println()
  val aprobados1 = contarAprobados(notas)
  val aprobados2 = contarAprobados(notasSegundaEvaluacion)
  println("===== COMPARACIÓN DE EVALUACIONES =====")
  println("Mejor nota primera evaluación: " + mejorNota(notas))
  println("Mejor nota segunda evaluación: " + mejorNota(notasSegundaEvaluacion))
  println("Aprobados primera evaluación: " + aprobados1)
  println("Aprobados segunda evaluación: " + aprobados2)
  if (aprobados2 > aprobados1) println("El grupo ha mejorado.")
  else if (aprobados2 < aprobados1) println("El grupo ha empeorado.")
  else println("El grupo se ha mantenido igual.")
  println()
  val nuevosEstudiantes = "Carlos" :: estudiantes
  println("===== USO DE LISTAS =====")
  println("Lista original: " + estudiantes)
  println("Lista nueva: " + nuevosEstudiantes)
}