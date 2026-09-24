# practica3_python_Gomez-Espinosa_Iker_Aimar

## Descripción
Resolución de los 20 ejercicios de la Práctica 3 sobre listas, funciones y
paquetes, NumPy, diccionarios y pandas, lógica y control de flujo, y bucles.

## Entorno
- Python 3.12
- JupyterLab
- NumPy, pandas (ver `requirements.txt`)

## Estructura del repositorio
| Carpeta | Contenido |
| --- | --- |
| `data/` | Ficheros CSV de partida |
| `notebooks/` | Notebook con la resolución |
| `src/` | Módulo de funciones auxiliares |
| `outputs/` | Ficheros generados durante la ejecución |

## Cómo reproducir
```bash
py python3.12 -m venv .venv
.venv\Scripts\activate
python -m pip install --upgrade pip
python -m pip install jupyterlab numpy pandas
jupyter lab
