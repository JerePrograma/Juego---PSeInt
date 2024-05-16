Proceso juegoLaberinto
    solicitarContinuacion();
    Definir tam Como Entero;
    Definir laberinto, estadoOriginal Como Caracter;
    Dimension laberinto(10,10);
    Dimension estadoOriginal(10,10);
    tam <- 10; // Tamaño del laberinto
	
    inicializarLaberinto(tam, laberinto);
    definirParedes(tam, laberinto);
    inicializarEstadoOriginal(tam, laberinto, estadoOriginal);
	
    mostrarLaberinto(tam, laberinto);
    
    seguimiento(tam, laberinto, estadoOriginal);
FinProceso

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

SubProceso seguimiento(tam, laberinto, estadoOriginal)
    Definir posX, posY, posXAnterior, posYAnterior Como Entero;
    Definir simboloJugador Como Caracter;
	simboloJugador <- "J";
    Definir juegoActivo Como Logico;
	juegoActivo <- Verdadero;
    posX <- 0; posY <- 0;
	
    Mientras juegoActivo Hacer
        posXAnterior <- posX;
        posYAnterior <- posY;
        presionar(posXAnterior, posYAnterior, posX, posY, simboloJugador, laberinto, tam);
		
        evaluarPosicion(tam, laberinto, estadoOriginal, posX, posY, posXAnterior, posYAnterior, simboloJugador, juegoActivo);
    FinMientras;
FinSubProceso

SubProceso evaluarPosicion(tam, laberinto, estadoOriginal, posX, posY, posXAnterior, posYAnterior, simboloJugador, juegoActivo Por Referencia)
    Si laberinto(posX, posY) = "x" Entonces
        mostrarMensaje("No puedes continuar, hay una pared");
    Sino
        Si laberinto(posX, posY) = "[" Entonces
            mostrarMensaje("¡Llegaste, descansa en esta hoguera guerrero!");
            juegoActivo <- Falso;
        Sino
            laberinto(posXAnterior, posYAnterior) <- estadoOriginal(posXAnterior, posYAnterior);
            laberinto(posX, posY) <- simboloJugador;
            mostrarLaberinto(tam, laberinto);
        FinSi;
    FinSi;
FinSubProceso

SubProceso solicitarContinuacion
    Definir iniciarJuego Como Caracter;
    mostrarMensaje("Digite cualquier LETRA para comenzar");
    Leer iniciarJuego;
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
                FinSi
            FinSi
        FinSi
    FinSi
    Segun eleccionNumero Hacer
        1:
            Si posY > 0 Y Minusculas(laberinto(posX, posY-1)) <> "x" Entonces
                posYNueva <- posY - 1;
                direccion <- "<";
            Sino
                mostrarMensaje("Movimiento inválido");
            FinSi
        2:
            Si posX < tam-1 Y Minusculas(laberinto(posX+1, posY)) <> "x" Entonces
                posXNueva <- posX + 1;
                direccion <- "v";
            Sino
                mostrarMensaje("Movimiento inválido");
            FinSi
        3:
            Si posY < tam-1 Y Minusculas(laberinto(posX, posY+1)) <> "x" Entonces
                posYNueva <- posY + 1;
                direccion <- ">";
            Sino
                mostrarMensaje("Movimiento inválido");
            FinSi
        4:
            Si posX > 0 Y Minusculas(laberinto(posX-1, posY)) <> "x" Entonces
                posXNueva <- posX - 1;
                direccion <- "^";
            Sino
                mostrarMensaje("Movimiento inválido");
            FinSi
        De Otro Modo:
            mostrarMensaje("Movimiento inválido");
    FinSegun
    Si posXNueva = posX Y posYNueva = posY Entonces
        mostrarMensaje("No puedes continuar, hay una pared");
    FinSi
FinSubProceso

SubProceso mostrarMensaje(mensaje)
    Escribir "|¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯|";
    Escribir "|", mensaje, rellenarEspacios(mensaje, 38), "|";
    Escribir "|______________________________________|";
FinSubProceso

SubProceso espacios <- rellenarEspacios(mensaje, totalEspacios) 
	Definir espaciosNecesarios Como Entero;
	Definir i Como Entero;
espaciosNecesarios <- totalEspacios - Longitud(mensaje);
Definir espacios Como Caracter;
espacios <- "";
Para i <- 1 Hasta espaciosNecesarios Hacer
	espacios <- Concatenar(espacios, " ");
FinPara
FinSubProceso

