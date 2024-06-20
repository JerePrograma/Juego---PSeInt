///----------------------------------------------------
///------------------ CONSTANTES ------------------
///----------------------------------------------------

SubProceso ESTADO_INICIAL <- obtenerEstadoInicial
	Definir ESTADO_INICIAL Como Caracter;
	ESTADO_INICIAL <- "0000";
FinSubProceso

SubProceso ESTADO_TECLA_INVALIDA <- obtenerEstadoTeclaInvalida
	Definir ESTADO_TECLA_INVALIDA Como Caracter;
	ESTADO_TECLA_INVALIDA <- "0001";
FinSubProceso

SubProceso ESTADO_MOVIMIENTO_INVALIDO <- obtenerEstadoMovimientoInvalido
	Definir ESTADO_MOVIMIENTO_INVALIDO Como Caracter;
	ESTADO_MOVIMIENTO_INVALIDO <- "0002";
FinSubProceso

SubProceso ESTADO_COLISION_PARED <- obtenerEstadoColisionPared
	Definir ESTADO_COLISION_PARED Como Caracter;
	ESTADO_COLISION_PARED <- "0003";
FinSubProceso

SubProceso ESTADO_MOSTRAR_ESTADISTICAS <- obtenerEstadoMostrarEstadisticas
	Definir ESTADO_MOSTRAR_ESTADISTICAS Como Caracter;
	ESTADO_MOSTRAR_ESTADISTICAS <- "0004";
FinSubProceso

///----------------------------------------------------
///--------------------- INICIO ---------------------
///----------------------------------------------------

Proceso main
    Definir opcionMenu Como Entero;
    Definir estadoMenu Como Caracter;

    estadoMenu <- obtenerEstadoInicial;
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
                estadoMenu <- obtenerEstadoTeclaInvalida;
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
    Definir tamLaberinto Como Entero;
    Definir laberinto, estadoOriginal Como Caracter;
    Dimension laberinto(20,20);
    Dimension estadoOriginal(20,20);
    tamLaberinto <- 20; // Tamaño del laberinto
    
    inicializarLaberinto(tamLaberinto, laberinto);
    inicializarEstadoOriginal(tamLaberinto, laberinto, estadoOriginal);
    
    // Inicializar enemigos en el laberinto
    colocarEnemigosAleatorios(tamLaberinto, laberinto, 3); // Colocar 3 enemigos aleatorios
    
    // Mostrar el laberinto
    mostrarLaberinto(tamLaberinto, laberinto);
    
    creacionPersonaje(nombre, vida, experiencia, fuerza, defensa, agilidad, inteligencia, nivel, estado);
    seguimiento(nombre, vida, experiencia, fuerza, defensa, agilidad, inteligencia, nivel, estado, tamLaberinto, laberinto, estadoOriginal);
FinSubProceso


///*----------------------------------------------------*
///*-------------  INICIALIZAR LABERINTO  --------------*
///*----------------------------------------------------*

SubProceso inicializarLaberinto(tam, laberinto)
    Definir tamLaberinto, n Como Entero;
    tamLaberinto <- tam; // Usar el parámetro tam pasado al subproceso
    poblarLaberinto(tamLaberinto, laberinto);
    
    Escribir "Creando Mundo...";
    Escribir "";
    
    Mientras no esConectado(tamLaberinto, laberinto) Hacer
        poblarLaberinto(tamLaberinto, laberinto);
        Para n <- 0 Hasta 4 Hacer
            aplicarReglas(tamLaberinto, laberinto);
        FinPara
    FinMientras
    
    // Limpiar alrededores de la entrada y la salida
    laberinto(0,1) <- " ";
    laberinto(1,0) <- " ";
    laberinto(1,1) <- " ";
    
    laberinto((tamLaberinto-1),(tamLaberinto-1)-1) <- " ";
    laberinto((tamLaberinto-1)-1,(tamLaberinto-1)) <- " ";
    laberinto((tamLaberinto-1)-1,(tamLaberinto-1)-1) <- " ";
    
    // Marcar la posición final del laberinto
    laberinto(19,19) <- "[";
    
    poblarLaberintoEnemigos(tamLaberinto, laberinto);
    
    mostrarLaberinto(tamLaberinto, laberinto);
    
    // Confirmación
    Si esConectado(tamLaberinto, laberinto) Entonces
        Escribir "La entrada y la salida están conectadas.";
    Sino
        Escribir "La entrada y la salida no están conectadas.";
    FinSi
FinSubProceso

SubProceso inicializarEstadoOriginal(tam, laberinto, estadoOriginal)
    Definir fila, columna Como Entero;
    Para fila <- 0 Hasta tam-1 Hacer
        Para columna <- 0 Hasta tam-1 Hacer
            estadoOriginal(fila, columna) <- laberinto(fila, columna);
        FinPara
    FinPara
FinSubProceso

SubProceso colocarEnemigosAleatorios(tam, laberinto, cantidadEnemigos)
    Definir enemigoPosX, enemigoPosY, contador Como Entero;
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
    vida <- 10 + sumaTresMayoresD6(); // Base de 10 más bonificación
    experiencia <- 0;
    nivel <- 1;
    estado <- "Normal";
    
    // Ajustamos cada atributo con la suma de los tres mayores de 4d6
    // y aseguramos que estén en el rango de 0 a 20
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
    estadoAccion <- obtenerEstadoInicial;
    
    posX <- 0; posY <- 0;  // Asumiendo que el jugador empieza en la esquina superior izquierda
    laberinto(posX, posY) <- simboloJugador;  // Colocamos al jugador en la posición inicial
    
    Mientras juegoActivo Hacer
        Limpiar Pantalla;
        mostrarLaberinto(tam, laberinto);
        posXNueva <- posX;  // Preparar las nuevas posiciones
        posYNueva <- posY;
        
        // Obtener la nueva posición basada en la entrada del usuario
        presionar(estadoAccion, posX, posY, posXNueva, posYNueva, simboloJugador, laberinto, tam);
        
        // Verificar y actualizar la posición
        Si posXNueva <> posX O posYNueva <> posY Entonces  // Si hay un cambio de posición
            evaluarPosicion(tam, laberinto, estadoOriginal, posXNueva, posYNueva, posX, posY, simboloJugador, juegoActivo);
            Si juegoActivo Entonces
                // Actualizar las posiciones antiguas y nuevas
                posX <- posXNueva;
                posY <- posYNueva;
            FinSi
        SiNo
            Si estadoAccion = obtenerEstadoTeclaInvalida Entonces
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
    Si      eleccionLetra = "a" Entonces
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
                    estadoAccion <- obtenerEstadoInicial;
                Sino
                    estadoAccion <- obtenerEstadoColisionPared;
                FinSi
            Sino
                estadoAccion <- obtenerEstadoMovimientoInvalido;
            FinSi
        2:  // Abajo
            Si posX < tam - 1 Entonces
                Si laberinto(posX + 1, posY) <> "X" Entonces
                    posXNueva <- posX + 1;
                    estadoAccion <- obtenerEstadoInicial;
                Sino
                    estadoAccion <- obtenerEstadoColisionPared;
                FinSi
            Sino
                estadoAccion <- obtenerEstadoMovimientoInvalido;
            FinSi
        3:  // Derecha
            Si posY < tam - 1 Entonces
                Si laberinto(posX, posY + 1) <> "X" Entonces
                    posYNueva <- posY + 1;
                    estadoAccion <- obtenerEstadoInicial;
                Sino
                    estadoAccion <- obtenerEstadoColisionPared;
                FinSi
            Sino
                estadoAccion <- obtenerEstadoMovimientoInvalido;
            FinSi
        4:  // Arriba
            Si posX > 0 Entonces
                Si laberinto(posX - 1, posY) <> "X" Entonces
                    posXNueva <- posX - 1;
                    estadoAccion <- obtenerEstadoInicial;
                Sino
                    estadoAccion <- obtenerEstadoColisionPared;
                FinSi
            Sino
                estadoAccion <- obtenerEstadoMovimientoInvalido;
            FinSi
        5:
            estadoAccion <- obtenerEstadoMostrarEstadisticas;
        De Otro Modo:
            estadoAccion <- obtenerEstadoTeclaInvalida;
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
            laberinto(posX, posY) <- " ";
            laberinto(posXNueva, posYNueva) <- simboloJugador;
        Sino
            Si laberinto(posXNueva, posYNueva) = "[" Entonces
                BuscaHongos;
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

// Incluimos una función para simular el lanzamiento de un dado de 6 caras
Funcion enteroAleatorio <- lanzarDado(minimo,maximo)
    Definir enteroAleatorio Como Entero;
    enteroAleatorio <- Aleatorio(minimo, maximo);
FinFuncion

// Función para obtener la suma de los tres mayores de cuatro dados D6
Funcion suma <- sumaTresMayoresD6
    Definir dado1, dado2, dado3, dado4 Como Entero;
    Definir menor, suma Como Entero;
    
    // Lanzamos cuatro dados
    dado1 <- lanzarDado(1,6);
    dado2 <- lanzarDado(1,6);
    dado3 <- lanzarDado(1,6);
    dado4 <- lanzarDado(1,6);
    
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

// Función para ajustar un atributo a estar dentro del rango de 0 a 20
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

SubProceso BuscaHongos
    Dimension num[9,9], fan[9,9];
    Definir mina_pisada, num_minas_car, opcion_letra Como Caracter;
    Definir salir, retirada Como Caracter;
    Definir num_minas, op, fil, col, i, j, xe, ye, verificar, varX, varY, busX, busY, marX, marY, nivel, opc Como Entero;
    Definir juegoHongos Como Logico;
    juegoHongos <- Verdadero;
    retirada <- '';
    Repetir
        Limpiar Pantalla;
        Escribir "********************************************************************";
        Escribir "********************************************************************";
        Escribir "************     BUSCA HONGOS DEL REINO OLVIDADO      **************";    
        Escribir "************ FELICIDADES JUGADOR, SUPERASTE ESTE MAPA **************";
        Escribir "***  PARA PASAR AL PRÓXIMO DEBERÁS PASAR POR UN CAMPO DE HONGOS  ***";
        Escribir "************** PRESIONE CUALQUIER TECLA PARA CONTINUAR **************";
        Escribir "********************************************************************";
        Leer opcion_letra;
        
        
        Repetir
            Limpiar Pantalla;
            Escribir "**************  NIVEL    ";
            Escribir "**************  1. FACIL [5 hongos]  ";
            Escribir "**************  2. INTERMEDIO [10 hongos]    ";
            Escribir "**************  3. DIFICIL  [15 hongos]  ";
            Leer opc;
            Segun opc Hacer
                1:
                    nivel <- 5;
                2:
                    nivel <- 10;
                3:
                    nivel <- 15;
                De Otro Modo:
                    Escribir "Opción no válida";
            FinSegun
        Hasta Que opc >= 1 Y opc <= 3
        
        num_minas <- 0;
        op <- 1;
        Para fil <- 0 Hasta 7 Hacer
            Para col <- 0 Hasta 7 Hacer
                num[fil,col] <- "-";
                fan[fil,col] <- "-";
            FinPara
        FinPara
        
        // UBICACION DE HONGOS AL AZAR
        Para i <- 1 Hasta nivel Hacer
            xe <- Azar(6) + 1;
            ye <- Azar(6) + 1;
            Si num[xe,ye] = "-" Entonces
                num[xe,ye] <- "X";
            Sino
                i <- i - 1;
            FinSi
        FinPara
        
        Repetir                    
            // VERIFICAR SI HAY HONGOS
            verificar <- 0;
            Para fil <- 1 Hasta 7 Hacer
                Para col <- 1 Hasta 7 Hacer
                    Si fan[fil,col] = "-" Entonces
                        verificar <- 1;
                    FinSi
                FinPara
            FinPara
            Si verificar = 0 Entonces
                Escribir "_______________________________________________";
                Escribir "¡Has encontrado todos los hongos!";
                Escribir "¡GANASTE!"; retirada <- "s";
                Esperar Tecla;
            FinSi
            
            Limpiar Pantalla;
            
            Escribir "---------------------------------";
            Escribir "       1   2   3   4   5   6    ";
            
            Escribir 1,"    | ",fan[1,1]," | ",fan[1,2]," | ",fan[1,3]," | ",fan[1,4]," | ",fan[1,5]," | ",fan[1,6]," | ";
            Escribir 2,"    | ",fan[2,1]," | ",fan[2,2]," | ",fan[2,3]," | ",fan[2,4]," | ",fan[2,5]," | ",fan[2,6]," |      *Marcar Hongo Presione [10]";
            Escribir 3,"    | ",fan[3,1]," | ",fan[3,2]," | ",fan[3,3]," | ",fan[3,4]," | ",fan[3,5]," | ",fan[3,6]," |        Después tecla [enter]";
            Escribir 4,"    | ",fan[4,1]," | ",fan[4,2]," | ",fan[4,3]," | ",fan[4,4]," | ",fan[4,5]," | ",fan[4,6]," |      *Retirada presione [11]";
            Escribir 5,"    | ",fan[5,1]," | ",fan[5,2]," | ",fan[5,3]," | ",fan[5,4]," | ",fan[5,5]," | ",fan[5,6]," |        Después tecla [enter]";
            Escribir 6,"    | ",fan[6,1]," | ",fan[6,2]," | ",fan[6,3]," | ",fan[6,4]," | ",fan[6,5]," | ",fan[6,6]," | ";
            Escribir "**********************************";
            Escribir "***** PARA JUGAR INGRESÁ LAS COORDENADAS (X primero, Y segundo) *****";
            
            Escribir "Coordenada en  X";
            Leer varX;
            Escribir "Coordenada en  Y";
            Leer varY;
            
            Si varX >= 1 Y varY >= 1 Y varX <= 7 Y varY <= 7 Entonces
                mina_pisada <- num[varY,varX];
                
                Si mina_pisada <> "X" Entonces
                    
                    Repetir                    
                        busX <- varX;
                        busY <- varY;
                        Segun op Hacer
                            1:
                                busX <- busX - 1;
                            2:
                                busX <- busX - 1; busY <- busY - 1;
                            3:
                                busY <- busY - 1;
                            4:
                                busX <- busX + 1; busY <- busY - 1;
                            5:
                                busX <- busX + 1;
                            6:
                                busX <- busX + 1; busY <- busY + 1;
                            7:
                                busY <- busY + 1;
                            8:
                                busX <- busX - 1; busY <- busY + 1;
                            De Otro Modo:
                                Escribir "Error: Terminando escaneo Hongos";
                        FinSegun
                        op <- op + 1;
                        Si num[busY,busX] = 'X' Entonces
                            num_minas <- num_minas + 1;
                        FinSi
                        
                    Hasta Que op = 9
                    num_minas_car <- ConvertirATexto(num_minas);
                    fan[varY,varX] <- num_minas_car;
                    op <- 1; num_minas <- 0;
                Sino
                    Limpiar Pantalla;
                    Escribir "       1   2   3   4   5   6   ";
                    Para j <- 1 Hasta 6 Hacer
                        Escribir j,"     | ",num[j,1]," | ",num[j,2]," | ",num[j,3]," | ",num[j,4]," | ",num[j,5]," | ",num[j,6]," | ";
                    FinPara
                    
                    Escribir "*************************************";
                    Escribir "HAS PISADO UN HONGO Amanita phalloides, ¡ES MORTAL!";
                    Escribir "GAME OVER";
                    Escribir "YOU DEAD, in game!!!";
                    Esperar Tecla;
                    retirada <- "s";
                FinSi
            Sino Si varX = 11 O varY = 11 Entonces
                    Escribir "¿Estás seguro que quieres retirarte del Juego?[S/N]";
                    Leer retirada;
                Sino Si varX = 10 O varY = 10 Entonces
                        Escribir "Digite coordenada X de hongo que desea marcar";
                        Leer marX;
                        Escribir "Digite coordenada Y de hongo que desea marcar";
                        Leer marY;
                        fan[marY,marX] <- "?";
                    FinSi
					
                FinSi
                
            FinSi
            
        Hasta Que retirada = 's' O retirada = 'S'
        retirada <- '';
        juegoHongos <- Falso;
    Hasta Que juegoHongos = Falso;
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
    Para i <- 1 Hasta longMensaje Hacer
        techo <- Concatenar(techo, "-");
        piso <- Concatenar(piso, "_");
    FinPara
    techo <- Concatenar(techo, "-|");
    piso <- Concatenar(piso, "_|");
    
    Escribir techo;
    Para i <- 0 Hasta Longitud(mensaje) - 1 Con Paso longMensaje Hacer
        palabras <- Subcadena(mensaje, i, i + longMensaje - 1);
        escrituraMensaje(Subcadena(palabras, 0, longMensaje - 1), longMensaje);
    FinPara
    Escribir piso;
FinSubProceso

//Imprime los mensajes ingresados dentro de un recuadro
//Los mensajes se ajustarán a la cantidad de caracteres indicadas en longMensaje
//Si el mensaje es mas largo que esto, se recortará
SubProceso mostrarMensajes(mensajes, cantidad)
    Definir longMensaje, i Como Entero;
    Definir techo, piso, palabras Como Caracter;
    
    longMensaje <- 38;
    
    techo <- "|-";
    piso <- "|_";
    Para i <- 1 Hasta longMensaje Hacer
        techo <- Concatenar(techo, "-");
        piso <- Concatenar(piso, "_");
    FinPara
    techo <- Concatenar(techo, "-|");
    piso <- Concatenar(piso, "_|");
    
    Escribir techo;
    Para i <- 0 Hasta cantidad - 1 Hacer
        escrituraMensaje(Subcadena(mensajes[i],0,longMensaje), longMensaje);
    FinPara
    Escribir piso;
FinSubProceso

//Escribe el mensaje dentro del recuadro colocando saltos de línea en base al tamaño solicitado
SubProceso escrituraMensaje(mensaje, tamanio)
    Definir i Como Entero;
    
    Para i <- 0 Hasta tamanio - Longitud(mensaje) Hacer
        mensaje <- Concatenar(mensaje, " ");
    FinPara
    
    Escribir Sin Saltar "| ";
    Para i <- 0 Hasta tamanio-1 Hacer
        Escribir Sin Saltar Subcadena(mensaje,i,i);
    FinPara
    Escribir " |";
FinSubProceso

SubProceso mostrarMensaje_ingresarNombre
    Definir mensaje Como Caracter;
    mensaje <- "Ingrese el nombre de su personaje     ";
    mensaje <- Concatenar(mensaje,"para comenzar"                         );
    mostrarMensaje(mensaje);
FinSubProceso

SubProceso mostrarMensaje_accionesMapa(estado)
    Definir mensaje Como Caracter;
    mensaje <- "";
    Si estado = "0001" Entonces
        mensaje <- "¡Opción inválida!                     ";
    SiNo Si estado = "0002" Entonces
            mensaje <- "¡Movimiento Inválido!                 ";
        SiNo Si estado = "0003" Entonces
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

SubProceso mostrarMensaje_menuInicio(estado)
    ilustracionMenu();
    Definir mensaje Como Caracter;
    mensaje <- "";
    Si estado = "0001" Entonces
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

SubProceso poblarLaberinto(tam, laberinto)
    Definir fila, columna Como Entero;
    Definir bloques Como Caracter;
    Dimension bloques(3);
    bloques(0) <- " "; //Espacio en blanco
    bloques(1) <- " "; //Segundo espacio (es necesario porque da 66 porciento de probabilidad de que genere un espacio y hace más rápido el proceso)
    bloques(2) <- "X"; 
    Para fila <- 0 Hasta tam-1 Hacer
        Para columna <- 0 Hasta tam-1 Hacer
            laberinto(fila, columna) <- bloques(Azar(3));
        FinPara
    FinPara
FinSubProceso


SubProceso vecinos <- contarVecinos(fila, columna, tam, laberinto)
    Definir vecinos Como Entero;
    Definir k, ni, nj Como Entero;
    Definir dx Como Entero;
    Definir dy Como Entero;
    Dimension dx(8);
    Dimension dy(8);
    vecinos <- 0;
    
    dx(0) <- -1; dy(0) <- -1;
    dx(1) <- -1; dy(1) <- 0;
    dx(2) <- -1; dy(2) <- 1;
    dx(3) <- 0; dy(3) <- -1;
    dx(4) <- 0; dy(4) <- 1;
    dx(5) <- 1; dy(5) <- -1;
    dx(6) <- 1; dy(6) <- 0;
    dx(7) <- 1; dy(7) <- 1;
    
    Para k <- 0 Hasta 7 Hacer
        ni <- fila + dx(k);
        nj <- columna + dy(k);
        
        // Verificar si el vecino está dentro de los límites
        Si ni >= 1 Y ni <= tam-1 Y nj >= 1 Y nj <= tam-1 Entonces
            Si laberinto(ni, nj) = "X" Entonces
                vecinos <- vecinos + 1;
            FinSi
        FinSi
    FinPara
FinSubProceso

SubProceso poblarLaberintoEnemigos(tam, laberinto)
    Definir fila, columna Como Entero;
    Definir contadorE Como Entero;
    Definir posicionFila, posicionColumna Como Entero;
    contadorE <- 0;
    
    Mientras contadorE < 20 Hacer
        posicionFila <- Azar(tam-1); // Genera una fila aleatoria
        posicionColumna <- Azar(tam-1); // Genera una columna aleatoria
        
        Si laberinto(posicionFila, posicionColumna) = " " Entonces
            laberinto(posicionFila, posicionColumna) <- "E";
            contadorE <- contadorE + 1;
        FinSi
    FinMientras
FinSubProceso

SubProceso aplicarReglas(tam, laberinto) 
    Definir fila, columna Como Entero;
    
    // Reglas 4-5
    Para fila <- 1 Hasta tam-1 Hacer
        Para columna <- 1 Hasta tam-1 Hacer
            Si laberinto(fila, columna) = "X" y contarVecinos(fila, columna, tam, laberinto) >= 4 o laberinto(fila, columna) = " " y contarVecinos(fila, columna, tam, laberinto) >= 5 Entonces
                laberinto(fila, columna) <- "X";
            FinSi
        FinPara
    FinPara
    
    // Punto de entrada y de salida
    laberinto(0,0) <- "C";
    laberinto(tam-1,tam-1) <- "[";
FinSubProceso

SubProceso conectado <- esConectado(tam, laberinto)
    Definir visitado Como Logico;
    Dimension visitado(20, 20);
    Definir fila, columna Como Entero;
    Definir conectado Como Logico;
    
    // Inicializar el arreglo de visitados
    Para fila <- 0 Hasta tam-1 Hacer
        Para columna <- 0 Hasta tam-1 Hacer
            visitado(fila, columna) <- Falso;
        FinPara
    FinPara
    
    // Inicializar DFS desde la entrada
    conectado <- DFS(0, 0, tam, laberinto, visitado);
FinSubProceso

SubProceso encontrado <- DFS(fila, columna, tam, laberinto, visitado)
    Definir dx, dy, nx, ny, k Como Entero;
    Dimension dx(4);
    Dimension dy(4);
    Definir encontrado Como Logico;
    
    // Movimientos posibles (derecha, abajo, izquierda, arriba)
    dx(0) <- 1; dy(0) <- 0;
    dx(1) <- 0; dy(1) <- 1;
    dx(2) <- -1; dy(2) <- 0;
    dx(3) <- 0; dy(3) <- -1;
    
    // Si se llega a la salida
    Si fila = tam-1 Y columna = tam-1 Entonces
        encontrado <- Verdadero;
    Sino
        // Marcar como visitado
        visitado(fila, columna) <- Verdadero;
        encontrado <- Falso;
        
        // Probar cada movimiento posible
        Para k <- 0 Hasta 3 Hacer
            nx <- fila + dx(k);
            ny <- columna + dy(k);
            
            // Verificar si el siguiente paso es válido
            Si nx >= 0 Y nx < tam Y ny >= 0 Y ny < tam Y no visitado(nx, ny) Y laberinto(nx, ny) <> "X" Entonces
                encontrado <- DFS(nx, ny, tam, laberinto, visitado);
                Si encontrado Entonces
                    k <- 4; // Salir del bucle para evitar seguir buscando
                FinSi
            FinSi
        FinPara
    FinSi
FinSubProceso
