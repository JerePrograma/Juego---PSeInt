//----------------------------------------------------
//------------------   CONSTANTES   ------------------
//----------------------------------------------------

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


//----------------------------------------------------
//---------------------  INICIO  ---------------------
//----------------------------------------------------

Proceso Principal
    Definir opcionMenu Como Entero;
    Definir estadoMenu Como Caracter;
    
    // Declaración de matrices globales para enemigos
    Definir vidaEnemigos, fuerzaEnemigos, defensaEnemigos, agilidadEnemigos, inteligenciaEnemigos Como Entero;
    Dimension vidaEnemigos(20, 20);
    Dimension fuerzaEnemigos(20, 20);
    Dimension defensaEnemigos(20, 20);
    Dimension agilidadEnemigos(20, 20);
    Dimension inteligenciaEnemigos(20, 20);
	
    estadoMenu <- "0000";
    Repetir
        mostrarMensaje_menuInicio(estadoMenu);
        Leer opcionMenu;
        Limpiar Pantalla;
        Segun opcionMenu Hacer
            1: // INICIAR JUEGO
                juego(vidaEnemigos, fuerzaEnemigos, defensaEnemigos, agilidadEnemigos, inteligenciaEnemigos);
                
            2: // SALIR
                Escribir "Saliste sape";
                
            De Otro Modo: // TECLA INCORRECTA
                estadoMenu <- "0001";
        FinSegun
        
    Hasta que opcionMenu = 2;
    
FinProceso

//----------------------------------------------------
//---------------------   JUEGO   --------------------
//----------------------------------------------------

SubProceso juego(vidaEnemigos, fuerzaEnemigos, defensaEnemigos, agilidadEnemigos, inteligenciaEnemigos)
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
    colocarEnemigosAleatorios(tamLaberinto, laberinto, estadoOriginal, vidaEnemigos, fuerzaEnemigos, defensaEnemigos, agilidadEnemigos, inteligenciaEnemigos, 3); // Colocar 3 enemigos aleatorios
    
    // Mostrar el laberinto
    mostrarLaberinto(tamLaberinto, laberinto);
    
    creacionPersonaje(nombre, vida, experiencia, fuerza, defensa, agilidad, inteligencia, nivel, estado);
    seguimiento(nombre, vida, experiencia, fuerza, defensa, agilidad, inteligencia, nivel, estado, tamLaberinto, laberinto, estadoOriginal, vidaEnemigos, fuerzaEnemigos, defensaEnemigos, agilidadEnemigos, inteligenciaEnemigos);
FinSubProceso


//----------------------------------------------------
//-------------  INICIALIZAR LABERINTO  --------------
//----------------------------------------------------

SubProceso inicializarLaberinto(tam, laberinto)
    Definir tamLaberinto Como Entero;
    Definir n Como Entero;
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
    
    poblarLaberintoEnemigos(tamLaberinto, laberinto);
FinSubProceso

SubProceso inicializarEstadoOriginal(tam, laberinto, estadoOriginal)
    Definir fila, columna Como Entero;
    Para fila <- 0 Hasta tam-1 Hacer
        Para columna <- 0 Hasta tam-1 Hacer
            estadoOriginal(fila, columna) <- laberinto(fila, columna);
        FinPara
    FinPara
FinSubProceso

SubProceso colocarEnemigosAleatorios(tam, laberinto, estadoOriginal, vidaEnemigos, fuerzaEnemigos, defensaEnemigos, agilidadEnemigos, inteligenciaEnemigos, cantidadEnemigos)
    Definir enemigoPosX, enemigoPosY Como Entero;
    Definir contador Como Entero;
    contador <- 0;
    Mientras contador < cantidadEnemigos Hacer
        enemigoPosX <- lanzarDado(0, tam-1);
        enemigoPosY <- lanzarDado(0, tam-1);
        Si laberinto(enemigoPosX, enemigoPosY) = " " Entonces
            laberinto(enemigoPosX, enemigoPosY) <- "E";
            estadoOriginal(enemigoPosX, enemigoPosY) <- " "; // Actualizar el estadoOriginal con un espacio
            contador <- contador + 1;
        FinSi
    FinMientras
FinSubProceso


//----------------------------------------------------
//---------------  CREACION PERSONAJE  ---------------
//----------------------------------------------------

SubProceso creacionPersonaje(nombre Por Referencia, vida Por Referencia, experiencia Por Referencia, fuerza Por Referencia, defensa Por Referencia, agilidad Por Referencia, inteligencia Por Referencia, nivel Por Referencia, estado Por Referencia)
    mostrarMensaje_ingresarNombre();
    Leer nombre;
    inicializarEstadisticas(nombre, vida, experiencia, fuerza, defensa, agilidad, inteligencia, nivel, estado);
    mostrarMensaje_estadisticasPersonaje(nombre, vida, experiencia, fuerza, defensa, agilidad, inteligencia, nivel, estado);
	animacionPersonaje;
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

//----------------------------------------------------
//--------------------  EJECUCION  -------------------
//----------------------------------------------------

SubProceso seguimiento(nombre Por Referencia, vida Por Referencia, experiencia Por Referencia, fuerza Por Referencia, defensa Por Referencia, agilidad Por Referencia, inteligencia Por Referencia, nivel Por Referencia, estado Por Referencia, tam, laberinto, estadoOriginal, vidaEnemigos, fuerzaEnemigos, defensaEnemigos, agilidadEnemigos, inteligenciaEnemigos)
    Definir posX, posY, posXNueva, posYNueva Como Entero;
    Definir simboloJugador, estadoAccion Como Caracter;
    Definir juegoActivo Como Logico;
    simboloJugador <- "J";
    juegoActivo <- Verdadero;
    estadoAccion <- "0000";
    
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
        Sino
            Si estadoAccion = "0004" Entonces
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
    Sino Si eleccionLetra = "s" Entonces
            eleccionNumero <- 2;
        Sino Si eleccionLetra = "d" Entonces
                eleccionNumero <- 3;
            Sino Si eleccionLetra = "w" Entonces
                    eleccionNumero <- 4;
                Sino Si eleccionLetra = "e" Entonces
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
                    estadoAccion <- "0000";
                Sino
                    estadoAccion <- "0003";
                FinSi
            Sino
                estadoAccion <- "0002";
            FinSi
        2:  // Abajo
            Si posX < tam - 1 Entonces
                Si laberinto(posX + 1, posY) <> "X" Entonces
                    posXNueva <- posX + 1;
                    estadoAccion <- "0000";
                Sino
                    estadoAccion <- "0003";
                FinSi
            Sino
                estadoAccion <- "0002";
            FinSi
        3:  // Derecha
            Si posY < tam - 1 Entonces
                Si laberinto(posX, posY + 1) <> "X" Entonces
                    posYNueva <- posY + 1;
                    estadoAccion <- "0000";
                Sino
                    estadoAccion <- "0003";
                FinSi
            Sino
                estadoAccion <- "0002";
            FinSi
        4:  // Arriba
            Si posX > 0 Entonces
                Si laberinto(posX - 1, posY) <> "X" Entonces
                    posXNueva <- posX - 1;
                    estadoAccion <- "0000";
                Sino
                    estadoAccion <- "0003";
                FinSi
            Sino
                estadoAccion <- "0002";
            FinSi
        5:
            estadoAccion <- "0004";
        De Otro Modo:
            estadoAccion <- "0001";
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
            pelea();
            laberinto(posX, posY) <- estadoOriginal(posX, posY); // Actualizar la posición anterior del jugador
            laberinto(posXNueva, posYNueva) <- simboloJugador; // Mover el jugador a la nueva posición
            estadoOriginal(posXNueva, posYNueva) <- " "; // Actualizar estadoOriginal
        Sino
            Si laberinto(posXNueva, posYNueva) = "[" Entonces
                BuscaHongos();
                mostrarMensaje("¡Llegaste, descansa en esta hoguera guerrero!");
                juegoActivo <- Falso;
            Sino
                laberinto(posX, posY) <- estadoOriginal(posX, posY); // Actualizar la posición anterior del jugador
                laberinto(posXNueva, posYNueva) <- simboloJugador; // Mover el jugador a la nueva posición
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
    Definir vidaEnemigo, fuerzaEnemigo, defensaEnemigo, agilidadEnemigo, inteligenciaEnemigo Como Entero;
	
    // Obtener las características del enemigo
    inicializarEnemigo(vidaEnemigo, fuerzaEnemigo, defensaEnemigo, agilidadEnemigo, inteligenciaEnemigo);
    
    // Simulación del combate (aquí puedes agregar la lógica del combate)
    Escribir "Vida del enemigo: ", vidaEnemigo;
    
    // Aquí agregar la lógica del combate
    Esperar 1 Segundos;
	vidaEnemigo <- 0;
    Si vidaEnemigo <= 0 Entonces
        Escribir "¡Has derrotado al enemigo!";
		Esperar 1 Segundos;
    FinSi
FinSubProceso


SubProceso inicializarEnemigo(vidaEnemigo Por Referencia, fuerzaEnemigo Por Referencia, defensaEnemigo Por Referencia, agilidadEnemigo Por Referencia, inteligenciaEnemigo Por Referencia)
    vidaEnemigo <- 10 + Aleatorio(0, 10);
    fuerzaEnemigo <- Aleatorio(1, 5);
    defensaEnemigo <- Aleatorio(1, 5);
    agilidadEnemigo <- Aleatorio(1, 5);
    inteligenciaEnemigo <- Aleatorio(1, 5);
FinSubProceso




//----------------------------------------------------
//-------------------   PANTALLA   -------------------
//----------------------------------------------------

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
//Los mensajes se ajustarán a la cantidad de caracteres indicadas en longMensaje
//Si el mensaje es mas largo que esto, se recortará
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

//Escribe el mensaje dentro del recuadro colocando saltos de linea en base al tamaño solicitado
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
    Si estado = "0001" Entonces
        mensaje <- "¡Opción inválida!                     ";
    Sino Si estado = "0002" Entonces
            mensaje <- "¡Movimiento Inválido!                 ";
        Sino Si estado = "0003" Entonces
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
    Escribir "USE PANTALLA COMPLETA PARA UNA MEJOR EXPERIENCIA";
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
    Definir dx, dy Como Entero;
    Definir nx, ny Como Entero;
    Definir k Como Entero;
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

SubProceso BuscaHongos
	
	Dimension num[9,9];Dimension fan[9,9];
	Definir num,fan,mina_pisada,num_minas_car, opcion_letra como caracter;
	Definir salir,retirada como caracter;
	Definir num_minas,op,fil,col,i,j,xe,ye,verificar,varX,varY,busX,busY,marX,marY,nivel,opc, cantidadMuertes como Entero;
	Definir juegoHongos Como Logico;
	juegoHongos <- Verdadero;
	retirada<-'';
	cantidadMuertes <- 0;
	Repetir
		limpiar pantalla;
		Escribir "********************************************************************";
		Escribir "********************************************************************";
		Escribir "************     BUSCA HONGOS DEL REINO OLVIDADO      **************";	
		Escribir "************ FELICIDADES JUGADOR, SUPERASTE ESTE MAPA **************";
		Escribir "***  PARA PASAR AL PRÓXIMO DEBERÁS PASAR POR UN CAMPO DE HONGOS  ***";
		Escribir "************** PRESIONE CUALQUIER TECLA PARA CONTINUAR **************";
		Escribir "********************************************************************";
		Leer opcion_letra;
		
		
		Repetir
			limpiar pantalla;
			Escribir "**************  NIVEL    ";
			Escribir "**************  1. FACIL [5 hongos]  ";
			Escribir "**************  2. INTERMEDIO [10 hongos]    ";
			Escribir "**************  3. DIFICIL  [15 hongos]  ";
			Leer opc;
			Segun opc Hacer
				1:
					nivel<-5;
				2:
					nivel<-10;
				3:
					nivel<-15;
				De Otro Modo:
					Escribir "Opcion no valida";
			FinSegun
		Hasta Que opc>=1 y opc<=3
		
		num_minas<-0;
		op<-1;
		para fil<-0 hasta 7 con paso 1 hacer
			Para col<-0 Hasta 7 Con Paso 1 Hacer
				num[fil,col]<-"-";
				fan[fil,col]<-"-";
			FinPara
		finpara
		
		//UBICACION DE HONGOS AL AZAR
		Para i<-1 Hasta nivel Con Paso 1 Hacer
			xe <- azar(6)+1;
			ye <- azar(6)+1;
			si num[xe,ye]="-" entonces
				num[xe,ye]<-"X";
			Sino
				i<-i-1;
			finsi
		FinPara
		
		Repetir					
			//VERIFICAR SI HAY HONGOS
			verificar<-0;
			para fil<-1 hasta 7 con paso 1 hacer
				Para col<-1 Hasta 7 Con Paso 1 Hacer
					si fan[fil,col]="-" Entonces
						verificar<-1;
					FinSi
				FinPara
			finpara
			si verificar=0 entonces
				Escribir "_______________________________________________";
				Escribir "Has encontrado todas los hongos!!";
				Escribir "GANASTE!!"; retirada <- "s";
				Esperar Tecla;
			FinSi
			
			LimpiarPantalla;
			
			Escribir "---------------------------------";
			Escribir "       1   2   3   4   5   6    ";
			
			Escribir 1,"    | ",fan[1,1]," | ",fan[1,2]," | ",fan[1,3]," | ",fan[1,4]," | ",fan[1,5]," | ",fan[1,6]," | ";
			Escribir 2,"    | ",fan[2,1]," | ",fan[2,2]," | ",fan[2,3]," | ",fan[2,4]," | ",fan[2,5]," | ",fan[2,6]," |      *Marcar Hongo Presione [10]";
			Escribir 3,"    | ",fan[3,1]," | ",fan[3,2]," | ",fan[3,3]," | ",fan[3,4]," | ",fan[3,5]," | ",fan[3,6]," |        Despues tecla [enter]";
			Escribir 4,"    | ",fan[4,1]," | ",fan[4,2]," | ",fan[4,3]," | ",fan[4,4]," | ",fan[4,5]," | ",fan[4,6]," |      *Retirada presione [11]";
			Escribir 5,"    | ",fan[5,1]," | ",fan[5,2]," | ",fan[5,3]," | ",fan[5,4]," | ",fan[5,5]," | ",fan[5,6]," |        Despues tecla [enter]";
			Escribir 6,"    | ",fan[6,1]," | ",fan[6,2]," | ",fan[6,3]," | ",fan[6,4]," | ",fan[6,5]," | ",fan[6,6]," | ";
			//Escribir 7,"    | ",fan[7,1]," | ",fan[7,2]," | ",fan[7,3]," | ",fan[7,4]," | ",fan[7,5]," | ",fan[7,6]," | ",fan[7,7]," | ";
			Escribir "**********************************";
			Escribir "***** PARA JUGAR INGRESÁ LAS COORDENADAS (X primero, Y segundo) *****";
			
			Escribir "Coordenada en  X";
			Leer varX;
			Escribir "Coordenada en  Y";
			Leer varY;
			
			si varX>=1 y varY>=1 y varX<=7 y varY<=7 entonces
				mina_pisada<-num[varY,varX];
				
				si !mina_pisada="X" entonces
					
					Repetir					
						busX<-varX;
						busY<-varY;
						Segun op Hacer
							1:
								busX<-busX-1;
							2:
								busX<-busX-1;busY<-busY-1;
							3:
								busY<-busY-1;
							4:
								busX<-busX+1;busY<-busY-1;
							5:
								busX<-busX+1;
							6:
								busX<-busX+1;busY<-busY+1;
							7:
								busY<-busY+1;
							8:
								busX<-busX-1;busY<-busY+1;
							De Otro Modo:
								Escribir "Error: Terminando escaneo Hongos";
						FinSegun
						op<-op+1;
						si num[busY,busX]='X' Entonces
							num_minas <- num_minas+1;
						FinSi
						
						
					Hasta Que op=9
					num_minas_car<-ConvertirATexto(num_minas);
					fan[varY,varX]<- num_minas_car;
					op<-1;num_minas<-0;
				Sino
					LimpiarPantalla;
					Escribir "       1   2   3   4   5   6   ";
					para j<-1 hasta 6 con paso 1 hacer
						Escribir j,"     | ",num[j,1]," | ",num[j,2]," | ",num[j,3]," | ",num[j,4]," | ",num[j,5]," | ",num[j,6]," | ";
					FinPara
					
					Escribir "*************************************";
					Escribir "HAS PISADO UN HONGO Amanita phalloides, SI ES MORTAL !!";
					Escribir "*************************************";
					
					cantidadMuertes <- cantidadMuertes +1;
					Si cantidadMuertes < 3 Entonces
						Escribir "El dios todo benevolente de este universo te dió otra oportunidad, no la desaproveches";
					SiNo
						Escribir "Haz muerto horriblemente por el veneno acumulado de los hongos";
						retirada<-"s";
					FinSi
					esperar tecla;
				FinSi
			Sino si varX=11 o varY=11 entonces
					Escribir "¿Estas seguro que quieres retirarte del Juego?[S/N]";
					leer retirada;
					Si retirada='s' o retirada='S' Entonces
						Escribir "*************************************";
						Escribir "Eres un cobarde";
						Escribir "*************************************";
						Esperar 3 Segundos;
					FinSi
				Sino si	varX=10 o varY=10 entonces
						Escribir "Digite cordenada X de hongo que desea marcar";
						Leer marX;
						Escribir "Digite cordenada Y de hongo que desea marcar";
						Leer marY;
						fan[marY,marX]<-"?";
					FinSi
					
				FinSi
				
			FinSi
			
		Hasta Que retirada='s' o retirada='S'
		retirada<-'';
		juegoHongos <- Falso;
	Hasta Que juegoHongos = Falso;
	animacionCierre;
FinSubProceso

SubProceso alea <- lanzarDadoAnimacion
	
    Definir i, j, altura, contador, alea Como Entero;
    Definir cubo1, cubo2, cubo3 Como Caracter;
    Definir cubox1, cubox2, cubox3, cubox4, cubox5, cubox6 Como Caracter;
    Dimension cubo1[8], cubo2[8], cubo3[8];
    Dimension cubox1[8], cubox2[8], cubox3[8], cubox4[8], cubox5[8], cubox6[8];
	
    // Definición del primer cubo
    cubo1[1] <- "         ______ ";
    cubo1[2] <- "        /     /\\";
    cubo1[3] <- "       /  0  /  \\";
    cubo1[4] <- "      /_____/  0 \\";
    cubo1[5] <- "      \\ 0 0 \\ 0  /";
    cubo1[6] <- "       \\ 0 0 \\  /";
    cubo1[7] <- "        \\_____\\/";
    
    // Definición del segundo cubo
    cubo2[1] <- "   _______";
    cubo2[2] <- "  /\\ o o o\\";
    cubo2[3] <- " /o \\ o o o\\";
    cubo2[4] <- "<    >------>";
    cubo2[5] <- " \\ o/  o   /";
    cubo2[6] <- "  \\/______/";
    cubo2[7] <- "";
    
    // Definición del tercer cubo
    cubo3[1] <- "  _______";
    cubo3[2] <- " | o   o |\\";
    cubo3[3] <- " |   o   |o \\";
    cubo3[4] <- " | o   o |o |";
    cubo3[5] <- " |_______|o |";
    cubo3[6] <- " \\  o   \\ |";
    cubo3[7] <- "  \\______\\|";
	
    // Definición de las caras del dado
    // Cara 1
    cubox1[1] <- "  _______";
    cubox1[2] <- " |       |\\";
    cubox1[3] <- " |   O   |o\\ ";
    cubox1[4] <- " |       | o|";
    cubox1[5] <- " |_______|o |";
    cubox1[6] <- " \\  o o \\ |";
    cubox1[7] <- "  \\______\\|";
    // Cara 2
    cubox2[1] <- "  _______";
    cubox2[2] <- " |       |\\";
    cubox2[3] <- " |  o  o |o\\ ";
    cubox2[4] <- " |       | o|";
    cubox2[5] <- " |_______|o |";
    cubox2[6] <- " \\   o  \\ |";
    cubox2[7] <- "  \\______\\|";
    // Cara 3
    cubox3[1] <- "  _______";
    cubox3[2] <- " |  o    |\\";
    cubox3[3] <- " |    o  | \\ ";
    cubox3[4] <- " |  o    |oo|";
    cubox3[5] <- " |_______|oo|";
    cubox3[6] <- " \\  o o \\ |";
    cubox3[7] <- "  \\______\\|";
    // Cara 4
    cubox4[1] <- "  _______";
    cubox4[2] <- " |  o o  |\\";
    cubox4[3] <- " |       | \\ ";
    cubox4[4] <- " |  o o  |oo|";
    cubox4[5] <- " |_______|o |";
    cubox4[6] <- " \\  o o \\o|";
    cubox4[7] <- "  \\______\\|";
    // Cara 5
    cubox5[1] <- "  _______";
    cubox5[2] <- " |  o  o |\\";
    cubox5[3] <- " |   o   | \\ ";
    cubox5[4] <- " |  o  o |o |";
    cubox5[5] <- " |_______|o |";
    cubox5[6] <- " \\   o  \\ |";
    cubox5[7] <- "  \\______\\|";
    // Cara 6
    cubox6[1] <- "  _______";
    cubox6[2] <- " | o  o  |\\";
    cubox6[3] <- " | o  o  | \\ ";
    cubox6[4] <- " | o  o  | o|";
    cubox6[5] <- " |_______|o |";
    cubox6[6] <- " \\ o o  \\o|";
    cubox6[7] <- "  \\______\\|";
    
    // Inicio de la simulación
    alea <- lanzarDado(1,6);
    
    Escribir "Presione Enter para lanzar el dado, veamos tu suerte!!!...";
    Leer altura; // Simula la presión de un botón
    
    contador <- 0 ;// Contador para alternar entre cubos
    
    // Movimiento del dado hacia abajo y arriba
    Para altura <- 0 Hasta 10 Con Paso 1 Hacer
        Borrar Pantalla;
        Para i <- 0 Hasta altura Hacer
            Escribir "";
        FinPara
        Segun contador mod 3 Hacer
            Caso 0:
                Para j <- 1 Hasta 7 Hacer
                    Escribir cubo1[j];
                FinPara
            Caso 1:
                Para j <- 1 Hasta 7 Hacer
                    Escribir cubo2[j];
                FinPara
            Caso 2:
                Para j <- 1 Hasta 7 Hacer
                    Escribir cubo3[j];
                FinPara
        FinSegun
        Esperar 50 Milisegundos; // Ajusta la velocidad del salto
        contador <- contador + 1;
    FinPara
    
    Para altura <- 10 Hasta 0 Con Paso -1 Hacer
        Borrar Pantalla;
        Para i <- 0 Hasta altura Hacer
            Escribir "";
        FinPara
        Segun contador mod 3 Hacer
            Caso 0:
                Para j <- 1 Hasta 7 Hacer
                    Escribir cubo1[j];
                FinPara
            Caso 1:
                Para j <- 1 Hasta 7 Hacer
                    Escribir cubo2[j];
                FinPara
            Caso 2:
                Para j <- 1 Hasta 7 Hacer
                    Escribir cubo3[j];
                FinPara
        FinSegun
		Si altura < 9 Entonces
			Esperar 100 Milisegundos; // Ajusta la velocidad del salto
		SiNo
			Esperar 200 Milisegundos;
		FinSi
        
        contador <- contador + 1;
    FinPara
    
    // Mostrar el resultado del dado
    Borrar Pantalla;
    Segun alea Hacer
        Caso 1:
            Para j <- 1 Hasta 7 Hacer
                Escribir cubox1[j];
            FinPara
        Caso 2:
            Para j <- 1 Hasta 7 Hacer
                Escribir cubox2[j];
            FinPara
        Caso 3:
            Para j <- 1 Hasta 7 Hacer
                Escribir cubox3[j];
            FinPara
        Caso 4:
            Para j <- 1 Hasta 7 Hacer
                Escribir cubox4[j];
            FinPara
        Caso 5:
            Para j <- 1 Hasta 7 Hacer
                Escribir cubox5[j];
            FinPara
        Caso 6:
            Para j <- 1 Hasta 7 Hacer
                Escribir cubox6[j];
            FinPara
    FinSegun
    
	Escribir "Magicamente el dado a salido en ", alea;
    Escribir "La suerte te sonrie!!! por ahora.";
	
FinSubProceso

SubProceso animacionCierre
    Definir i, j, altura, contador Como Entero;
    Definir dragon Como Caracter;
    Dimension dragon[40]; 
	
    dragon[0] <- "                         /\\";
    dragon[1] <- "                         ||";
    dragon[2] <- "                         ||";
    dragon[3] <- "                         ||";
    dragon[4] <- "                         ||                                               ~-----~";
    dragon[5] <- "                         ||                                            /===--  ---~~~";
    dragon[6] <- "                         ||                                      /==~- --   -    ---~~~";
    dragon[7] <- "                         ||                (/ (               /=----         ~~_  --(   ";
    dragon[8] <- "                         ||               / ;              /=----               \\__~";
    dragon[9] <- "                       ~==_=~           (              ~-~~      ~~~~        ~~~--\\~ ";
    dragon[10] <- "      \\                (c_\\_        .I.             /~--    ~~~--   -~     (";
    dragon[11] <- "       `\\               (}| /       / : \\           / ~~------~     ~~\\   (";
    dragon[12] <- "       \\                 |/ \\      |===|          /~/             ~~~ \\ \\(";
    dragon[13] <- "      ``~\\              ~~\\  )~.~_ >._.< _~-~     |`_          ~~-~     )\\";
    dragon[14] <- "        -~                 {  /  ) \\___/ (   \\   |    _       ~~         ";
    dragon[15] <- "       \\ -~\\                -<__/  -   -  L~ -;   \\\\    \\ _ _/";
    dragon[16] <- "       `` ~~=\\                  {    :    }\\ ,\\    ||   _ :(";
    dragon[17] <- "        \\  ~~=\\__                \\ _/ \\_ /  )  } _//   ( `| ";
    dragon[18] <- "        ``    , ~\\--~=\\           \\     /  / _/ /      (   ";
    dragon[19] <- "         \\`    } ~ ~~ -~=\\   _~_  / \\ / \\ )^ ( // :_  /                                     GRACIAS POR JUGAR!!!!";
    dragon[20] <- "         |    ,          _~-     ~~__-_  / - |/     \\ (";
    dragon[21] <- "         \\  ,_--_     _/              \\_ --- , -~ .   \\";
    dragon[22] <- "           )/      /\\ / /\\   ,~,         \\__ _}     \\_   ~_                                 El código de Da Vinci";
    dragon[23] <- "           ,      { ( _ ) } ~ - \\_    ~\\  (-:-)        \\   ~";
    dragon[24] <- "                  / O  O  )~ \\~_ ~\\   )->  \\ :|    _,       }";
    dragon[25] <- "                 (\\  _/)  } | \\~_ ~  /~(   | :)   /          }";
    dragon[26] <- "                <``  >;,,/  )= \\~__ {{{    \\ =(  ,   ,       ";
    dragon[27] <- "               {o_o }_/     |v   ~__  _    )-v|     :       ,";
    dragon[28] <- "               {/ \\_)       {_/   \\~__ ~\\_ \\\\_}    {        /~\\";
    dragon[29] <- "               ,/!           _/     ~__ _-~ \\_  :         ,   ~ ";
    dragon[30] <- "              (  )                   /, ~___~    | /     ,   \\ ~";
    dragon[31] <- "              /, )                 (-)   ~____~ ;     ,      , }";
    dragon[32] <- "           /, )                    / \\         /  ,~-        ~";
    dragon[33] <- "     (    /                     / (         /  /           ~";
    dragon[34] <- "    ~ ~  ,, /) ,                 (/( \\)      ( -)          /~";
    dragon[35] <- "  (  ~~ )`  ~}                      \\)      _/ /           ~";
    dragon[36] <- " { |) /`,--.(  }                           (  /          /~";
    dragon[37] <- "(` ~ ( c|~~| `}   )                         /:\\         ,";
    dragon[38] <- " ~ )/  ) ))  |),                          (/ | \\)";
    dragon[39] <- "  (` (-~(( `~`   )                          (/ ";
	
    contador <- 0;
	
    // Movimiento del dragón hacia arriba
    Para altura <- 39 Hasta 0 Con Paso -1 Hacer
        Borrar Pantalla;
        // Espacios iniciales para mover el dragón hacia arriba
        espacios(altura);
        // Mostrar solo parte visible del dragón (líneas 0 a 25)
        Para j <- 0 Hasta 39 Hacer
            Si j + altura < 40 Entonces
                Escribir dragon[j + altura];
            FinSi
        FinPara
        // Esperar un poco antes de la siguiente iteración
        Esperar 200 Milisegundos;
        contador <- contador + 1;
    FinPara
	Escribir "----------------------------------------------------------------";
	Escribir "-------- PRESIONE CUALQUIER TECLA PARA EMPEZAR DE NUEVO --------";
	Escribir "----------------------------------------------------------------";
	Esperar Tecla;
FinSubProceso

SubProceso espacios(x)
    Definir i Como Entero;
    Para i <- 0 Hasta x-1 Hacer
        Escribir Sin Saltar " ";
    FinPara
FinSubProceso

SubProceso animacionPersonaje
    Definir pj, arbol,arbol1 Como Caracter;
    Definir i, j Como Entero;
    
    Escribir "Presione una tecla para iniciar la partida";
    Esperar Tecla;
    Dimension arbol1[10];
    Dimension pj[12];
    
    pj[0] <- "   ==(W{==========- ";
    pj[1] <- "     ||  (.--.)    ";
    pj[2] <- "     | \_,|**|,__  |";
    pj[3] <- "      \    --    ),";
    pj[4] <- "      /`\_. .__/\ \ ";
	pj[5] <- "     (   | .  |~~~~|";
	pj[6] <- "     )__/==0==-\<>/";
	pj[7] <- "       /~\___/~~\/ ";
	pj[8] <- "      /-~~   \  | ";
	pj[9] <- "      /-~~   \  | ";
	pj[10] <- "      /|~    | \ ";
	pj[11] <- "      ---     ---";
	
	
    arbol1[0] <- "              v .   ._, |_  .,               v .   ._, |_  .,             v .   ._, |_  .,  "  ;
    arbol1[1] <- "           `-._\/  .  \ /    |/_             `-._\/  .  \ /    |/_        _\_.___\\, \\/ -.\||     "  ;
    arbol1[2] <- "               \\  _\, y | \//                \\  _\, y | \//              `-._\/  .  \ /    |/_  "   ;
    arbol1[3] <- "          _\_.___\\, \\/ -.\||           _\_.___\\, \\/ -.\||             _\_.___\\, \\/ -.\||      "   ;
    arbol1[4] <- "             -,--. ._||  / / ,              -,--. ._||  / / ,                   -,--. ._||  / / ,    ";
	arbol1[5]<-"                /     -. ./ / |/_.                 /     -. ./ / |/_.        /    -. ./ / |/_.        ";
	arbol1[6]<-"                      |    |//                      |    |//                     |    |//            ";
	arbol1[7]<-"                      |_    /                       |_    /                      |_    /           ";
	arbol1[8]<-"                      |-   |                        |-   |                       |-   |             ";
	arbol1[9]<-" --------------------/ ,  . \----------------------/ ,  . \---------------------/ ,  . \---------------       ";
	
    
    Para i <- 0 Hasta 70  CON PASO 1 Hacer // Ajustamos el número de iteraciones para moverse a lo largo de la pantalla
        Borrar Pantalla;
        // Mostrar el personaje y el movimiento
        Para j <- 0 Hasta 11 Con Paso 1 Hacer
            espacios(i);
			Escribir pj[j];
        FinPara
        Para j <- 0 Hasta 9 Hacer
			Escribir arbol1[j];
		FinPara
        
        
        // Esperar un poco antes de pasar a la siguiente iteración
        Esperar 30 Milisegundos;
    FinPara
    Escribir "------------------------------------------------------------------------------------------------------";
	Escribir "COMIENZA LA PARTIDA";
	
    Esperar 3 Segundos;
    Borrar Pantalla;
FinSubProceso