Proceso PresentacionEInicioArcade
	definir matrizEspacial, textoArcadeDaVinci Como Caracter;
	definir tam como entero;
	Dimension  matrizEspacial(30,30);
	Dimension textoArcadeDaVinci[24];
	definir dragonMatriz Como Caracter;
	Dimension dragonMatriz[11];
	tam <- 29;
	
	rellenarMatrizEspacial(tam, matrizEspacial);
	Borrar Pantalla;
	dibujarDragon;
	inicializarMatrizDragon(dragonMatriz);
	simularMovimiento(dragonMatriz);
	inicializarTextoMatriz(textoArcadeDaVinci);
	pantallaPreviaCargaJuegos();
	Esperar Tecla;
	Borrar Pantalla;
	pantallaEleccionJuego();
FinProceso

//subproceso utilizado para generar una matriz simulando un espacio de "estrellas"
subproceso rellenarMatrizEspacial(tam, matrizEspacial)
	definir i, j Como Entero;
	para i <- 0 hasta tam-1 Hacer
		Para j <- 0 Hasta  tam-1 Hacer
			matrizEspacial(i,j) <- "*";
		FinPara
	FinPara
	
	para i <- 0 hasta tam-1 Hacer
		para j <- 0 hasta tam-1 Hacer
			Escribir Sin Saltar matrizEspacial(i,j) , " ";
		FinPara
		Escribir "";
		Esperar 50 Milisegundos;
	FinPara
FinSubProceso


//subproceso que dibuja un dragon para la presentación del juego
SubProceso dibujarDragon
	Esperar  1 Segundos;
	
	Escribir "                                            .~))>>";
	Esperar  50 Milisegundos;
	Escribir "                                            .~)>>";
	Esperar  50 Milisegundos;
	
	Escribir "                                       .~))))>>>";
	Esperar  50 Milisegundos;
	
	Escribir "                                         .~))>> "; 
	Esperar  50 Milisegundos;
	
	Escribir "                                    .~))>>)))>>      .-~))>> ";
	Esperar  50 Milisegundos;
	
	Escribir "                                   .~)))))>>       .-~))>>)> ";
	Esperar  50 Milisegundos;
	
	Escribir "                                .~)))>>))))>>  .-~)>>)> ";
	Esperar  50 Milisegundos;
	
	Escribir "                               .~))>>))))>>  .-~)))))>>)>";
	Esperar  50 Milisegundos;
	
	Escribir "                               //)>))))))  .-~))))>>)>";
	Esperar  50 Milisegundos;
	
	Escribir "                              //))>>))) .-~))>>)))))>>)>";
	Esperar  50 Milisegundos;
	
	Escribir "                             //))))) .-~)>>)))))>>)>";
	Esperar  50 Milisegundos;
	
	Escribir "                            //)>))) //))))))>>))))>>)>";
	Esperar  50 Milisegundos;
	
	Escribir "                           |/))))) //)))))>>)))>>)>";
	Esperar  50 Milisegundos;
	
	Escribir "                 (\_(\-\b  |))>)) //)))>>)))))))>>)>";
	Esperar  50 Milisegundos;
	
	Escribir "                _/`-`  ~|b |>))) //)>>)))))))>>)>";
	Esperar  50 Milisegundos;
	
	Escribir "                (@) (@)  /\b|))) //))))))>>))))>>";
	Esperar  50 Milisegundos;
	
    Escribir "              _/       /  \b)) //))>>)))))>>>_._";
	Esperar  50 Milisegundos;
	
	Escribir "              (6,   6) / ^  \b)//))))))>>)))>>   ~~-. ";
	Esperar  50 Milisegundos;
	
	Escribir "               ~^~^~, /\  ^  \b/)>>))))>>      _.     `, ";
	Esperar  50 Milisegundos;
	
	Escribir "               \^^^/ (  ^   \b)))>>        .         `, ";
	Esperar  50 Milisegundos;
	
	Escribir "                `-   ((   ^  ~)_          /             , ";
	Esperar  50 Milisegundos;
	
	Escribir "                      (((   ^    `\        |               `. ";
	Esperar  50 Milisegundos;
	
	Escribir "                     / ((((        \        \      .         `. ";
	Esperar  50 Milisegundos;
	
	Escribir "                    /   (((((  \    \    _.-~\     Y,         ;";
	Esperar  50 Milisegundos;
	
	Escribir "                   /   / (((((( \    \.-~   _.` _.-~,       ; ";
	Esperar  50 Milisegundos;
	
	Escribir "                  /   /   `(((((()    )    (((((~      `,     ; ";
	Esperar  50 Milisegundos;
	
	Escribir "                _/  _/      `++/   /                  ;     ;";
	Esperar  50 Milisegundos;
	
	Escribir "             _.-~_.-~           `/  /`                    ";
	Esperar  50 Milisegundos;
	
	Escribir "            ((((~~             `/ /              _.-~ __.--~ ";
	Esperar  50 Milisegundos;
	
	Escribir "                             ((((          __.-~ _.-~ ";
	Esperar  50 Milisegundos;
	
	Escribir "                                         .   .~~ ";
	Esperar  50 Milisegundos;
	
	Escribir "                                        :    ,";
	Esperar  50 Milisegundos;
	
	Escribir "                                        ~~~~~ ";
	Esperar  50 Milisegundos;
	
FinSubProceso

//subproceso utilizado para inicializar una matriz con la imagen de un dragón.Forma parte de la presentación
SubProceso inicializarMatrizDragon(dragonMatriz)
	dragonMatriz[0]  <- "                  \||/ ";
	dragonMatriz[1] <- "                 |  @___oo ";
	dragonMatriz[2] <- "       /\  /\   / (__,,,,| ";
	dragonMatriz[3] <-  "      ) /^\) ^\/ _) ";
	dragonMatriz[4] <-  "      )   /^\/   _) ";
	dragonMatriz[5] <-  "      )   _ /  / _) ";
	dragonMatriz[6] <-  "  /\  )/\/ ||  | )_) ";
	dragonMatriz[7] <-  " <  >      |(,,) )__) ";
	dragonMatriz[8] <-  "  ||      /    \)___)\ ";
	dragonMatriz[9] <- "  | \____(      )___) )___ ";
	dragonMatriz[10] <-  "  \______(_______;;; __;;; ";
	
FinSubProceso

//proceso para simular que el dragon se desplaza
SubProceso simularMovimiento(dragonMatriz)
	definir i, j Como Entero;
	para i <- 0 hasta 40 con paso 1 Hacer
		Borrar Pantalla;
		para j<-0 hasta 10 Con Paso  1 Hacer
			movimiento(i);
			Escribir  dragonMatriz[j];
		FinPara
		Esperar 50 Milisegundos;
	FinPara
	Borrar Pantalla;
FinSubProceso

//Este subproceso sirve para agregar espacios 
SubProceso movimiento(i)
	Definir  j Como Entero;
	para j <- 0 hasta i Con Paso  1 Hacer
		Escribir sin saltar " ";
	FinPara
FinSubProceso

//Incializa una matriz que guarda el nombre "ARCADE DA VINCI"
SubProceso inicializarTextoMatriz(textoArcadeDaVinci)
    textoArcadeDaVinci[0] <- "     @@@@        @@@@          @@@@@        @@@@           @@@@           @@@@@           ";
    textoArcadeDaVinci[1] <- "    ( @@ \\      |  @ \\     ( @@@@@      ( @@  \\         | @ \\       | @@@@@           ";
    textoArcadeDaVinci[2] <- "   ( @@  \\ \\   | @@@ |     | @         (  @@   \\ \\     | @ | |      |  @@             ";
    textoArcadeDaVinci[3] <- "  ( @@ D  \\ \\  |  @ <      | @        (  @@ D   \\ \\    | @@@ |      | @@@@@            ";
    textoArcadeDaVinci[4] <- " (  @@@@  \\ \\  |_| \\_\\   \\@@@@|   (  @@@@     \\ \\   |@@@@/       | @@@@@|            ";
    textoArcadeDaVinci[5] <- "                                                                                      ";
    textoArcadeDaVinci[6] <- "                                                                                      ";
    textoArcadeDaVinci[7] <- "                                                                                      ";
    textoArcadeDaVinci[8] <- "                                                                                      ";
    textoArcadeDaVinci[9] <- "                  @@@@             @@@@                                              ";
    textoArcadeDaVinci[10] <- "                |  @ \\          ( @@ \\                                              ";
    textoArcadeDaVinci[11] <- "                | @  | |        ( @@   \\ \\                                              ";
    textoArcadeDaVinci[12] <- "                | @@@  |        ( @@ D  \\ \\                                              ";
    textoArcadeDaVinci[13] <- "                |@@@@ /         ( @@@@   \\ \\                                              ";
    textoArcadeDaVinci[14] <- "                                                                                      ";
    textoArcadeDaVinci[15] <- "                                                                                      ";
    textoArcadeDaVinci[16] <- "                                                                                      ";
    textoArcadeDaVinci[17] <- "                                                                                      ";
    textoArcadeDaVinci[18] <- "                                                                                      ";
    textoArcadeDaVinci[19] <- "        ((        ((    @@@@@    (    (         @@@@@       @@@@@                           ";
    textoArcadeDaVinci[20] <- "        \\ \\   / /    |_   _|   | \\ | |     ( @@@@@      |_   _|                        ";
    textoArcadeDaVinci[21] <- "         \\ \\_/ /       | |     |  \\| |     | @            | |                          ";
    textoArcadeDaVinci[22] <- "          \\    /        | |     | |\\  |     | @            | |                          ";
    textoArcadeDaVinci[23] <- "           \\_/        |_   _|   |_| \\_|     \\@@@@|      |_   _|                        ";
	simularMovimientoTextoArcade(textoArcadeDaVinci);
	Esperar 1 Segundos;
	Borrar Pantalla;
FinSubProceso

//Proceso para simular movimiento en el texto del arcade
SubProceso simularMovimientoTextoArcade(textoArcadeDaVinci)
    Definir i, j, k Como Entero;
    Para i <- 0 Hasta 40 Con Paso 1 Hacer
        Borrar Pantalla;
        Para j <- 0 Hasta 23 Con Paso 1 Hacer
            Para k <- 0 Hasta i Con Paso 1 Hacer
                Escribir sin saltar " ";
            FinPara
            Escribir textoArcadeDaVinci[j];
        FinPara
        Esperar 50 Milisegundos;
    FinPara
FinSubProceso

//Subproceso que muestra un dragón que da la bienvenida al jugador
SubProceso pantallaPreviaCargaJuegos
	Esperar  50 Milisegundos;
    Escribir "                                                                                                                        ";
	Esperar  50 Milisegundos;
    Escribir "                       |\\                                                              /|                             ";
    Esperar  50 Milisegundos;
	Escribir "                       | \\                                                            / |                             ";
    Esperar  50 Milisegundos;
	Escribir "                       |  \\                                                          /  |                             ";
    Esperar  50 Milisegundos;
	Escribir "                       |   \\                                                        /   |                             ";    
    Esperar  50 Milisegundos;
	Escribir "            _____)    \\                                                      /    (____                           ";
    Esperar  50 Milisegundos;
	Escribir "           \\          \\                                                    /         /                            ";
    Esperar  50 Milisegundos;
	Escribir "            \\          \\                                                  /         /                             ";
    Esperar  50 Milisegundos;
	Escribir "            \\           `--_____                                _____--          /                              ";
    Esperar  50 Milisegundos;
	Escribir "             \\                  \\                              /                 /                               ";    
    Esperar  50 Milisegundos;
	Escribir "            ____)                  \\                            /                 (____                          ";
    Esperar  50 Milisegundos;
	Escribir "            \\                       \\        /|      |\\        /                      /                          ";
    Esperar  50 Milisegundos;
	Escribir "             \\                       \\      | /      \\ |      /                      /                           ";
    Esperar  50 Milisegundos;
	Escribir "              \\                       \\     ||        ||     /                      /                            ";
    Esperar  50 Milisegundos;
	Escribir "               \\                       \\    | \\______/ |    /                      /                             ";
    Esperar  50 Milisegundos;
	Escribir "                \\                       \\  / \\        / \\  /                      /                              ";
    Esperar  50 Milisegundos;
	Escribir "                /                        \\| (*\\  \\/  /*) |/                       \\                              ";
    Esperar  50 Milisegundos;
	Escribir "               /                          \\   \\| \\/ |/   /                         \\                             ";
    Esperar  50 Milisegundos;
	Escribir "              /                            |   |    |   |                           \\                            ";
    Esperar  50 Milisegundos;
	Escribir "             /                             |\\ _\\____/_ /|                            \\                           ";
    Esperar  50 Milisegundos;
	Escribir "            /______                       | | \\)____(/ | |                      ______\\                          ";
    Esperar  50 Milisegundos;
	Escribir "                   )                      |  \\ |/vv\\| /  |                     (                               ";
    Esperar  50 Milisegundos;
	Escribir "                  /                      /    | |  | |    \\                     \\                              ";
	Esperar  50 Milisegundos;
	Escribir "                 /                      /     ||\\^^/||     \\                     \\                             ";
    Esperar  50 Milisegundos;
	Escribir "                /                      /     / \\====/ \\     \\                     \\                            ";
    Esperar  50 Milisegundos;
	Escribir "              /_______           ____/      \\________/      \\____           ______\\                           ";
    Esperar  50 Milisegundos;
	Escribir "                     )         /   |       |  ____  |       |   \\         (                                     ";
    Esperar  50 Milisegundos;
	Escribir "                     |       /     |       \\________/       |     \\       |                                     ";
    Esperar  50 Milisegundos;
	Escribir "                     |     /       |       |  ____  |       |       \\     |                                     ";
    Esperar  50 Milisegundos;
	Escribir "                     |   /         |       \\________/       |         \\   |                                     ";
    Esperar  50 Milisegundos;
	Escribir "                     | /            \\      \\ ______ /      /______..    \\ |                                  ";
    Esperar  50 Milisegundos;
	Escribir "                     /              |      \\\\______//      |        \\     \\                                 ";
    Esperar  50 Milisegundos;
	Escribir "                                    |       \\ ____ /       |LLLLL/_  \\                                      ";
    Esperar  50 Milisegundos;
	Escribir "                                    |      / \\____/ \\      |      \\   |                                     ";
    Esperar  50 Milisegundos;
	Escribir "                                    |     / / \\__/ \\ \\     |     __\\  /__                                    ";
    Escribir "                                    |    | |        | |    |     \\      /                                     ";
    Escribir "                                    |    | |        | |    |      \\    /                                      ";
    Escribir "                                    |    |  \\      /  |    |       \\  /                                       ";
    Escribir "                                    |     \\__\\    /__/     |        \\/                                        ";
    Escribir "                                   /    ___\\  )  (  /___    \\                                               ";
    Escribir "                                  |/\\/\\|    )      (    |/\\/\\|                                              ";
    Escribir "                                  ( (  )                (  ) )                                              ";                                        
    Escribir "                     =============================================================================================== ";
    Escribir "                      * ===========================================================================================* ";
    Escribir "                    * *                                                                                            * * ";
    Escribir "                    * *                                                                                            * * ";
    Escribir "                    * *                                                                                            * * ";
    Escribir "                    * *                                                                                            * * ";
    Escribir "                    * *                      BIENVENIDOS A JUEGOS DA VINCI                                         * * ";
    Escribir "                    * *                                                                                            * * ";
    Escribir "                    * *                (Presione una tecla para acceder a nuestros juegos)                         * * ";    
    Escribir "                    * *                                                                                            * * ";
    Escribir "                    * *                                                                                            * * ";        
    Escribir "                    * *                                                                                            * * ";    
    Escribir "                    * *                                                                                            * * ";
    Escribir "                     * =========================================================================================== * ";
    Escribir "                     =============================================================================================== ";    
FinSubProceso

//Subproceso que muestra la pantalla que carga los juegos o la salida
SubProceso pantallaEleccionJuego
	Definir opcion Como Entero;
	
	Escribir "**********************************************************************";
	Escribir "*                                                                    *";
	Escribir "*                     SELECCIONA UN JUEGO                            *";
	Escribir "*                                                                    *";
	Escribir "**********************************************************************";
	Escribir "*                                                                    *";
	Escribir "*                          1. Laberinto                              *";
	Escribir "*                          2. Buscaminas                             *";
	Escribir "*                          3. Salir                                  *";
	Escribir "*                                                                    *";
	Escribir "**********************************************************************";
	
	Escribir "Por favor, ingrese una opción (1, 2, 3): ";
	Leer opcion;
	
	Segun opcion Hacer
		Caso 1:
			Escribir "Cargando Laberinto...";
			// Llamar al proceso correspondiente para iniciar el juego del laberinto
			
		Caso 2:
			Escribir "Cargando Buscaminas...";
			// Llamar al proceso correspondiente para iniciar el juego del buscaminas
			
		Caso 3:
			Escribir "Saliendo...";
			// Salir del programa
			
		De Otro Modo:
			Escribir "Opción no válida. Por favor, ingrese una opción correcta.";
			Esperar 3 Segundos;
			Borrar Pantalla;
			pantallaEleccionJuego();
	FinSegun
FinSubProceso

