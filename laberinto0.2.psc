Proceso juegoLaberinto
    iniciarJuego();
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
    
    mostrarLaberinto(tam, laberinto);
    
    seguimiento(tam, laberinto, estadoOriginal);
FinProceso

SubProceso iniciarJuego
    Definir nombre Como Caracter;
    mostrarMensaje("Ingrese el nombre de su personaje para comenzar");
    Leer nombre;
    crearPersonaje(nombre);
FinSubProceso

SubProceso inicializarLaberinto(tam, laberinto)
    Definir fila, columna Como Entero;
    Para fila <- 0 Hasta tam-1 Hacer
        Para columna <- 0 Hasta tam-1 Hacer
            laberinto(fila, columna) <- "[ ]"; // Espacio vacío inicial
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

SubProceso mostrarLaberinto(tam, laberinto)
    Definir fila, columna Como Entero;
    Para fila <- 0 Hasta tam-1 Hacer
        Para columna <- 0 Hasta tam-1 Hacer
            Escribir "[", laberinto(fila, columna), "] " Sin Saltar;
        FinPara
        Escribir " ";
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

SubProceso seguimiento(tam, laberinto, estadoOriginal)
    Definir posX, posY, posXNueva, posYNueva Como Entero;
    Definir simboloJugador Como Caracter;
    simboloJugador <- "J";
    Definir juegoActivo Como Logico;
    juegoActivo <- Verdadero;
    posX <- 0; posY <- 0;  // Asumiendo que el jugador empieza en la esquina superior izquierda
    laberinto(posX, posY) <- simboloJugador;  // Colocamos al jugador en la posición inicial
	
    Mientras juegoActivo Hacer
        mostrarLaberinto(tam, laberinto);
        posXNueva <- posX;  // Preparar las nuevas posiciones
        posYNueva <- posY;
        
        // Obtener la nueva posición basada en la entrada del usuario
        presionar(posX, posY, posXNueva, posYNueva, simboloJugador, laberinto, tam);
		
        // Verificar y actualizar la posición
        Si posXNueva <> posX O posYNueva <> posY Entonces  // Si hay un cambio de posición
            evaluarPosicion(tam, laberinto, estadoOriginal, posXNueva, posYNueva, posX, posY, simboloJugador, juegoActivo);
            Si juegoActivo Entonces
                // Actualizar las posiciones antiguas y nuevas
                posX <- posXNueva;
                posY <- posYNueva;
            FinSi
        FinSi
    FinMientras;
FinSubProceso

SubProceso presionar(posX, posY, posXNueva Por Referencia, posYNueva Por Referencia, simboloJugador, laberinto, tam)
    Definir eleccionLetra, direccion Como Caracter;
    Definir eleccionNumero Como Entero;
    mostrarMensaje("Digite una A S D W para moverse");
    Leer eleccionLetra;
    
    eleccionLetra <- Minusculas(eleccionLetra);
    Si eleccionLetra = "a" Entonces
        eleccionNumero <- 1;
    SiNo
        Si eleccionLetra = "s" Entonces
            eleccionNumero <- 2;
        SiNo
            Si eleccionLetra = "d" Entonces
                eleccionNumero <- 3;
            SiNo 
                Si eleccionLetra = "w" Entonces
                    eleccionNumero <- 4;
                Sino
                    eleccionNumero <- 5; // Invalid
                FinSi
            FinSi
        FinSi
    FinSi
	
    Segun eleccionNumero Hacer
        1:  // Izquierda
            Si posY > 0 Entonces
                Si laberinto(posX, posY - 1) <> "X" Entonces
                    posYNueva <- posY - 1;
                Sino
                    mostrarMensaje("Hay una pared a la izquierda!");
                FinSi
            Sino
                mostrarMensaje("Movimiento inválido hacia la izquierda!");
            FinSi
        2:  // Abajo
            Si posX < tam - 1 Entonces
                Si laberinto(posX + 1, posY) <> "X" Entonces
                    posXNueva <- posX + 1;
                Sino
                    mostrarMensaje("Hay una pared abajo!");
                FinSi
            Sino
                mostrarMensaje("Movimiento inválido hacia abajo!");
            FinSi
        3:  // Derecha
            Si posY < tam - 1 Entonces
                Si laberinto(posX, posY + 1) <> "X" Entonces
                    posYNueva <- posY + 1;
                Sino
                    mostrarMensaje("Hay una pared a la derecha!");
                FinSi
            Sino
                mostrarMensaje("Movimiento inválido hacia la derecha!");
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
        De Otro Modo:
            mostrarMensaje("Tecla inválida. Use A, S, D, W para moverse.");
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

// Función para ajustar un atributo a estar dentro del rango de 0 a 20
Funcion value <- ajustarAtributo(value)
    Si value < 0 Entonces
        value <- 0;
    Sino Si value > 20 Entonces
			value <- 20;
		FinSi
	FinSi
FinFuncion

// Proceso principal para crear un personaje con atributos basados en D&D 5e
SubProceso crearPersonaje(nombre)
    Definir vida, experiencia, fuerza, defensa, nivel Como Entero;
    Definir agilidad, inteligencia Como Entero;
    Definir estado Como Caracter;
    
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
    
    // Mostrar la creación del personaje
	statusPersonaje(nombre, vida, experiencia, fuerza, defensa, agilidad, inteligencia, nivel, estado);
FinSubProceso

SubProceso statusPersonaje(nombre, vida, experiencia, fuerza, defensa, agilidad, inteligencia, nivel, estado)
	Escribir "Personaje creado con éxito: ", nombre;
    Escribir "Vida: ", vida;
    Escribir "Experiencia: ", experiencia;
    Escribir "Fuerza: ", fuerza;
    Escribir "Defensa: ", defensa;
    Escribir "Agilidad: ", agilidad;
    Escribir "Inteligencia: ", inteligencia;
    Escribir "Nivel: ", nivel;
    Escribir "Estado: ", estado;
FinSubProceso

SubProceso mostrarMensaje(mensaje)
    Escribir "|¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯|";
    Escribir "| ", mensaje, rellenarEspacios(mensaje, 36), " |";
    Escribir "|______________________________________|";
FinSubProceso
Funcion espacios <- rellenarEspacios(mensaje, totalEspacios)
    Definir espaciosNecesarios, i Como Entero;
    Definir espacios Como Caracter;
    espaciosNecesarios <- totalEspacios - Longitud(mensaje);
    espacios <- "";
    Para i <- 1 Hasta espaciosNecesarios Hacer
        espacios <- Concatenar(espacios, " ");
    FinPara
FinFuncion
SubProceso pelea
	Escribir "Hola";
FinSubProceso