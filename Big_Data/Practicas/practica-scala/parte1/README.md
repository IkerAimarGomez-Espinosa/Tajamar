# Instalación y configuración de entornos de desarrollo con Scala

## Índice

- [Entorno 1](#entorno-1)
- [Entorno 2](#entorno-2)
- [Entorno 3](#entorno-3)

## Entorno 1

### Instalación de JupyterLab

Para instalar Jupyter podermos encontrar información en la web: [https://jupyter.org/install](https://jupyter.org/install)

Como esta indica ejecutamos el comando `pip install jupyterlab` en nuestro cmd, que comprobará si tenemos todo lo requerido para jupiter y los instalará si no los tenemos.

<p align="center">
  <img src="images/Instalacion_1_JupyterLab.png" width="700" alt="Instalación de JupyterLab - paso 1"><br>
  <img src="images/Instalacion_2_JupyterLab.png" width="700" alt="Instalación de JupyterLab - paso 2"><br>
  <img src="images/Instalacion_3_JupyterLab.png" width="700" alt="Instalación de JupyterLab - paso 3">
</p>

Una vez instalado jupyter, hay que usar el comando `jupyter lab` en nuestro cmd

<p align="center">
  <img src="images/Ejecucion_Comando_Jupyter_lab.png" width="700" alt="Ejecución del comando jupyter lab">
</p>

, el cual abrirá [http://localhost:8888/lab](http://localhost:8888/lab) en nuestro navegador, desde donde podremos trabajar con jupyter

<p align="center">
  <img src="images/jupyter_en_localhost8888lab.png" width="700" alt="Jupyter en localhost:8888/lab">
</p>

### Instalación de almond

Para instalar almond, entraremos en [https://almond.sh/](https://almond.sh/) y haremos click en la opción de install, eso nos llevará a [https://almond.sh/docs/quick-start-install](https://almond.sh/docs/quick-start-install).

Te indica que debes tener instalado mínimo Java `1.8.0_121`, yo ya lo tengo instalado pero en caso de no tenerlo, te proveé del enlace para descargarlo.

Antes de instalar almond debes de instalar coursier, en la página web indica que hay que usar los comandos:

```
bitsadmin /transfer downloadCoursierCli https://git.io/coursier-cli "%cd%\coursier"
bitsadmin /transfer downloadCoursierBat https://git.io/coursier-bat "%cd%\coursier.bat"
```

<p align="center">
  <img src="images/Version_Java_Correcta_Y_Comandos_Almond_Incorrectos.png" width="700" alt="Versión de Java correcta y comandos de almond incorrectos">
</p>

A mi no me han funcionado, y con ayuda de la IA, se que es por que no son comandos actualizados, en su lugar yo usaré:

```
curl -fLo cs-x86_64-pc-win32.zip https://github.com/coursier/launchers/raw/master/cs-x86_64-pc-win32.zip
```

Extraigo el zip en la carpeta donde lo he descargado.

Aunque no sea obligatorio por consejo de la IA, voy a renombrar lo extraido (`cs-x86_64-pc-win32.exe`) a `cs.exe` para mayor comodidad a la hora de ejecutar comandos con:

```
move cs-x86_64-pc-win32.exe cs.exe
```

<p align="center">
  <img src="images/Coursier_Instalado_Y_Editado.png" width="700" alt="Coursier instalado y editado">
</p>

Ahora que ya tengo correctamente instalado coursier, puedo instalar almond con

```
.\cs launch --use-bootstrap almond -M almond.ScalaKernel --scala 2.12.21 -- --install
```

<p align="center">
  <img src="images/Instalacion_Almond_Correcto.png" width="700" alt="Instalación de almond correcta"><br>
  <img src="images/Instalacion_Almond_Correcto_Final.png" width="700" alt="Instalación de almond correcta - final">
</p>

> Es importante que despues de "almond.ScalaKernel", separado con un espacio se escriba si se quiere una versión especifica de scala como es nuestro caso, si no se instalará la ultima versión (`3.8.1`)

### Comprobación y ejercicios

Una vez instalado almond, podemos comprobar que scala este descargado correctamente para ello volvemos a abrir jupyter lab.

En Jupyter lab, abrimos un cuaderno Scala.

<p align="center">
  <img src="images/New_Notebook.png" width="500" alt="Nuevo cuaderno"><br>
  <img src="images/Elegir_Kernel_Scala.png" width="700" alt="Elegir kernel de Scala">
</p>

Y comprobamos la versión, yo en mi caso lo he hecho mediante el comando:

```scala
println("Scala " + scala.util.Properties.versionNumberString)
```

Terminamos realizando los 3 ejercicios simples indicados en la tarea.

<p align="center">
  <img src="images/Scala_y_Tarea_5.png" width="700" alt="Scala y Tarea 5">
</p>

---

## Entorno 2

### Instalación de Java 17

Para instalar java 17 yo lo haré llendo a [https://adoptium.net/es/temurin/releases?version=17](https://adoptium.net/es/temurin/releases?version=17) desde el que instalaré el `OpenJDK17U-jdk_x64_windows_hotspot_17.0.20.1_1.msi`

Ejecutamos el instalador y como lo vamos a usar para varias tareas, yo lo voy a poner como JDK predeterminado.

<p align="center">
  <img src="images/Instalacion_JDK17_1.png" width="450" alt="Instalación de JDK 17 - paso 1"><br>
  <img src="images/Instalacion_JDK17_2.png" width="450" alt="Instalación de JDK 17 - paso 2"><br>
  <img src="images/Instalacion_JDK17_3.png" width="450" alt="Instalación de JDK 17 - paso 3">
</p>

Comprobamos desde la terminal que el Java 17 se haya instalado bien con `where java`, `java -version` y `javac -version`.

<p align="center">
  <img src="images/Comprobar_Java.png" width="600" alt="Comprobar Java">
</p>

### Configuración de Visual Studio Code

Yo el Visual Studio Code ya lo tenía instalado de antes, unicamente tengo que actualizarlo a la última versión la `1.138`

<p align="center">
  <img src="images/VisualStudio_Iniciado.png" width="700" alt="Visual Studio Code iniciado"><br>
  <img src="images/Version_VisualStudio.png" width="700" alt="Versión de Visual Studio Code">
</p>

Vamos al apartado de extensiones a la derecha de la pantalla y buscamo Scala (Metals) para instalarla.

<p align="center">
  <img src="images/Instalacion_Scala_Metals.png" width="700" alt="Instalación de Scala Metals">
</p>

Para instalar sbt hay que entrar a la terminal y escribir `winget install sbt.sbt`, y una vez ha sido instalado podemos comprobar que se ha instalado correctamente con `sbt --version`.

<p align="center">
  <img src="images/Instalacion_sbt.png" width="700" alt="Instalación de sbt"><br>
  <img src="images/sbt_version.png" width="600" alt="Versión de sbt">
</p>

### Creación del proyecto

Ahora, tenemos que crear una carpeta que abriremos desde el visual studio code para realizar nuestro proyecto y tendremos que crear las distinas carpetas y archivos para llegar a la siguiente estructura.

<p align="center">
  <img src="images/Estructura_Proyecto_Scala_sbt.png" width="280" alt="Estructura del proyecto Scala sbt">
</p>

Dentro del `built.sbt` especificamos que usaremos la versión `2.12.21` y que el nombre será `scala-vscode`.

<p align="center">
  <img src="images/build_sbt.png" width="450" alt="build.sbt">
</p>

Dentro de `Main.scala` pegamos el contenido del mini programa de ejemplo

<p align="center">
  <img src="images/Main_scala.png" width="600" alt="Main.scala">
</p>

Mientras creabas la estructura del proyecto, metals avisaba de si querías importa el proyecto, ahora es el momento de indicarle que quieres hacerlo aceptando la notificación en la esquina inferior derecha.

<p align="center">
  <img src="images/import_metals_notification.png" width="600" alt="Notificación de importación de Metals">
</p>

Mientras Metals se importa, se van a ir añadiendo muchas carpetas y archivos en distintos niveles del proyecto, las primeras capas se verán algo así

<p align="center">
  <img src="images/Estructura_Carpetas_Metals_Importado.png" width="380" alt="Estructura de carpetas con Metals importado">
</p>

### Compilación y ejecución

Una vez compliado completamente vamos a abrir una terminal y nos vamos a mover a la localización del proyecto, una vez estemos dentro de la carpeta base, vamos a compilarlo con `sbt compile` y una vez se compile correctamente probaremos a ejecutarlo desde la misma localizacion con `sbt run`

<p align="center">
  <img src="images/sbt_compile_y_sbt_run.png" width="600" alt="sbt compile y sbt run">
</p>

---

## Entorno 3

Para iniciar este ejercicio, la practica pide instalar el Intellij IDEA, pero yo ya lo tenía instalado de antes, por lo que no puedo mostrar la instalación.

### Instalación del plugin de Scala

Para instalar el plugin de Scala, entramos en las pestaña de nuevo proyecto y damos en manejar más los plugins de los generadores, donde está Scala. Desde ahí entramos e instalamos el plugin.

<p align="center">
  <img src="images/Encontrar_Instalador_plugin_Scala.png" width="600" alt="Encontrar instalador plugin Scala"><br>
  <img src="images/Plugin_Scala_intellij.png" width="600" alt="Plugin Scala IntelliJ">
</p>

### Creación del proyecto

Volvemos al apartado de crear proyecto, seleccionamos Scala como Generator y cambiamos el JDK en el desplegable en el centro del menu.

<p align="center">
  <img src="images/Intellij_usa_JDK17.png" width="600" alt="IntelliJ usa JDK 17">
</p>

Le cambiamos el nombre del proyecto a `scala-intellij` y cambiamos la versión de Scala a la `2.12.21` y creamos el proyecto.

<p align="center">
  <img src="images/scala_intellij_nombre_versionScala.png" width="600" alt="Nombre del proyecto y versión de Scala">
</p>

Una vez creado el proyecto podemos ver que el build contiene todo lo que requiere la tarea, creamos el archivo en la ruta indicada.

<p align="center">
  <img src="images/contenido_buildsbt_intellij.png" width="450" alt="Contenido de build.sbt en IntelliJ">
</p>

Una vez en el archivo, nos pedirán que volvamos a configurar el SDK para Scala, elegimos el `2.12.21`

<p align="center">
  <img src="images/Main_Scala_Intellij_SDK_Correcto.png" width="700" alt="Main Scala IntelliJ SDK correcto">
</p>

### Ejecución

Copiamos el contenido del ejercicio y ejecutamos desde el Intellij, una vez vemos que no ha habido errores, abrimos el proyecto desde un cmd, y al igual que en el ejercicio del entorno anterior compilamos y ejecutamos con sbt.

<p align="center">
  <img src="images/Codigo_Intellij_Scala_Ejecutado.png" width="700" alt="Código IntelliJ Scala ejecutado"><br>
  <img src="images/sbt_compile_y_sbt_run_Intellij.png" width="650" alt="sbt compile y sbt run en IntelliJ">
</p>
