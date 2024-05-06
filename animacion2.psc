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
    Dimension arbol[5];
	Dimension arbol1[5];
	
	arbol1[0] <- " ----/*\---------/*\--------/*\------^"  ;
    arbol1[1] <- "    |***|       |***|      |***|    ^^^  "  ;
    arbol1[2] <- "     \*/         \*/        \*/    ^^^^^   "   ;
    arbol1[3] <- "      |           |          |       ^   "   ;
    arbol1[4] <- "^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^";
	
    
    pj[0] <- "   --|__|__|";
    pj[1] <- "     |0 | 0|";
    pj[2] <- "   _||-- --||";
    pj[3] <- "  __#|__ __|#";
    pj[4] <- " ____|__|__|__";
    Escribir "-----------------------------------";
    arbol[0] <- "     /*\    ^    /*\    ^   /*\      ^"  ;
    arbol[1] <- "    |***|  ^^^  |***|  ^^^ |***|    ^^^  "  ;
    arbol[2] <- "     \*/   ^^^   \*/   ^^^  \*/    ^^^^^   "   ;
    arbol[3] <- "      |     |     |     |    |       |  "   ;
    arbol[4] <- "^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^";
    
    Para i <- 0 Hasta 40  CON PASO 1 Hacer // Ajustamos el número de iteraciones para moverse a lo largo de la pantalla
        Borrar Pantalla;
        // Mostrar el personaje y el movimiento
        Para j <- 0 Hasta 4 Con Paso 1 Hacer
            espacios(i);
			Escribir pj[j];
        FinPara
        Para j <- 0 Hasta 4 Hacer
			Escribir arbol1[j];
		FinPara
        // Mostrar el árbol
        Para j <- 0 Hasta 4 Hacer
			
            Escribir arbol[j];
        FinPara
        
        // Esperar un poco antes de pasar a la siguiente iteración
        Esperar 100 Milisegundos;
    FinPara
    
    Esperar 10 Segundos;
    Borrar Pantalla;
FinProceso
