Algoritmo lanzarDado04
	
    Definir i, j, espacios, altura, contador Como Entero;
    Definir cubo1, cubo2, cubo3 Como Caracter;
    Dimension cubo1[8], cubo2[8], cubo3[8];
	
    // Definición del primer cubo
    cubo1[1] <- "         ______ ";
    cubo1[2] <- "        /     /\";
    cubo1[3] <- "       /  0  /  \";
    cubo1[4] <- "      /_____/  0 \ ";
    cubo1[5] <- "      \ 0 0 \ 0  / ";
    cubo1[6] <- "       \ 0 0 \  /  ";
    cubo1[7] <- "        \_____\/";
	
    // Definición del segundo cubo
    cubo2[1] <- "   _______";
    cubo2[2] <- "  /\\ o o o\\";
    cubo2[3] <- " /o \\ o o o\\";
    cubo2[4] <- "<    >------>";
    cubo2[5] <- " \\ o/  o   /";
    cubo2[6] <- "  \\/______/ ";
    cubo2[7] <- "";
	
    // Definición del tercer cubo
    cubo3[1] <- "  _______";
    cubo3[2] <- " | .   . |\\";
    cubo3[3] <- " |   .   |.\ ";
    cubo3[4] <- " | .   . |. |";
    cubo3[5] <- " |_______|. |";
    cubo3[6] <- " \\  .   \\ |";
    cubo3[7] <- "  \\______\\|";
	
    Escribir "Presione para lanzar el dado, veamos tu suerte!!!...";
    Leer altura; // Simula la presión de un botón
	
    contador <- 0; // Contador para alternar entre cubos
	
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
        Esperar 200 Milisegundos; // Ajusta la velocidad del salto
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
        Esperar 200 Milisegundos; // Ajusta la velocidad del salto
        contador <- contador + 1;
    FinPara
	
    Escribir "La suerte te sonrie!!! por ahora.";
	
FinAlgoritmo
