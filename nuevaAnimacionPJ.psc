SubProceso espacios ( i )
	Definir j Como Entero;
	Para j<-0 Hasta i Con Paso 1 Hacer
		Escribir Sin Saltar " ";
	FinPara
	
FinSubProceso

SubProceso animacionPersonaje
    Definir pj, arbol,arbol1 Como Caracter;
    Definir i, j Como Entero;
    
    Escribir "Presione una tecla para iniciar la animación";
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