Algoritmo lanzarDado05
	
    Definir i, j, espacios, altura, contador, alea Como Entero;
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
    alea <- Aleatorio(1, 6);
    
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
	
	
FinAlgoritmo

