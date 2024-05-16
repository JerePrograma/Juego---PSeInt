Proceso animacion
    Definir pj Como Caracter;
    Definir i, j,k Como Entero;
    
    Escribir "Presione una tecla para iniciar la animación";
    Esperar Tecla;
    
    Dimension pj[20];
    
    pj[0] <- "                              @@@%%%@@%% ";
    pj[1] <- "                     @@@###### %%#+==#%@%%# ";  
    pj[2] <- "                    @@@%##++++=*%@*+==*@#*=*%@";
    pj[3] <- "                   @%####**++++#%@*+==*@#*+**#@@ ";
    pj[4] <- "                  @%###########%@***++*@##*###@@";
	pj[5] <-"                   @%##%@*********++++*** *****@@";
	pj[6] <-"                  @%##%@+#@@@% %%%@@@@@@%%%@#+@@";
	pj[7] <-"                 @@% ##%@+#@@%     @@@@@@   @#+@@ ";
	pj[8] <-"                @%%%%%#%@+#@@@@@@@@@@@@@@@@@#+@@";
	pj[9] <-"              @######%@@*#@@@@@@@@@@@@@@@@@#+@@";
	pj[10] <-"            @%#########%@@%############# ##%##@@";
	pj[11] <-"            @%%****###%@##%%%% ************%%#@@ ";
	pj[12] <-"             @@@@@@% **%@*#@###++++++====++@%*@@";
	pj[13] <-"              @@%%%@@@@@@*#@###++++++++++++@%*@@ ";
	pj[14] <-"             @@%%%%%%%@@*#@###**++++++++++*@%*@@ ";
	pj[15] <-"             @@@@@@@@@@@@%############## ####%@@";
    pj[16] <-"              @%%%######%%%##* **********##%##@@";
	pj[17] <-"                  @@@@@@@@@@@@%%%%%%%%%%@@@@@";
	pj[18] <-"                       @@@@@          @@@@@ ";
	pj[19] <-"                       @@@            @@@";
	
	
	Para i <- 0 Hasta 10  Hacer // Ajustamos el número de iteraciones para moverse a lo largo de la pantalla
        Borrar Pantalla;
        
        // Mostrar el personaje y el movimiento hacia la derecha
        Para j <- 0 Hasta 19 Hacer
            // Imprimir espacios en blanco para simular el movimiento hacia la derecha
            Para k <- 0 Hasta i Hacer
                
            FinPara
			Escribir pj[j];
        FinPara
		//        
        // Esperar un poco antes de pasar a la siguiente iteración
		//        Esperar 0.5 Segundos;
    FinPara
FinProceso