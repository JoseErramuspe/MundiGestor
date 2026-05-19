#!/bin/bash

mostrarMenu() {
	clear
	echo "|=================================|"
	echo "|  !! Bienvenido a MundiGestor !! |"
	echo "|=================================|"
	echo "| 1. Registrar equipo             |"
	echo "| 2. Registrar Partido            |"
	echo "| 3. Listar equipos               |"
	echo "| 4. Ver historial de partidos    |"
	echo "| 5. Cantidad de partidos jugados |"
	echo "| 6. Mostrar campeon actual       |"
	echo "| 7. Buscar equipo                |"
	echo "| 8. Borrar datos registrados     |"
	echo "| 9. Creditos                     |"
	echo "| 0. Salir                        |"
	echo "|=================================|"
	read -p "Opcion... " opcion
	case $opcion in 
		1)
			registrarEquipo
			;;
		2)
			registrarPartido
			;;
		3)
			listarEquipos
			volverAlMenu
			;;
		4)
			listarPartidos
			volverAlMenu
			;;
		5)
			cantidadDePartidosJugados
			volverAlMenu
			;;
		6)
			mostrarCampeonActual
			volverAlMenu
			;;
		7)
			buscarEquipo
			;;
		8)
			borrarDatos
			;;
		9)
			mostrarCreditos
			;;
		0)
			clear
			exit
			;;
		*)
			clear
			echo "Opcion invalida, presione ENTER para continuar..."
			read cont
			;;
	esac
}

volverAlMenu() {
	echo "Presione ENTER para volver al menu..."
	read cont
}

listarEquipos() {
	clear
	if [ "$(grep -c ^e: MGData)" -eq 0 ]; then
		echo "No se han registrado equipos aun"
	else
		echo "|============================|"
		echo "|    Equipos del Mundial:    |"
		echo "|============================|"
		grep ^e: MGData | cut -d":" -f2 | sed "s/^/| /"
		echo "|============================|"
		echo "|   Equipos no Eliminados:   |"
		echo "|============================|"
		grep ^c: MGData | cut -d":" -f2 | sed "s/^/| /"
		echo "|============================|"
	fi
}

listarPartidos() {
	clear
	if [ "$(grep -c ^p: MGData)" -eq 0 ]; then
		echo "No se han registrado partidos aun"
	else
		echo "|============================|"
		echo "|    Partidos del Mundial:   |"
		echo "|============================|"
		grep ^p: MGData | cut -d":" -f2 | sed "s/^/| /"
		echo "|============================|"
	fi
}

cantidadDePartidosJugados() {
	clear
	if [ "$(grep -c ^p: MGData)" -eq 0 ]; then
		echo "No se han jugado partidos aun"
	elif [ "$(grep -c ^p: MGData)" -eq 1 ]; then
		echo "Se ha jugado $(grep -c ^p: MGData) partido en total."
	else
		echo "Se han jugado $(grep -c ^p: MGData) partidos en total."
	fi
}

mostrarCreditos() {
	clear
	echo "|===========================================|"
	echo "|                  Creditos                 |"
	echo "|===========================================|"
	echo "| José Gabriel Erramuspe Rodríguez - 353422 |"
	echo "| Damián Agustín Torres Aramburu   - 371643 |"
	echo "|===========================================|"
	volverAlMenu
	return
}

mostrarCampeonActual() {
	clear
	if [ "$(grep -c ^c: MGData)" -eq 0 ]; then
		echo "No se han registrado equipos aun"
	elif [ "$(grep -c ^c: MGData)" -eq 1 ]; then
		echo "|==================================|"
		echo "|       Campeon del Mundial:       |"
		echo "|==================================|"
		echo "|  Del mundial realizado entre...  |"
		echo "|                                  |"
		grep ^e: MGData | cut -d":" -f2 | sed "s/^/| /"
		echo "|                                  |"
		echo "|  El campeon ha resultado ser...  |"
		echo "|==================================|"
		echo "|                                  |"
		echo "| !!! $(grep ^c: MGData | cut -d: -f2) !!!"
		echo "|                                  |"
		echo "|==================================|"
		echo ""
	else
		echo "|==================================|"
		echo "|       Campeon del Mundial:       |"
		echo "|==================================|"
		echo "|  Del mundial realizado entre...  |"
		echo "|                                  |"
		grep ^e: MGData | cut -d":" -f2 | sed "s/^/| /"
		echo "|                                  |"
		echo "|    El campeon aun no ha sido     |"
		echo "|            definido...           |"
		echo "|==================================|"
		echo "|      Aun estan en juego...       |"
		echo "|                                  |"
		grep ^c: MGData | cut -d":" -f2 | sed "s/^/| /"
		echo "|                                  |"
		echo "|==================================|"
		echo ""
	fi
}

buscarEquipo() {
	clear
	if [ "$(grep -c ^e: MGData)" -eq 0 ]; then
		echo "No se han registrado equipos aun"
		volverAlMenu
		return
	else
		read -p "Ingrese nombre del equipo a buscar: " equipoBuscado
		clear
		if [ -n "$(grep -i ^e:$equipoBuscado MGData)" ]; then
			echo "El equipo $equipoBuscado se encuentra registrado"
			read -p "Mostrar partidos del equipo? (y/n) " opcion
			clear
			if [ "$opcion" == "y" ]; then
				if [ "$(grep ^p: MGData | cut -d":" -f2 | grep -ic $equipoBuscado)" -eq 0 ]; then
					echo "$equipoBuscado aun no ha jugado partidos"
				else
					echo "|============================|"
					echo "| Partidos de $equipoBuscado: |"
					echo "|============================|"
					grep ^p: MGData | cut -d":" -f2 | grep -i $equipoBuscado | sed "s/^/| /"
					echo "|============================|"
				fi
			fi
			volverAlMenu
			return
		else
			echo "El equipo $equipoBuscado no se encuentra registrado"
			volverAlMenu
			return
		fi
	fi
}

registrarEquipo() {
	clear
	if [ "$(grep -c ^e: MGData)" -lt 15 ]; then
		read -p "Desea registrar un nuevo equipo? (y/n) " opcion
		if [ "$opcion" == "y" ]; then
			clear
			read -p "Ingrese nombre del nuevo equipo: " nuevoEquipo
			if [ -n "$(grep -i ^e:$nuevoEquipo MGData)" ]; then
				clear
				echo "Error: el equipo ya se encuentra registrado"
				volverAlMenu
				return
			fi
			if [ -n "$nuevoEquipo" ]; then
				clear
				echo "e:$nuevoEquipo" >> MGData
				echo "c:$nuevoEquipo" >> MGData
				echo "Equipo registrado con exito!"
				volverAlMenu
				return
			else
				clear
				echo "Error: nombre del equipo vacio"
				volverAlMenu
				return
			fi
		else
			clear
			echo "Registro de equipo cancelado exitosamente!"
			volverAlMenu
			return
		fi
	else
		echo "Error: cantidad maxima de equipos registrados (15)"
		volverAlMenu
		return
	fi
}

registrarPartido() {
	clear
	if [ "$(grep -c ^e: MGData)" -eq 0 ]; then
		clear
		echo "No se han registrado equipos aun"
		volverAlMenu
		return
	fi
	read -p "Desea registrar un nuevo partido? (y/n)" opcion
	if [ "$opcion" == "y" ]; then
		clear
		listarEquipos
		read -p "Ingrese equipo 1 del partido: " equipo1
		if [ -z "$(grep -i ^c:$equipo1 MGData)" ]; then
			clear
			echo "Error: equipo 1 no existe o ya fue eliminado"
			volverAlMenu
			return
		fi
		if [ -z "$equipo1" ]; then
			clear
			echo "Error: Nombre del equipo 1 vacio"
			volverAlMenu
			return
		fi
		read -p "Ingrese goles del equipo 1: " puntajeEquipo1
		if [ $puntajeEquipo1 -lt 0 ]; then
			clear
			echo "Error: no se permiten puntajes negativos"
			volverAlMenu
			return
		fi
		if [ -z "$puntajeEquipo1" ]; then
			clear
			echo "Error: no se ingreso puntaje"
			volverAlMenu
			return
		fi
		if [ -z "$(echo $puntajeEquipo1 | grep "^[0-9]*$")" ]; then
			clear
			echo "Error: puntaje ingresado debe contener solamente numeros naturales"
			volverAlMenu
			return
		fi
		
		clear
		listarEquipos
		read -p "Ingrese equipo 2 del partido: " equipo2
		if [ -z "$(grep -i ^c:$equipo2 MGData)" ]; then
			clear
			echo "Error: equipo 2 no existe o ya fue eliminado"
			volverAlMenu
			return
		fi
		if [ -z "$equipo2" ]; then
			clear
			echo "Error: Nombre del equipo 2 vacio"
			volverAlMenu
			return
		fi
		if [ "$equipo1" == "$equipo2" ]; then
			clear
			echo "Error: un equipo no puede jugar contra si mismo"
			volverAlMenu
			return
		fi
		read -p "Ingrese goles del equipo 2: " puntajeEquipo2
		if [ $puntajeEquipo2 -lt 0 ]; then
			clear
			echo "Error: no se permiten puntajes negativos"
			volverAlMenu
			return
		fi
		if [ -z "$puntajeEquipo2" ]; then
			clear
			echo "Error: no se ingreso puntaje"
			volverAlMenu
			return
		fi
		if [ -z "$(echo $puntajeEquipo2 | grep "^[0-9]*$")" ]; then
			clear
			echo "Error: puntaje ingresado debe contener solamente numeros naturales"
			volverAlMenu
			return
		fi
		
		clear
		read -p "Esta seguro que desea registrar el partido $equipo1 $puntajeEquipo1 - $puntajeEquipo2 $equipo2? (y/n) " opcion
		if [ "$opcion" == "y" ]; then
			local penalesEquipo1=0
			local penalesEquipo2=0
			clear
			if [ $puntajeEquipo1 -gt $puntajeEquipo2 ]; then
				equipoABorrar=$(grep -n "^c:$equipo2" MGData | cut -d: -f1)
				sed -i ${equipoABorrar}d MGData
			elif [ $puntajeEquipo1 -lt $puntajeEquipo2 ]; then
				equipoABorrar=$(grep -n "^c:$equipo1" MGData | cut -d: -f1)
				sed -i ${equipoABorrar}d MGData
			elif [ $puntajeEquipo1 -eq $puntajeEquipo2 ]; then
				echo "Partido empatado..."
				read -p "Ingrese goles del equipo 1 ($equipo1) en penales: " penalesEquipo1
				if [ $penalesEquipo1 -lt 0 ]; then
					clear
					echo "Error: no se permiten puntajes negativos"
					volverAlMenu
					return
				fi
				if [ -z "$penalesEquipo1" ]; then
					clear
					echo "Error: no se ingreso puntaje"
					volverAlMenu
					return
				fi
				if [ -z "$(echo $penalesEquipo1 | grep "^[0-9]*$")" ]; then
					clear
					echo "Error: puntaje ingresado debe contener solamente numeros naturales"
					volverAlMenu
					return
				fi
				read -p "Ingrese goles del equipo 2 ($equipo2) en penales: " penalesEquipo2
				if [ $penalesEquipo2 -lt 0 ]; then
					clear
					echo "Error: no se permiten puntajes negativos"
					volverAlMenu
					return
				fi
				if [ -z "$penalesEquipo2" ]; then
					clear
					echo "Error: no se ingreso puntaje"
					volverAlMenu
					return
				fi
				if [ -z "$(echo $penalesEquipo2 | grep "^[0-9]*$")" ]; then
					clear
					echo "Error: puntaje ingresado debe contener solamente numeros naturales"
					volverAlMenu
					return
				fi
				if [ $penalesEquipo1 -gt $penalesEquipo2 ]; then
					equipoABorrar=$(grep -n "^c:$equipo2" MGData | cut -d: -f1)
					sed -i ${equipoABorrar}d MGData
				elif [ $penalesEquipo1 -lt $penalesEquipo2 ]; then
					equipoABorrar=$(grep -n "^c:$equipo1" MGData | cut -d: -f1)
					sed -i ${equipoABorrar}d MGData
				elif [ $penalesEquipo1 -eq $penalesEquipo2 ]; then
					clear
					echo "Error: misma cantidad de goles de penales"
					volverAlMenu
					return
				fi
			fi
			clear
			if [ $((penalesEquipo1 + penalesEquipo2)) -eq 0 ]; then
				echo "p:$equipo1 $puntajeEquipo1 - $puntajeEquipo2 $equipo2" >> MGData
				echo "Partido $equipo1 $puntajeEquipo1 - $puntajeEquipo2 $equipo2 registrado con exito"
			else
				echo "p:$equipo1 $puntajeEquipo1($penalesEquipo1) - $puntajeEquipo2($penalesEquipo2) $equipo2" >> MGData
				echo "Partido $equipo1 $puntajeEquipo1($penalesEquipo1) - $puntajeEquipo2($penalesEquipo2) $equipo2 registrado con exito!"
			fi
			volverAlMenu
			return
		else
			echo "Registro cancelado exitosamente!"
			volverAlMenu
			return
		fi
	else
		clear
		echo "Registro cancelado exitosamente!"
		volverAlMenu
		return
	fi
}

borrarDatos() {
	clear
	read -p "Esta seguro que desea borrar todos los datos registrados? (y/n) " opcion
	if [ "$opcion" == "y" ]; then
		clear
		read -p "Esta COMPLETAMENTE SEGURO que desea borrar todos los datos registrados? ESTA DESICION ES IRREVERTIBLE. (y/n) " opcion
		if [ "$opcion" == "y" ]; then
			clear
			: > MGData
			echo "Datos eliminados exitosamente!"
			volverAlMenu
			return
		else
			clear
			echo "Eliminacion de datos cancelada exitosamente!"
			volverAlMenu
			return
		fi
	else
		clear
		echo "Eliminacion de datos cancelada exitosamente!"
		volverAlMenu
		return
	fi
}
while true; do
	mostrarMenu
done
