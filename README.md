# ⚽ MundiGestor
Un sistema hecho en bash scripting que permite gestionar partidos y equipos de un torneo mundial de futbol por eliminación directa.
---
## 🛠️ Requerimientos
El/los requerimientos y software requeridos para ejecutar MundiGestor son:
- Software capaz de ejecutar archivos .sh y bash (VM, WSL, unix, etc.)
---
## 📝 Funcionalidades
MundiGestor posee distintas funcionalidades las cuales permiten al usuario sacarle el mayor provecho al sistema. Las mismas se muestran en el menú de inicio y son:
- **Registrar equipo:** Permite registrar un nuevo equipo del torneo.
- **Registrar partido:** Dados dos equipos y su puntaje, permite registrar un nuevo partido entre ambos equipos donde el perdedor es eliminado del campeonato. Si el puntaje ingresado es igual, entonces requerirá ingresar puntaje de penales.
- **Listar equipos:** Muestra dos tablas con los equipos del campeonato, una con todos los equipos que ingresaron al campeonato y la siguiente con los equipos que aún no han sido descalificados según los partidos jugados.
- **Ver historial de partidos:** Muestra el historial de todos los partidos jugados en el campeonato, se muestran los nombres de los paises, la cantidad de goles y la cantidad de goles de penales en caso de que hubieran.
- **Cantidad de partidos jugados:** Muestra el numero de la cantidad de partidos totales que se hayan jugado.
- **Mostrar campeon actual:** Muestra la tabla de todos los países que ingresaron al campeonato y luego los países que aún siguen jugando, en caso de ser solo uno el cual continúe invicto al final del campeonato (según los datos ingresados y determinado por los mismos), lo muestra como campeón.
- **Buscar equipo:** Permite al usuario buscar un equipo entre los equipos ingresados para verificar que exista. En caso de que exista, permite ver los partidos jugados por ese equipo.
- **Borrar datos registrados:** Permite la eliminación fácil de todos los datos ingresados, tanto equipos como partidos.
- **Creditos:** Muestra los nombres de los creadores del programa junto a sus respectivos números de estudiante.
- **Salir:** Permite finalizar la ejecución del programa.
---
## 🗂️ Estructura de Archivos
MundiGestor se estructura en los siguientes archivos:
```
MundiGestor
├ MundiGestor.sh   # Lógica y ejecución del código, ingreso y lectura de datos
├ MGData           # Almacenamiento de datos
└ README.md        # Archivo README.md
```
---
## ✏️ Desarrollo del Sistema
MundiGestor fue desarrollado utilizando las herramientas Notepad++ y se ejecutó con propósitos de testeo utilizando WSL en un entorno Windows 11. El sistema no contiene código generado con IA.

---
## ⭐ Créditos
El sistema fue desarrollado por:
- José Gabriel Erramuspe Rodríguez
- Damián Agustín Torres Aramburu
