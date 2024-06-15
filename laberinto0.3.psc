///*----------------------------------------------------*
///*------------------   CONSTANTES   ------------------*
///*----------------------------------------------------*

SubProceso val <- EST_INICIO
	Definir val Como Caracter;
	val <- "0000";
FinSubProceso
SubProceso val <- EST_TECLA_INVALIDA
	Definir val Como Caracter;
	val <- "0001";
FinSubProceso
SubProceso val <- EST_MOVIMIENTO_INVALIDO
	Definir val Como Caracter;
	val <- "0002";
FinSubProceso
SubProceso val <- EST_COLISION_PARED
	Definir val Como Caracter;
	val <- "0003";
FinSubProceso
SubProceso val <- EST_MOSTRAR_ESTADISTICAS
	Definir val Como Caracter;
	val <- "0004";
FinSubProceso

///*----------------------------------------------------*
///*---------------------  INICIO  ---------------------*
///*----------------------------------------------------*

Proceso main
	Definir tam, opcionMenu Como Entero;
    Definir laberinto, estadoOriginal, estadoMenu Como Caracter;
    Dimension laberinto(10,10);
    Dimension estadoOriginal(10,10);
    tam <- 10; // Tama?o del laberinto
    estadoMenu <- EST_INICIO();
	Repetir
		mostrarMensaje_menuInicio(estadoMenu);
		Leer opcionMenu;
		Limpiar Pantalla;
		Segun opcionMenu Hacer
			1: // INICIAR JUEGO
				juego();
				
			2: // SALIR
				Escribir "Saliste sape";
				
			De Otro Modo: // TECLA INCORRECTA
				estadoMenu <- EST_TECLA_INVALIDA();
		FinSegun
		
	Hasta que opcionMenu = 2;
	
FinProceso

///*----------------------------------------------------*
///*---------------------   JUEGO   --------------------*
///*----------------------------------------------------*

SubProceso juego
	//Datos Personaje:
	Definir vida, experiencia, fuerza, defensa, nivel, agilidad, inteligencia Como Entero;
    Definir nombre, estado Como Caracter;
	
	//Datos Laberinto
	Definir tam Como Entero;
    Definir laberinto, estadoOriginal Como Caracter;
    Dimension laberinto(10,10);
    Dimension estadoOriginal(10,10);
    tam <- 10; // Tamaño del laberinto
	
	inicializarLaberinto(tam, laberinto);
	definirParedes(tam, laberinto);
	inicializarEstadoOriginal(tam, laberinto, estadoOriginal);
	
	// Inicializar enemigos en el laberinto
	colocarEnemigosAleatorios(tam, laberinto, 3); // Colocar 5 enemigos aleatorios
	
	//(mostrarLaberinto(tam, laberinto);
	
	creacionPersonaje(nombre, vida, experiencia, fuerza, defensa, agilidad, inteligencia, nivel, estado);
	seguimiento(nombre, vida, experiencia, fuerza, defensa, agilidad, inteligencia, nivel, estado, tam, laberinto, estadoOriginal);
FinSubProceso

///*----------------------------------------------------*
///*-------------  INICIALIZAR LABERINTO  --------------*
///*----------------------------------------------------*

SubProceso inicializarLaberinto(tam, laberinto)
    Definir fila, columna Como Entero;
    Para fila <- 0 Hasta tam-1 Hacer
        Para columna <- 0 Hasta tam-1 Hacer
            laberinto(fila, columna) <- "[ ]"; // Espacio vac?o inicial
        FinPara
    FinPara
FinSubProceso

SubProceso inicializarEstadoOriginal(tam, laberinto, estadoOriginal)
    Definir fila, columna Como Entero;
    Para fila <- 0 Hasta tam-1 Hacer
        Para columna <- 0 Hasta tam-1 Hacer
            estadoOriginal(fila, columna) <- laberinto(fila, columna);
        FinPara
    FinPara
FinSubProceso

SubProceso definirParedes(tam, laberinto)
    Definir descripcionLaberinto Como Caracter;
    Dimension descripcionLaberinto(10);
    descripcionLaberinto(0)<-"C XXXXXXXX";
    descripcionLaberinto(1)<-"X X      X";
    descripcionLaberinto(2)<-"X XXXXXX X";
    descripcionLaberinto(3)<-"X        X";
    descripcionLaberinto(4)<-"X XXXXX XX";
    descripcionLaberinto(5)<-"X       XX";
    descripcionLaberinto(6)<-"X XX XXXXX";
    descripcionLaberinto(7)<-"X XX XXXXX";
    descripcionLaberinto(8)<-"X XX XXXXX";
    descripcionLaberinto(9)<-"X        [";
    Definir fila, columna Como Entero;
    Para fila <- 0 Hasta tam-1 Hacer
        Para columna <- 0 Hasta tam-1 Hacer
            laberinto(fila, columna) <- Subcadena(descripcionLaberinto(fila), columna, columna);
        FinPara
    FinPara
FinSubProceso

SubProceso colocarEnemigosAleatorios(tam, laberinto, cantidadEnemigos)
    Definir enemigoPosX, enemigoPosY Como Entero;
    Definir contador Como Entero;
    contador <- 0;
    Mientras contador < cantidadEnemigos Hacer
        enemigoPosX <- lanzarDado(0, tam-1);
        enemigoPosY <- lanzarDado(0, tam-1);
        Si laberinto(enemigoPosX, enemigoPosY) = " " Entonces
            laberinto(enemigoPosX, enemigoPosY) <- "E";
            contador <- contador + 1;
        FinSi
    FinMientras
FinSubProceso

///*----------------------------------------------------*
///*---------------  CREACION PERSONAJE  ---------------*
///*----------------------------------------------------*

SubProceso creacionPersonaje(nombre Por Referencia, vida Por Referencia, experiencia Por Referencia, fuerza Por Referencia, defensa Por Referencia, agilidad Por Referencia, inteligencia Por Referencia, nivel Por Referencia, estado Por Referencia)
    mostrarMensaje_ingresarNombre();
    Leer nombre;
    inicializarEstadisticas(nombre, vida, experiencia, fuerza, defensa, agilidad, inteligencia, nivel, estado);
	mostrarMensaje_estadisticasPersonaje(nombre, vida, experiencia, fuerza, defensa, agilidad, inteligencia, nivel, estado);
	Escribir "Presione una tecla para continuar";
	Esperar Tecla;
FinSubProceso

// Proceso principal para crear un personaje con atributos basados en D&D 5e 
SubProceso inicializarEstadisticas(nombre Por Referencia, vida Por Referencia, experiencia Por Referencia, fuerza Por Referencia, defensa Por Referencia, agilidad Por Referencia, inteligencia Por Referencia, nivel Por Referencia, estado Por Referencia)
    
    // Inicializamos la vida y experiencia base
    vida <- 10 + sumaTresMayoresD6(); // Base de 10 m?s bonificaci?n
    experiencia <- 0;
    nivel <- 1;
    estado <- "Normal";
    
    // Ajustamos cada atributo con la suma de los tres mayores de 4d6
    // y aseguramos que est?n en el rango de 0 a 20
    fuerza <- ajustarAtributo(sumaTresMayoresD6());
    defensa <- ajustarAtributo(sumaTresMayoresD6());
    agilidad <- ajustarAtributo(sumaTresMayoresD6());
    inteligencia <- ajustarAtributo(sumaTresMayoresD6());
    
FinSubProceso

///*----------------------------------------------------*
///*--------------------  EJECUCION  -------------------*
///*----------------------------------------------------*

SubProceso seguimiento(nombre Por Referencia, vida Por Referencia, experiencia Por Referencia, fuerza Por Referencia, defensa Por Referencia, agilidad Por Referencia, inteligencia Por Referencia, nivel Por Referencia, estado Por Referencia, tam, laberinto, estadoOriginal)
    Definir posX, posY, posXNueva, posYNueva Como Entero;
    Definir simboloJugador, estadoAccion Como Caracter;
    Definir juegoActivo Como Logico;
	simboloJugador <- "J";
    juegoActivo <- Verdadero;
	estadoAccion <- EST_INICIO;
	
    posX <- 0; posY <- 0;  // Asumiendo que el jugador empieza en la esquina superior izquierda
    laberinto(posX, posY) <- simboloJugador;  // Colocamos al jugador en la posici?n inicial
	
    Mientras juegoActivo Hacer
		Limpiar Pantalla;
        mostrarLaberinto(tam, laberinto);
        posXNueva <- posX;  // Preparar las nuevas posiciones
        posYNueva <- posY;
        
        // Obtener la nueva posici?n basada en la entrada del usuario
        presionar(estadoAccion, posX, posY, posXNueva, posYNueva, simboloJugador, laberinto, tam);
		
        // Verificar y actualizar la posici?n
        Si posXNueva <> posX O posYNueva <> posY Entonces  // Si hay un cambio de posici?n
            evaluarPosicion(tam, laberinto, estadoOriginal, posXNueva, posYNueva, posX, posY, simboloJugador, juegoActivo);
            Si juegoActivo Entonces
                // Actualizar las posiciones antiguas y nuevas
                posX <- posXNueva;
                posY <- posYNueva;
            FinSi
		SiNo
			Si estadoAccion = EST_MOSTRAR_ESTADISTICAS Entonces
				mostrarMensaje_estadisticasPersonaje(nombre, vida, experiencia, fuerza, defensa, agilidad, inteligencia, nivel, estado);
				Escribir "Presione una tecla para continuar";
				Esperar Tecla;
			FinSi
        FinSi
    FinMientras;
FinSubProceso

SubProceso presionar(estadoAccion Por Referencia, posX, posY, posXNueva Por Referencia, posYNueva Por Referencia, simboloJugador, laberinto, tam)
    Definir eleccionLetra, direccion Como Caracter;
    Definir eleccionNumero Como Entero;
	
	mostrarMensaje_accionesMapa(estadoAccion);
    Leer eleccionLetra;
    
    eleccionLetra <- Minusculas(eleccionLetra);
    Si 		eleccionLetra = "a" Entonces
        eleccionNumero <- 1;
    SiNo Si eleccionLetra = "s" Entonces
		eleccionNumero <- 2;
	SiNo Si eleccionLetra = "d" Entonces
		eleccionNumero <- 3;
	SiNo Si eleccionLetra = "w" Entonces
		eleccionNumero <- 4;
	SiNo Si eleccionLetra = "e" Entonces
		eleccionNumero <- 5;
	Sino
		eleccionNumero <- -1; // Invalid
		FinSi
		FinSi
		FinSi
		FinSi
    FinSi
	
    Segun eleccionNumero Hacer
        1:  // Izquierda
            Si posY > 0 Entonces
                Si laberinto(posX, posY - 1) <> "X" Entonces
                    posYNueva <- posY - 1;
					estadoAccion <- EST_INICIO();
                Sino
                    //mostrarMensaje("Hay una pared a la izquierda!");
					estadoAccion <- EST_COLISION_PARED();
                FinSi
            Sino
                //mostrarMensaje("Movimiento inv?lido hacia la izquierda!");
				estadoAccion <- EST_MOVIMIENTO_INVALIDO();
            FinSi
        2:  // Abajo
            Si posX < tam - 1 Entonces
                Si laberinto(posX + 1, posY) <> "X" Entonces
                    posXNueva <- posX + 1;
					estadoAccion <- EST_INICIO();
                Sino
                    //mostrarMensaje("Hay una pared abajo!");
					estadoAccion <- EST_COLISION_PARED();
                FinSi
            Sino
                //mostrarMensaje("Movimiento inv?lido hacia abajo!");
				estadoAccion <- EST_MOVIMIENTO_INVALIDO();
            FinSi
        3:  // Derecha
            Si posY < tam - 1 Entonces
                Si laberinto(posX, posY + 1) <> "X" Entonces
                    posYNueva <- posY + 1;
					estadoAccion <- EST_INICIO();
                Sino
                    //mostrarMensaje("Hay una pared a la derecha!");
					estadoAccion <- EST_COLISION_PARED();
                FinSi
            Sino
                //mostrarMensaje("Movimiento inv?lido hacia la derecha!");
				estadoAccion <- EST_MOVIMIENTO_INVALIDO();
            FinSi
        4:  // Arriba
            Si posX > 0 Entonces
                Si laberinto(posX - 1, posY) <> "X" Entonces
                    posXNueva <- posX - 1;
					estadoAccion <- EST_INICIO();
                Sino
                    //mostrarMensaje("Hay una pared arriba!");
					estadoAccion <- EST_COLISION_PARED();
                FinSi
            Sino
                //mostrarMensaje("Movimiento inv?lido hacia arriba!");
				estadoAccion <- EST_MOVIMIENTO_INVALIDO();
            FinSi
		4:  // Arriba
            Si posX > 0 Entonces
                Si laberinto(posX - 1, posY) <> "X" Entonces
                    posXNueva <- posX - 1;
                Sino
                    mostrarMensaje("Hay una pared arriba!");
                FinSi
            Sino
                mostrarMensaje("Movimiento inválido hacia arriba!");
            FinSi
		5:
			estadoAccion <- EST_MOSTRAR_ESTADISTICAS();
        De Otro Modo:
            //mostrarMensaje("Tecla inv?lida. Use A, S, D, W para moverse.");
			estadoAccion <- EST_TECLA_INVALIDA();
    FinSegun
FinSubProceso

SubProceso evaluarPosicion(tam, laberinto, estadoOriginal, posXNueva, posYNueva, posX, posY, simboloJugador, juegoActivo Por Referencia)
    Si laberinto(posXNueva, posYNueva) = "X" Entonces
        mostrarMensaje("¡Hay una pared aquí!");
        posXNueva <- posX; // Revertir el movimiento
        posYNueva <- posY;
    Sino
        Si laberinto(posXNueva, posYNueva) = "E" Entonces
            mostrarMensaje("¡Un enemigo! Prepárate para luchar");
            Esperar 2 Segundos;
			pelea;
			laberinto(posX, posY) <- estadoOriginal(posX, posY);
			laberinto(posXNueva, posYNueva) <- simboloJugador;
        Sino
            Si laberinto(posXNueva, posYNueva) = "[" Entonces
                mostrarMensaje("¡Llegaste, descansa en esta hoguera guerrero!");
                juegoActivo <- Falso;
            Sino
                laberinto(posX, posY) <- estadoOriginal(posX, posY);
                laberinto(posXNueva, posYNueva) <- simboloJugador;
            FinSi;
        FinSi;
    FinSi;
	Limpiar Pantalla;
FinSubProceso

// Incluimos una funci?n para simular el lanzamiento de un dado de 6 caras
Funcion enteroAleatorio <- lanzarDado(minimo,maximo)
	Definir enteroAleatorio Como Entero;
    enteroAleatorio <- Aleatorio(minimo, maximo);
FinFuncion

// Funci?n para obtener la suma de los tres mayores de cuatro dados D6
Funcion suma <- sumaTresMayoresD6
    Definir dado1, dado2, dado3, dado4 Como Entero;
    Definir menor, suma Como Entero;
    
    // Lanzamos cuatro dados
    dado1 <- lanzarDado(0,6);
    dado2 <- lanzarDado(0,6);
    dado3 <- lanzarDado(0,6);
    dado4 <- lanzarDado(0,6);
    
    // Encontramos el menor de los cuatro lanzamientos
    menor <- dado1;
    Si menor > dado2 Entonces
        menor <- dado2;
    FinSi
    Si menor > dado3 Entonces
        menor <- dado3;
    FinSi
    Si menor > dado4 Entonces
        menor <- dado4;
    FinSi
    
    // Sumamos todos los dados y restamos el menor
    suma <- dado1 + dado2 + dado3 + dado4 - menor;
FinFuncion

// Funci?n para ajustar un atributo a estar dentro del rango de 0 a 20
Funcion value <- ajustarAtributo(value)
    Si value < 0 Entonces
        value <- 0;
    Sino Si value > 20 Entonces
			value <- 20;
		FinSi
	FinSi
FinFuncion

SubProceso pelea
	Escribir "Hola";
FinSubProceso

///*----------------------------------------------------*
///*-------------------   PANTALLA   -------------------*
///*----------------------------------------------------*

//Imprime el mensaje ingresado dentro de un recuadro
//El mensaje se ajustará a la cantidad de caracteres indicadas en longMensaje
//El recuadro tiene una longitud de longMensaje + 4 ( = los 2 bordes + los 2 espacios de margen)
SubProceso mostrarMensaje(mensaje)
	Definir longMensaje, i Como Entero;
	Definir techo, piso, palabras Como Caracter;
	
	longMensaje <- 38;
	
	techo <- "|-";
	piso <- "|_";
	Para i <- 1 Hasta longMensaje Con Paso 1 Hacer
		techo <- Concatenar(techo, "-");
		piso <- Concatenar(piso, "_");
	FinPara
	techo <- Concatenar(techo, "-|");
	piso <- Concatenar(piso, "_|");
	
    Escribir techo;
    Para i <- 0 Hasta Longitud(mensaje) - 1 Con Paso longMensaje hacer
		palabras <- Subcadena(mensaje, i, i + longMensaje - 1);
		escrituraMensaje(Subcadena(palabras, 0, longMensaje - 1), longMensaje);
	FinPara
    Escribir piso;
FinSubProceso

//Imprime los mensajes ingresados dentro de un recuadro
//Los mensajes se ajustar?n a la cantidad de caracteres indicadas en longMensaje
//Si el mensaje es mas largo que esto, se recortar?
SubProceso mostrarMensajes(mensajes, cantidad)
	Definir longMensaje, i Como Entero;
	Definir techo, piso, palabras Como Caracter;
	
	longMensaje <- 38;
	
	techo <- "|-";
	piso <- "|_";
	Para i <- 1 Hasta longMensaje Con Paso 1 Hacer
		techo <- Concatenar(techo, "-");
		piso <- Concatenar(piso, "_");
	FinPara
	techo <- Concatenar(techo, "-|");
	piso <- Concatenar(piso, "_|");
	
    Escribir techo;
    Para i <- 0 Hasta cantidad - 1 Con Paso 1 hacer
		escrituraMensaje(Subcadena(mensajes[i],0,longMensaje), longMensaje);
	FinPara
    Escribir piso;
FinSubProceso

//Escribe el mensaje dentro del recuadro colocando saltos de linea en base al tama?o solicitado
SubProceso escrituraMensaje(mensaje, tamanio)
	Definir i como entero;
	
	Para i <- 0 Hasta tamanio - Longitud(mensaje) Con Paso 1 Hacer
		mensaje <- Concatenar(mensaje, " ");
	FinPara
	
	Escribir Sin Saltar "| ";
	Para i <- 0 hasta tamanio-1 Con Paso 1 Hacer
		Escribir Sin Saltar Subcadena(mensaje,i,i);
	FinPara
	Escribir " |";
FinSubProceso

Subproceso mostrarMensaje_ingresarNombre
	Definir mensaje Como Caracter;
	mensaje <-                    "Ingrese el nombre de su personaje     ";
	mensaje <- Concatenar(mensaje,"para comenzar"                         );
    mostrarMensaje(mensaje);
FinSubProceso

Subproceso mostrarMensaje_accionesMapa(estado)
	Definir mensaje Como Caracter;
	mensaje <- "";
	Si estado = EST_TECLA_INVALIDA() Entonces
		mensaje <- "¡Opción inválida!                     ";
	SiNo Si estado = EST_MOVIMIENTO_INVALIDO() Entonces
		mensaje <- "¡Movimiento Inválido!                 ";
	SiNo Si estado = EST_COLISION_PARED() Entonces
		mensaje <- "¡Una pared bloquea el paso!           ";
		FinSi
		FinSi
	FinSi
	mensaje <- Concatenar(mensaje," Ingrese una acción:                  ");
	mensaje <- Concatenar(mensaje,"            (W) Arriba   (E) Stats    ");
	mensaje <- Concatenar(mensaje,"    Izq (A)     (D) Der               ");
	mensaje <- Concatenar(mensaje,"            (S) Abajo                 ");
    mostrarMensaje(mensaje);
FinSubProceso

Subproceso mostrarMensaje_menuInicio(estado)
	ilustracionMenu();
	Definir mensaje Como Caracter;
	mensaje <- "";
	Si estado = EST_TECLA_INVALIDA() Entonces
		mensaje <- "¡Opción inválida!                     ";
	FinSi
	mensaje <- Concatenar(mensaje," (1) Iniciar Juego                    ");
	mensaje <- Concatenar(mensaje," (2) Salir                            ");
    mostrarMensaje(mensaje);
FinSubProceso

SubProceso mostrarMensaje_estadisticasPersonaje(nombre, vida, experiencia, fuerza, defensa, agilidad, inteligencia, nivel, estado)
	Definir mensaje, aux Como Caracter;
	Dimension mensaje[10];
	mensaje[0] <- "DATOS PERSONAJE";
	mensaje[1] <- Mayusculas(nombre);
	mensaje[2] <- Concatenar("Vida: ", ConvertirATexto(vida));
	mensaje[3] <- Concatenar("Experiencia: ", ConvertirATexto(experiencia));
	mensaje[4] <- Concatenar("Fuerza: ", ConvertirATexto(fuerza));
	mensaje[5] <- Concatenar("Defensa: ", ConvertirATexto(defensa));
	mensaje[6] <- Concatenar("Agilidad: ", ConvertirATexto(agilidad));
	mensaje[7] <- Concatenar("Inteligencia: ", ConvertirATexto(inteligencia));
	mensaje[8] <- Concatenar("Nivel: ", ConvertirATexto(nivel));
	mensaje[9] <- Concatenar("Estado: ", estado);
	mostrarMensajes(mensaje, 10);
FinSubProceso

SubProceso mostrarLaberinto(tam, laberinto)
    Definir fila, columna Como Entero;
    Para fila <- 0 Hasta tam-1 Hacer
        Para columna <- 0 Hasta tam-1 Hacer
            Escribir "[", laberinto(fila, columna), "] " Sin Saltar;
        FinPara
        Escribir " ";
    FinPara
FinSubProceso

SubProceso ilustracionMenu 
	Escribir "                                         .^^--..__";
	Escribir "                     _                     []       ``-.._";
	Escribir "                  . ` ` .                  ||__           `-._";
	Escribir "                 /    ,-.\                 ||_ ```---..__     `-.";
	Escribir "                /    /:::\\               /|//}          ``--._  `.";
	Escribir "                |    |:::||              |////}                `-. \";
	Escribir "                |    |:::||             //^///                    `.\";
	Escribir "                |    |:::||            //  ||                       `|";
	Escribir "                /    |:::|/        _,-//\  ||";
	Escribir "               /`    |:::|`-,__,-`   |/  \ |";
	Escribir "             /`  |   |   ||           \   |||";
	Escribir "           /`    \   |   ||            |  /||";
	Escribir "         |`       |  |   |)            \ | ||";
	Escribir "        |          \ |   /      ,.__    \| ||";
	Escribir "        /           `         /`    `\   | ||";
	Escribir "       |                     /        \  / ||";
	Escribir "       |                     |        | /  ||";
	Escribir "       /         /           |        `(   ||";
	Escribir "      /          .           /          )  ||";
	Escribir "     |            \          |     ________||";
	Escribir "    /             |          /     `-------.|";
	Escribir "   |\            /          |              ||";
	Escribir "   \/`-._       |           /              ||";
	Escribir "    //   `.    /`           |              ||";
	Escribir "   //`.    `. |             \              ||";
	Escribir "  ///\ `-._  )/             |              ||";
	Escribir " //// )   .(/               |              ||";
	Escribir " ||||   ,`  )               /              //";
	Escribir " ||||  /                    /             || ";
	Escribir " `\\` /`                    |             // ";
	Escribir "     |`                     \            ||  ";
	Escribir "    /                        |           //  ";
	Escribir "  /`                          \         //   ";
	Escribir "/`                            |        ||    ";
	Escribir "`-.___,-.      .-.        ___,/        (/    ";
	Escribir "         `---?`   `?----?`";
FinSubProceso