SubProceso espacios ( i )
	Definir j Como Entero;
	Para j<-0 Hasta i Con Paso 1 Hacer
		Escribir Sin Saltar " ";
	FinPara
	
FinSubProceso

Proceso animacion
    Definir pj, arbol,arbol1 Como Caracter;
    Definir i, j Como Entero;
    
    Escribir "Presione una tecla para iniciar la animación";
    Esperar Tecla;
    
    Dimension pj[5];
    Dimension arbol[10];
	Dimension arbol1[10];
	
	arbol1[0] <- "              v .   ._, |_  .,               v .   ._, |_  .,          "  ;
    arbol1[1] <- "           `-._\/  .  \ /    |/_             `-._\/  .  \ /    |/_       "  ;
    arbol1[2] <- "               \\  _\, y | \//                \\  _\, y | \//          "   ;
    arbol1[3] <- "          _\_.___\\, \\/ -.\||           _\_.___\\, \\/ -.\||          "   ;
    arbol1[4] <- "             -,--. ._||  / / ,              -,--. ._||  / / ,          ";
	arbol1[5]<-"                /     -. ./ / |/_.                 /     -. ./ / |/_.        ";
	arbol1[6]<-"                      |    |//                      |    |//              ";
	arbol1[7]<-"                      |_    /                       |_    /              ";
	arbol1[8]<-"                      |-   |                        |-   |              ";
	arbol1[9]<-" --------------------/ ,  . \----------------------/ ,  . \--------       ";
	
    
    pj[0] <- "   --|__|__|";
    pj[1] <- "     |0 | 0|";
    pj[2] <- "   _||-- --||";
    pj[3] <- "  __#|__ __|#";
    pj[4] <- " ____|__|__|__";
    Escribir "-----------------------------------";
    arbol[0] <- "              v .   ._, |_  .,               v .   ._, |_  .,          "  ;
    arbol[1] <- "           `-._\/  .  \ /    |/_             `-._\/  .  \ /    |/_       "  ;
    arbol[2] <- "               \\  _\, y | \//                \\  _\, y | \//          "   ;
    arbol[3] <- "          _\_.___\\, \\/ -.\||           _\_.___\\, \\/ -.\||          "   ;
    arbol[4] <- "             -,--. ._||  / / ,              -,--. ._||  / / ,          ";
	arbol[5]<-"                /     -. ./ / |/_.                 /     -. ./ / |/_.        ";
	arbol[6]<-"                      |    |//                      |    |//              ";
	arbol[7]<-"                      |_    /                       |_    /              ";
	arbol[8]<-"                      |-   |                        |-   |              ";
	arbol[9]<-" --------------------/ ,  . \----------------------/ ,  . \--------       ";
    Para i <- 0 Hasta 40  CON PASO 1 Hacer // Ajustamos el número de iteraciones para moverse a lo largo de la pantalla
        Borrar Pantalla;
        // Mostrar el personaje y el movimiento
        Para j <- 0 Hasta 4 Con Paso 1 Hacer
            espacios(i);
			Escribir pj[j];
        FinPara
        Para j <- 0 Hasta 9 Hacer
			Escribir arbol1[j];
		FinPara
        // Mostrar el árbol
        Para j <- 0 Hasta 9 Hacer
			
            Escribir arbol[j];
        FinPara
        
        // Esperar un poco antes de pasar a la siguiente iteración
        Esperar 100 Milisegundos;
    FinPara
    
    Esperar 10 Segundos;
    Borrar Pantalla;
FinProceso
