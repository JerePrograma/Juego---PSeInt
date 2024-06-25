//Este algoritmo simplemente genera un tablero cortina totalmente tapado
SubProceso tableroCortina(matriz Por Referencia,filas,columnas)
	//Tablero cortina, por que va a ser el q permita que no se vea el tablero con las bombas descubierto desde un principio
	//0 = es para cuando el espacio este tapado
	//1 = es para el espacio que este destapado, osea se vera en blanco o un numero (eso a medida que el jugar este jugando)
	//2 = es para el espacio en el que el jugador decida colocar una bandera (para decidir si se gana el juego se podria pedir
	//																		  que se marquen todas las minas con banderas).
	Definir i,j Como Entero;
	Para i <- 0 Hasta filas-1 Hacer
		Para j <- 0 Hasta columnas-1 Hacer
			matriz(i,j) <- 0;
		FinPara
	FinPara
FinSubProceso

//Este algoritmo muestra lo que el jugador tiene que ver dependiendo lo que vaya seleccionando
//Por ejemplo: si aun no a elegido nada el tablero estara totalmente tapado,
//si selecciona un espacio para limpiar, motrara el lugar que corresponda pero no todo el tablero.
SubProceso mostrarTablero(matriz, cortina Por Referencia, filas Por Referencia, columnas Por Referencia)
    Definir i, j Como Entero;
	
    // Mostrar los números de columna en la parte superior
    Escribir Sin Saltar "   ";
    Para j <- 0 Hasta columnas-1 Hacer
		///Este condicional es para cuando haya columnas con mas de 1 digito se siga viendo bien
		si j < 10 Entonces
			Escribir Sin Saltar " ", j+1, " ";
		SiNo
			Escribir Sin Saltar j+1, " ";
		FinSi
    FinPara
    Escribir ""; // Salto de línea
	
    // Mostrar los guiones entre los números de columna y la matriz
    Escribir Sin Saltar "   ";
    Para j <- 0 Hasta columnas-1 Hacer
        Escribir Sin Saltar "---";
    FinPara
    Escribir ""; // Salto de línea
	
    // Mostrar el tablero con números de filas y columnas
    Para i <- 0 Hasta filas-1 Hacer
        // Mostrar el número de la fila al principio
        Si i < 9 Entonces
            Escribir Sin Saltar " ", i+1, "|";
        SiNo
            Escribir Sin Saltar i+1, "|";
        FinSi
		
        Para j <- 0 Hasta columnas-1 Hacer
            // Comprobar si en la matrizCortina está liberado el lugar para mostrar la matriz de minas
            Si cortina(i, j) = 0 Entonces
                // Si es el valor 0 en la matrizCortina, entonces muestra la matrizCortina
                Escribir Sin Saltar " . ";
            SiNo
                Si cortina(i, j) = 1 Entonces
                    // Si es el valor 1 en la matrizCortina, entonces muestra la matriz de minas
                    Si matriz(i, j) = 0 Entonces
                        // En la matriz de minas si es = 0 entonces muestra un "  " (espacio vacío)
                        Escribir Sin Saltar "   ";
                    SiNo
                        // Y si no es ninguno de los anteriores muestra el número de bombas que tiene alrededor ese espacio
                        Escribir Sin Saltar " ", matriz(i, j), " ";
                    FinSi
                SiNo
                    Si cortina(i, j) = 2 Entonces
                        // Si es un 2, en este espacio se colocó una bandera
                        Escribir Sin Saltar " P "; // La P parece una bandera
                    FinSi
                FinSi
            FinSi
        FinPara
		
        // Mostrar el número de la fila al final
        Escribir "|", i+1;
    FinPara
	
    // Mostrar los guiones entre la matriz y los números de columna en la parte inferior
    Escribir Sin Saltar "   ";
    Para j <- 0 Hasta columnas-1 Hacer
        Escribir Sin Saltar "---";
    FinPara
    Escribir ""; // Salto de línea
	
    // Mostrar los números de columna en la parte inferior
    Escribir Sin Saltar "   ";
    Para j <- 0 Hasta columnas-1 Hacer
        ///Este condicional es para cuando haya columnas con mas de 1 digito se siga viendo bien
		si j < 10 Entonces
			Escribir Sin Saltar " ", j+1, " ";
		SiNo
			Escribir Sin Saltar j+1, " ";
		FinSi
    FinPara
    Escribir ""; // Salto de línea
FinSubProceso

//Este algoritmo muestra el tablero y todas las minas del mismo, exclusiva para el final del juego
SubProceso mostrarTableroFinJuego(matriz, cortina Por Referencia, filas Por Referencia, columnas Por Referencia)
    Definir i, j Como Entero;
	
    // Mostrar los números de columna en la parte superior
    Escribir Sin Saltar "   ";
    Para j <- 0 Hasta columnas-1 Hacer
        ///Este condicional es para cuando haya columnas con mas de 1 digito se siga viendo bien
		si j < 10 Entonces
			Escribir Sin Saltar " ", j+1, " ";
		SiNo
			Escribir Sin Saltar j+1, " ";
		FinSi
    FinPara
    Escribir ""; // Salto de línea
	
    // Mostrar los guiones entre los números de columna y la matriz
    Escribir Sin Saltar "   ";
    Para j <- 0 Hasta columnas-1 Hacer
        Escribir Sin Saltar "---";
    FinPara
    Escribir ""; // Salto de línea
	
    // Mostrar el tablero con números de filas y columnas
    Para i <- 0 Hasta filas-1 Hacer
        // Mostrar el número de la fila al principio
        Si i < 9 Entonces
            Escribir Sin Saltar " ", i+1, "|";
        SiNo
            Escribir Sin Saltar i+1, "|";
        FinSi
		
        Para j <- 0 Hasta columnas-1 Hacer
            // Comprobar si en la matrizCortina está liberado el lugar para mostrar la matriz de minas
            Si cortina(i, j) = 0 o cortina(i, j) = 2 Entonces
				///Esto es lo unico que cambie para mostrar la matriz al final del juego
				si matriz(i,j) = 11 Entonces
					Escribir Sin Saltar " X ";
				SiNo
					si cortina(i, j) = 0 Entonces
						// Si es el valor 0 en la matrizCortina, entonces muestra la matrizCortina
						Escribir Sin Saltar " . ";
					FinSi					
				FinSi                
            SiNo
                Si cortina(i, j) = 1 Entonces
                    // Si es el valor 1 en la matrizCortina, entonces muestra la matriz de minas
                    Si matriz(i, j) = 0 Entonces
                        // En la matriz de minas si es = 0 entonces muestra un "  " (espacio vacío)
                        Escribir Sin Saltar "   ";
                    SiNo
                        // Y si no es ninguno de los anteriores muestra el número de bombas que tiene alrededor ese espacio
                        Escribir Sin Saltar " ", matriz(i, j), " ";
                    FinSi
                SiNo
                    Si cortina(i, j) = 2 Entonces
                        // Si es un 2, en este espacio se colocó una bandera
                        Escribir Sin Saltar " P "; // La P parece una bandera
                    FinSi
                FinSi
            FinSi
        FinPara
		
        // Mostrar el número de la fila al final
        Escribir "|", i+1;
    FinPara
	
    // Mostrar los guiones entre la matriz y los números de columna en la parte inferior
    Escribir Sin Saltar "   ";
    Para j <- 0 Hasta columnas-1 Hacer
        Escribir Sin Saltar "---";
    FinPara
    Escribir ""; // Salto de línea
	
    // Mostrar los números de columna en la parte inferior
    Escribir Sin Saltar "   ";
    Para j <- 0 Hasta columnas-1 Hacer
        ///Este condicional es para cuando haya columnas con mas de 1 digito se siga viendo bien
		si j < 10 Entonces
			Escribir Sin Saltar " ", j+1, " ";
		SiNo
			Escribir Sin Saltar j+1, " ";
		FinSi
    FinPara
    Escribir ""; // Salto de línea
FinSubProceso

//Este Algoritmo crea una matriz con minas en lugares aleatorios
SubProceso CrearTableroMinasAleatorias(matriz Por Referencia,filas,columnas,minas)
	Definir contadorMinas,i,j Como Entero;
	contadorMinas <- 0;
	Definir primeraVez Como Logico;
	primeraVez <- Verdadero;
	//Generamos una matriz con las minas aleatorias
	Repetir
		Para i <- 0 Hasta filas-1 Hacer
			Para j <- 0 Hasta columnas-1 Hacer					
				si azar(10) = 0 y contadorMinas <> minas Entonces
					//Agrega una mina
					si primeraVez = Verdadero Entonces	//Si es la primera vez que se ejecuta el codigo
						matriz[i,j] <- 11;					//simplemente agrega el numero a una matriz de cero
						contadorMinas <- contadorMinas + 1; 	//Sino
					SiNo									
						si matriz[i,j] = 10 Entonces		//Verifica si en la posicion actual (hay osea el 11) 
							matriz[i,j] <- 11;				//o no una mina(osea el 10)
							contadorMinas <- contadorMinas + 1;
						FinSi
					FinSi
				SiNo
					si primeraVez = Verdadero Entonces//Si es la primera vez que se ejecuta el codigo
						matriz[i,j] <- 10;				//simplemente agrega el numero a una matriz de cero
					FinSi
				FinSi
			FinPara
		FinPara
		//Escribir contadorMinas;
		primeraVez <- Falso;
	Hasta Que contadorMinas = minas;
FinSubProceso

//Este algoritmo coloca en la matriz creada en cada espacio que no tiene minas, cuantas minas tiene alrededor
SubProceso TableroDeMinasAdyacentes(tablero Por Referencia,filas,columnas)
	Definir i, j, minasCercanas Como Entero;
	minasCercanas <- 0;
	//muestra las los numeros correspondientes a las minas
	Para i<-0 Hasta filas-1 Hacer
		Para j<-0 Hasta columnas-1 Hacer			
			//esquina superior izquierda
			si i = 0 y j = 0 Entonces
				si tablero[i,j] = 11 Entonces
					tablero[i,j] <- 11;
				SiNo
					//6
					si tablero[i,j+1] = 11 Entonces
						minasCercanas <- minasCercanas + 1;
					FinSi
					//8
					si tablero[i+1,j] = 11 Entonces
						minasCercanas <- minasCercanas + 1;
					FinSi
					//9
					si tablero[i+1,j+1] = 11 Entonces
						minasCercanas <- minasCercanas + 1;
					FinSi
					tablero[i,j] <- minasCercanas;
				FinSi
				minasCercanas <- 0;
			FinSi			
			//esquina supeior derecha
			si i = 0 y j = columnas-1 Entonces
				si tablero[i,j] = 11 Entonces
					tablero[i,j] <- 11;
				SiNo
					//4
					si tablero[i,j-1] = 11 Entonces
						minasCercanas <- minasCercanas + 1;
					FinSi
					//7
					si tablero[i+1,j-1] = 11 Entonces
						minasCercanas <- minasCercanas + 1;
					FinSi
					//8
					si tablero[i+1,j] = 11 Entonces
						minasCercanas <- minasCercanas + 1;
					FinSi
					tablero[i,j] <- minasCercanas;
				FinSi
				minasCercanas <- 0;
			FinSi
			//esquina inferior izquierda
			si i = filas-1 y j = 0 Entonces
				si tablero[i,j] = 11 Entonces
					tablero[i,j] <- 11;
				SiNo
					//2
					si tablero[i-1,j] = 11 Entonces
						minasCercanas <- minasCercanas + 1;
					FinSi
					//3
					si tablero[i-1,j+1] = 11 Entonces
						minasCercanas <- minasCercanas + 1;
					FinSi
					//6
					si tablero[i,j+1] = 11 Entonces
						minasCercanas <- minasCercanas + 1;
					FinSi
					tablero[i,j] <- minasCercanas;
				FinSi
				minasCercanas <- 0;
			FinSi			
			//esquina inferior derecha
			si i = filas-1 y j = columnas-1 Entonces
				si tablero[i,j] = 11 Entonces
					tablero[i,j] <- 11;
				SiNo
					//1
					si tablero[i-1,j-1] = 11 Entonces
						minasCercanas <- minasCercanas + 1;
					FinSi
					//2
					si tablero[i-1,j] = 11 Entonces
						minasCercanas <- minasCercanas + 1;
					FinSi
					//4
					si tablero[i,j-1] = 11 Entonces
						minasCercanas <- minasCercanas + 1;
					FinSi
					tablero[i,j] <- minasCercanas;
				FinSi
				minasCercanas <- 0;
			FinSi			
			//borde superior
			si i = 0 y j <> 0 y j <> columnas-1 Entonces
				si tablero[i,j] = 11 Entonces
					tablero[i,j] <- 11;
				SiNo
					//4
					si tablero[i,j-1] = 11 Entonces
						minasCercanas <- minasCercanas + 1;
					FinSi
					//6
					si tablero[i,j+1] = 11 Entonces
						minasCercanas <- minasCercanas + 1;
					FinSi
					//7
					si tablero[i+1,j-1] = 11 Entonces
						minasCercanas <- minasCercanas + 1;
					FinSi
					//8
					si tablero[i+1,j] = 11 Entonces
						minasCercanas <- minasCercanas + 1;
					FinSi
					//9
					si tablero[i+1,j+1] = 11 Entonces
						minasCercanas <- minasCercanas + 1;
					FinSi
					tablero[i,j] <- minasCercanas;
				FinSi
				minasCercanas <- 0;
			FinSi			
			//borde derecho
			si i <> 0 y i <> filas-1 y j = columnas-1 Entonces
				si tablero[i,j] = 11 Entonces
					tablero[i,j] <- 11;
				SiNo
					//1
					si tablero[i-1,j-1] = 11 Entonces
						minasCercanas <- minasCercanas + 1;
					FinSi
					//2
					si tablero[i-1,j] = 11 Entonces
						minasCercanas <- minasCercanas + 1;
					FinSi
					//4
					si tablero[i,j-1] = 11 Entonces
						minasCercanas <- minasCercanas + 1;
					FinSi
					//7
					si tablero[i+1,j-1] = 11 Entonces
						minasCercanas <- minasCercanas + 1;
					FinSi
					//8
					si tablero[i+1,j] = 11 Entonces
						minasCercanas <- minasCercanas + 1;
					FinSi
					tablero[i,j] <- minasCercanas;
				FinSi
				minasCercanas <- 0;
			FinSi			
			//borde inferior
			si i = filas-1 y j <> 0 y j <> columnas-1 Entonces
				si tablero[i,j] = 11 Entonces
					tablero[i,j] <- 11;
				SiNo
					//1
					si tablero[i-1,j-1] = 11 Entonces
						minasCercanas <- minasCercanas + 1;
					FinSi
					//2
					si tablero[i-1,j] = 11 Entonces
						minasCercanas <- minasCercanas + 1;
					FinSi
					//3
					si tablero[i-1,j+1] = 11 Entonces
						minasCercanas <- minasCercanas + 1;
					FinSi
					//4
					si tablero[i,j-1] = 11 Entonces
						minasCercanas <- minasCercanas + 1;
					FinSi
					//6
					si tablero[i,j+1] = 11 Entonces
						minasCercanas <- minasCercanas + 1;
					FinSi
					tablero[i,j] <- minasCercanas;
				FinSi
				minasCercanas <- 0;
			FinSi			
			//borde izquierdo
			si i <> 0 y i <> filas-1 y j = 0 Entonces
				si tablero[i,j] = 11 Entonces
					tablero[i,j] <- 11;
				SiNo
					//2
					si tablero[i-1,j] = 11 Entonces
						minasCercanas <- minasCercanas + 1;
					FinSi
					//3
					si tablero[i-1,j+1] = 11 Entonces
						minasCercanas <- minasCercanas + 1;
					FinSi
					//6
					si tablero[i,j+1] = 11 Entonces
						minasCercanas <- minasCercanas + 1;
					FinSi
					//8
					si tablero[i+1,j] = 11 Entonces
						minasCercanas <- minasCercanas + 1;
					FinSi
					//9
					si tablero[i+1,j+1] = 11 Entonces
						minasCercanas <- minasCercanas + 1;
					FinSi
					tablero[i,j] <- minasCercanas;
				FinSi
				minasCercanas <- 0;
			FinSi			
			//centro
			si i <> 0 y i <> filas-1 y j <> 0 y j <> columnas-1 Entonces
				si tablero[i,j] = 11 Entonces
					tablero[i,j] <- 11;
				SiNo
					//1
					si tablero[i-1,j-1] = 11 Entonces
						minasCercanas <- minasCercanas + 1;
					FinSi
					//2
					si tablero[i-1,j] = 11 Entonces
						minasCercanas <- minasCercanas + 1;
					FinSi
					//3
					si tablero[i-1,j+1] = 11 Entonces
						minasCercanas <- minasCercanas + 1;
					FinSi
					//4
					si tablero[i,j-1] = 11 Entonces
						minasCercanas <- minasCercanas + 1;
					FinSi
					//6
					si tablero[i,j+1] = 11 Entonces
						minasCercanas <- minasCercanas + 1;
					FinSi
					//7
					si tablero[i+1,j-1] = 11 Entonces
						minasCercanas <- minasCercanas + 1;
					FinSi
					//8
					si tablero[i+1,j] = 11 Entonces
						minasCercanas <- minasCercanas + 1;
					FinSi
					//9
					si tablero[i+1,j+1] = 11 Entonces
						minasCercanas <- minasCercanas + 1;
					FinSi
					tablero[i,j] <- minasCercanas;
				FinSi
			FinSi
			minasCercanas <- 0;
		FinPara
	FinPara
FinSubProceso

//Proceso para decubrir los lugares sin minas a los alrededores
SubProceso Exploracion(matrizAtras Por Referencia, matrizCortina Por Referencia, filas, columnas)
    Definir filasCoordenadas, columnasCoordenadas, i, j Como Entero;
    Definir gano, perdio Como Logico;
    perdio <- Falso;
    gano <- Falso;
    Repetir
        Repetir
            Limpiar Pantalla;
            //Vamos mostrando el tablero
            mostrarTablero(matrizAtras, matrizCortina, filas, columnas);
            //Esta parte es para que el usuario elija donde poner el puntero para desbloquear el tablero
            Escribir "";
            Escribir "      COORDENADAS A SELECCIONAR: ";
            Escribir "";
            Escribir "Para poner o quitar banderas ingrese -2";
            Escribir "        (menos 2, en simbolo)";
            Escribir "";
            Escribir Sin Saltar "       Fila: ";
            Leer filasCoordenadas; //Fila de posicion seleccionada
            
            Si filasCoordenadas = -2 Entonces
                colocarQuitarBandera(matrizAtras, matrizCortina, filas, columnas);
            SiNo
                Escribir Sin Saltar "       Columna: ";
                Leer columnasCoordenadas; //Columna de posicion seleccionada
                
                Si columnasCoordenadas = -2 Entonces
                    colocarQuitarBandera(matrizAtras, matrizCortina, filas, columnas);
                SiNo
                    // Validamos las coordenadas dentro del rango permitido
                    Si filasCoordenadas >= 1 y filasCoordenadas <= filas y columnasCoordenadas >= 1 y columnasCoordenadas <= columnas Entonces
                        filasCoordenadas <- filasCoordenadas - 1; // Ajustamos para que coincida con el índice de la matriz
                        columnasCoordenadas <- columnasCoordenadas - 1; // Ajustamos para que coincida con el índice de la matriz
                        
                        // Verificamos si hay una bandera en la posición seleccionada
                        Si matrizCortina(filasCoordenadas, columnasCoordenadas) = 2 Entonces
                            Escribir "      Hay una bandera";
                            filasCoordenadas <- -1; // Esto es para cuando el jugador seleccione una posición con una bandera, pueda seguir jugando en caso que sea una mina
                            Esperar 2 Segundos;
                        FinSi
                    FinSi
                FinSi
            FinSi
            // Este "Hasta que" cierra el bucle interior que se repite hasta que las coordenadas sean válidas
        Hasta Que filasCoordenadas <> -2 y columnasCoordenadas <> -2 y ((filasCoordenadas >= 0 y filasCoordenadas <= filas-1) y (columnasCoordenadas >= 0 y columnasCoordenadas <= columnas-1));
        
        Si matrizAtras(filasCoordenadas, columnasCoordenadas) = 11 Entonces // Si la posición seleccionada hay una mina (11) entonces pierde
            Limpiar Pantalla;
            perdio <- Verdadero;
            Escribir "    .__.       .___.    .____.  .______.  .__.    .__. ";
            Escribir "    |  |      / ._. \  /  .__|  |  ____|  |__|    |__| ";
            Escribir "    |  |     |  | |  | \___. \  |  __|      .______.   ";
            Escribir "    |  |___. |  |_|  | .___|  | |  |___.   /  .__.  \  ";
            Escribir "    |______|  \_____/  |_____/  |______|   \_/    \_/  ";
            Escribir "";
            Esperar  2 Segundos;
            mostrarTableroFinJuego(matrizAtras, matrizCortina, filas, columnas);
            Escribir "";
            Escribir "Oprima una tecla";
            Esperar Tecla;
        SiNo
            Limpiar Pantalla;
            Alrededor(matrizAtras, matrizCortina, filas, columnas, filasCoordenadas, columnasCoordenadas);
            gano <- ganaBuscaMina(matrizAtras, matrizCortina, filas, columnas);
            Si gano = Verdadero Entonces  // Si "gano" da Verdadero entonces
                Escribir "    ___              ___ .__. .___  .__.  ._. ._. ._.";
                Escribir "    \  \    ____    /  / |  | |   \ |  |  | | | | | |";
                Escribir "     \  \  /    \  /  /  |  | |    \|  |  | | | | | |";
                Escribir "      \  \/  /\  \/  /   |  | |  |\    |  |_| |_| |_|";
                Escribir "       \____/  \____/    |__| |__| \___|  |_| |_| |_|";
                Esperar  2 Segundos;
                Escribir "";
                mostrarTableroFinJuego(matrizAtras, matrizCortina, filas, columnas);                
                Escribir "Oprima una tecla";
                Esperar Tecla;
            FinSi
        FinSi        
    Hasta Que gano = Verdadero o perdio = Verdadero;
FinSubProceso 

//Este algoritmo es para que el jugador ingrese o quite una bandera
SubProceso colocarQuitarBandera(matrizAtras, matrizCortina Por Referencia, filas, columnas)
    Definir filasCoordenadas, columnasCoordenadas, siONo Como Entero;
    Definir dejarPonerBanderas Como Logico;
    filasCoordenadas <- 0;
    columnasCoordenadas <- 0;
    siONo <- 0;
    dejarPonerBanderas <- Falso;
    Limpiar Pantalla;
    Repetir
        Limpiar Pantalla;
        //Vamos mostrando el tablero
        mostrarTablero(matrizAtras, matrizCortina, filas, columnas);
        Escribir "";
        Escribir "En qué COORDENADAS quiere colocar o";
        Escribir "        quitar una bandera?: ";
        Escribir "";
        Escribir "Para dejar de poner banderas ingrese -1";
        Escribir "";
        Escribir Sin Saltar "      Fila: ";
        Leer filasCoordenadas; //Fila de posicion seleccionada
		
        Si filasCoordenadas = -1 Entonces
            dejarPonerBanderas <- Verdadero;
        SiNo
            Escribir Sin Saltar "      Columna: ";
            Leer columnasCoordenadas; //Columna de posicion seleccionada
			
            Si filasCoordenadas = -1 o columnasCoordenadas = -1 Entonces
                dejarPonerBanderas <- Verdadero;
            SiNo
                filasCoordenadas <- filasCoordenadas - 1; //Esto es para que tengan coherencia los numeros que elegimos con la matriz (si elije 1 como primera fila, para el algoritmo debe ser 0)
                columnasCoordenadas <- columnasCoordenadas - 1; //Esto es para que tengan coherencia los numeros que elegimos con la matriz
				
                Si (filasCoordenadas >= 0 y filasCoordenadas <= filas-1) y (columnasCoordenadas >= 0 y columnasCoordenadas <= columnas-1) Entonces
                    Si matrizCortina(filasCoordenadas, columnasCoordenadas) = 2 Entonces //Si en esta posición ya hay una bandera entonces
                        matrizCortina(filasCoordenadas, columnasCoordenadas) <- 0; //Lo muestra un lugar tapado
                    SiNo
                        Si matrizCortina(filasCoordenadas, columnasCoordenadas) = 1 Entonces //Si está destapado no puede colocar una bandera allí
                            Escribir "No es posible colocar una bandera aquí";
                            Esperar 2 Segundos;
                        SiNo
                            Si matrizCortina(filasCoordenadas, columnasCoordenadas) = 0 Entonces //Si está tapado entonces muestra una bandera
                                matrizCortina(filasCoordenadas, columnasCoordenadas) <- 2;
                            FinSi
                        FinSi
                    FinSi
                FinSi
            FinSi
        FinSi
    Hasta Que dejarPonerBanderas = Verdadero;
FinSubProceso

//Este algoritmo comprueba si gano o todavia no, el jugador
Funcion gano <- ganaBuscaMina(matrizAtras,matrizCortina,filas,columnas)
	Definir contFilas, contColumnas Como Entero;
	Definir gano Como Logico;
	gano <- Verdadero;
	contFilas <- 0;
	contColumnas <- 0;
	Mientras gano = Verdadero y contFilas <= filas-1 Hacer//Si no gano todavia o si las iteraciones llegan hasta las que tiene la matriz se corta el ciclo
		contColumnas <- 0;
		Mientras gano = Verdadero y contColumnas <= columnas-1 Hacer			//Si no gano todavia o si las iteraciones llegan hasta las que tiene la matriz se corta el ciclo
			si matrizCortina(contFilas,contColumnas) = 0 y matrizAtras(contFilas,contColumnas) <> 11 Entonces 
				gano <- Falso;	//si la matriz cortina esta tapada y en la matriz de numeros hay un numero distinto a 11			
			FinSi				//Entonces todavia no gano por lo tanto es falso
			contColumnas <- contColumnas + 1;
		FinMientras
		contFilas <- contFilas + 1;
	FinMientras
FinFuncion

//Busca los alrededores de una poscicion seleccionada si hay lugares adyasentes sin minas
SubProceso Alrededor(matrizAtras ,matrizCortina Por Referencia,filas,columnas,filasCoor,columnasCoor)
	Definir i,j Como Entero;
	Definir fila0,columna0 Como Entero;
	fila0 <- 0;
	columna0 <- 0;
	//Si la posicion seleccionada por el usuario es un numero solo muestra el numero
	si matrizAtras(filasCoor,columnasCoor) <> 0 Entonces
		si matrizAtras(filasCoor,columnasCoor) = 11 Entonces
			perdio <- Verdadero;
		SiNo
			si matrizCortina(filasCoor,columnasCoor) <> 2 Entonces //Si es distinto a 2 (osea si no hay una bandera) se muestra el espacio
				matrizCortina(filasCoor,columnasCoor) <- 1; 
			FinSi
		FinSi
	SiNo
		//Si es 0
		//Este lugar es para todos los espacios del medio, que no sean de los bordes del tablero
		si ((filasCoor <> 0 y filasCoor <> filas-1) y (columnasCoor <> 0 y columnasCoor <> columnas-1)) Entonces
			matrizCortina(filasCoor,columnasCoor) <- 1; //Se destapa la posicion seleccionada
			Para i <- 0 Hasta 2 Hacer		//3 filas
				Para j <- 0 Hasta 2 Hacer 	//3 columnas
					//Supongamos que el espacio elegido es la posicion (1,1) de una matriz 3x3
					//Entonces lo que va a este "para" es ir recorriendo esa matriz desde el primer numero (posicion (0,0)) con la 
					//ayuda de los axiliares "fila0" y "columna0" que permiten que itere desde la primer posicion
					//porque elegimos el espacio a este lo tomamos como si fuera el medio (1,1) pero necesitamos que este
					//desde el primero (0,0), por eso los axiliares tienen el valor: ( (1,1) + (-1,-1) = (0,0) ).
					fila0 <- -1;
					columna0 <- -1;
					//		 Esta posicion es el resultado de filasCoor o columnasCoor(poscion elegida por el usuario), 
					//		 fila0 o columna0(auxiliar para poscionamiento en (0,0) de una matriz 3x3) y i o j (para que itere como si fuera una matriz 3X3)
					//		 						|
					si matrizAtras(filasCoor + fila0 + i,columnasCoor + columna0 + j) = 0 y matrizCortina(filasCoor + fila0 + i,columnasCoor + columna0 + j) = 0 Entonces
						//Aqui utilizamos recursividad para que haga este prodedimento para todo lugar en blanco que haya
						//Porque es lo que hace el buscaminas libera toda la zona del lugar que el jugador elige en los 8 espacios
						//alrededor del mismo y si hay mas espacios vacios los hace con todos
						Alrededor(matrizAtras,matrizCortina,filas,columnas,(filasCoor + fila0 + i),(columnasCoor + columna0 + j));
					SiNo
						si matrizCortina(filasCoor + fila0 + i,columnasCoor + columna0 + j) <> 2 Entonces//Si no es una bandera entonces:
							matrizCortina(filasCoor + fila0 + i,columnasCoor + columna0 + j) <- 1;//Mostramos es espacio
						FinSi
					FinSi
				FinPara
			FinPara
		FinSi
		
		//Este lugar es para todos los espacios del borde superior del tablero,sin las esquinas
		si ((filasCoor = 0 ) y (columnasCoor <> 0 y columnasCoor <> columnas-1)) Entonces
			matrizCortina(filasCoor,columnasCoor) <- 1; //Se destapa la posicion seleccionada
			Para i <- 0 Hasta 1 Hacer		//2 filas
				Para j <- 0 Hasta 2 Hacer	//3 columnas
					//Supongamos que el espacio elegido es la posicion (0,1) de una matriz 2x3
					//Entonces lo que va a este "para" es ir recorriendo esa matriz desde el primer numero (posicion (0,0)) con la 
					//ayuda de los axiliares "fila0" y "columna0" que permiten que itere desde la primer posicion
					//porque elegimos el espacio a este lo tomamos como si fuera la posicion (0,1) pero necesitamos que este
					//desde la primera (0,0), por eso los axiliares tienen el valor:  ( (0,1) + (0,-1) = (0,0) ).
					fila0 <- 0;
					columna0 <- -1;
					//		 Esta posicion es el resultado de filasCoor o columnasCoor(poscion elegida por el usuario), 
					//		 fila0 o columna0(auxiliar para poscionamiento en (0,0) de una matriz 2x3) y i o j (para que itere como si fuera una matriz 3X3)
					//		 						v
					si matrizAtras(filasCoor + fila0 + i,columnasCoor + columna0 + j) = 0 y matrizCortina(filasCoor + fila0 + i,columnasCoor + columna0 + j) = 0 Entonces
						//Aqui utilizamos recursividad para que haga este prodedimento para todo lugar en blanco que haya
						//Porque es lo que hace el buscaminas libera toda la zona del lugar que el jugador elige en los 5 espacios
						//alrededor del mismo y si hay mas espacios vacios los hace con todos
						Alrededor(matrizAtras,matrizCortina,filas,columnas,(filasCoor + fila0 + i),(columnasCoor + columna0 + j));
					SiNo
						si matrizCortina(filasCoor + fila0 + i,columnasCoor + columna0 + j) <> 3 Entonces//Si no es una bandera entonces:
							matrizCortina(filasCoor + fila0 + i,columnasCoor + columna0 + j) <- 1;//Mostramos es espacio
						FinSi
					FinSi
				FinPara
			FinPara
		FinSi
		
		//Este lugar es para todos los espacios del borde inferior del tablero,sin las esquinas
		si ((filasCoor = filas -1 ) y (columnasCoor <> 0 y columnasCoor <> columnas-1)) Entonces
			matrizCortina(filasCoor,columnasCoor) <- 1; //Se destapa la posicion seleccionada
			Para i <- 0 Hasta 1 Hacer		//2 filas
				Para j <- 0 Hasta 2 Hacer	//3 columnas
					//Supongamos que el espacio elegido es la posicion (1,1) de una matriz 2x3
					//Entonces lo que va a este "para" es ir recorriendo esa matriz desde el primer numero (posicion (0,0)) con la 
					//ayuda de los axiliares "fila0" y "columna0" que permiten que itere desde la primer posicion
					//porque elegimos el espacio a este lo tomamos como si fuera la posicion (1,1) pero necesitamos que este
					//desde la primera (0,0), por eso los axiliares tienen el valor:  ( (1,1) + (-1,-1) = (0,0) ).
					fila0 <- -1;
					columna0 <- -1;
					//		 Esta posicion es el resultado de filasCoor o columnasCoor(poscion elegida por el usuario), 
					//		 fila0 o columna0(auxiliar para poscionamiento en (0,0) de una matriz 2x3) y i o j (para que itere como si fuera una matriz 2X3)
					//		 						v
					si matrizAtras(filasCoor + fila0 + i,columnasCoor + columna0 + j) = 0 y matrizCortina(filasCoor + fila0 + i,columnasCoor + columna0 + j) = 0 Entonces
						//Aqui utilizamos recursividad para que haga este prodedimento para todo lugar en blanco que haya
						//Porque es lo que hace el buscaminas libera toda la zona del lugar que el jugador elige en los 5 espacios
						//alrededor del mismo y si hay mas espacios vacios los hace con todos
						Alrededor(matrizAtras,matrizCortina,filas,columnas,(filasCoor + fila0 + i),(columnasCoor + columna0 + j));
					SiNo
						si matrizCortina(filasCoor + fila0 + i,columnasCoor + columna0 + j) <> 3 Entonces//Si no es una bandera entonces:
							matrizCortina(filasCoor + fila0 + i,columnasCoor + columna0 + j) <- 1;//Mostramos es espacio
						FinSi
					FinSi
				FinPara
			FinPara
		FinSi
		
		//Este lugar es para todos los espacios del borde derecho del tablero,sin las esquinas
		si ((filasCoor <> 0 y filasCoor <> filas-1) y (columnasCoor = 0)) Entonces
			matrizCortina(filasCoor,columnasCoor) <- 1; //Se destapa la posicion seleccionada
			Para i <- 0 Hasta 2 Hacer		//3 filas
				Para j <- 0 Hasta 1 Hacer	//2 columnas
					//Supongamos que el espacio elegido es la posicion (1,0) de una matriz 3x2
					//Entonces lo que va a este "para" es ir recorriendo esa matriz desde el primer numero (posicion (0,0)) con la 
					//ayuda de los axiliares "fila0" y "columna0" que permiten que itere desde la primer posicion
					//porque elegimos el espacio a este lo tomamos como si fuera la posicion (1,0) pero necesitamos que este
					//desde la primera (0,0), por eso los axiliares tienen el valor:  ( (1,0) + (-1,0) = (0,0) ).
					fila0 <- -1;
					columna0 <- 0;
					//		 Esta posicion es el resultado de filasCoor o columnasCoor(poscion elegida por el usuario), 
					//		 fila0 o columna0(auxiliar para poscionamiento en (0,0) de una matriz 3x2) y i o j (para que itere como si fuera una matriz 3x2)
					//		 						v
					si matrizAtras(filasCoor + fila0 + i,columnasCoor + columna0 + j) = 0 y matrizCortina(filasCoor + fila0 + i,columnasCoor + columna0 + j) = 0 Entonces
						//Aqui utilizamos recursividad para que haga este prodedimento para todo lugar en blanco que haya
						//Porque es lo que hace el buscaminas libera toda la zona del lugar que el jugador elige en los 5 espacios
						//alrededor del mismo y si hay mas espacios vacios los hace con todos
						Alrededor(matrizAtras,matrizCortina,filas,columnas,(filasCoor + fila0 + i),(columnasCoor + columna0 + j));
					SiNo
						si matrizCortina(filasCoor + fila0 + i,columnasCoor + columna0 + j) <> 3 Entonces//Si no es una bandera entonces:
							matrizCortina(filasCoor + fila0 + i,columnasCoor + columna0 + j) <- 1;//Mostramos es espacio
						FinSi
					FinSi
				FinPara
			FinPara
		FinSi
		
		//Este lugar es para todos los espacios del borde izquierdo del tablero,sin las esquinas
		si ((filasCoor <> 0 y filasCoor <> filas-1) y (columnasCoor = columnas-1)) Entonces
			matrizCortina(filasCoor,columnasCoor) <- 1; //Se destapa la posicion seleccionada
			Para i <- 0 Hasta 2 Hacer		//3 filas
				Para j <- 0 Hasta 1 Hacer	//2 columnas
					//Supongamos que el espacio elegido es la posicion (1,1) de una matriz 3x2
					//Entonces lo que va a este "para" es ir recorriendo esa matriz desde el primer numero (posicion (0,0)) con la 
					//ayuda de los axiliares "fila0" y "columna0" que permiten que itere desde la primer posicion
					//porque elegimos el espacio a este lo tomamos como si fuera la posicion (1,1) pero necesitamos que este
					//desde la primera (0,0), por eso los axiliares tienen el valor:  ( (1,1) + (-1,-1) = (0,0) ).
					fila0 <- -1;
					columna0 <- -1;
					//		 Esta posicion es el resultado de filasCoor o columnasCoor(poscion elegida por el usuario), 
					//		 fila0 o columna0(auxiliar para poscionamiento en (0,0) de una matriz 3x2) y i o j (para que itere como si fuera una matriz 3X2)
					//		 						v
					si matrizAtras(filasCoor + fila0 + i,columnasCoor + columna0 + j) = 0 y matrizCortina(filasCoor + fila0 + i,columnasCoor + columna0 + j) = 0 Entonces
						//Aqui utilizamos recursividad para que haga este prodedimento para todo lugar en blanco que haya
						//Porque es lo que hace el buscaminas libera toda la zona del lugar que el jugador elige en los 5 espacios
						//alrededor del mismo y si hay mas espacios vacios los hace con todos
						Alrededor(matrizAtras,matrizCortina,filas,columnas,(filasCoor + fila0 + i),(columnasCoor + columna0 + j));
					SiNo
						si matrizCortina(filasCoor + fila0 + i,columnasCoor + columna0 + j) <> 3 Entonces//Si no es una bandera entonces:
							matrizCortina(filasCoor + fila0 + i,columnasCoor + columna0 + j) <- 1;//Mostramos es espacio
						FinSi
					FinSi
				FinPara
			FinPara
		FinSi
		
		//Este lugar es para el espacio de la esquina superior derecha del tablero
		si ((filasCoor = 0 ) y (columnasCoor = 0)) Entonces
			matrizCortina(filasCoor,columnasCoor) <- 1; //Se destapa la posicion seleccionada
			Para i <- 0 Hasta 1 Hacer		//2 filas
				Para j <- 0 Hasta 1 Hacer	//2 columnas
					//Supongamos que el espacio elegido es la posicion (0,0) de una matriz 2x2
					//Entonces lo que va a este "para" es ir recorriendo esa matriz desde el primer numero (posicion (0,0)) con la 
					//ayuda de los axiliares "fila0" y "columna0" que permiten que itere desde la primer posicion
					//porque elegimos el espacio a este lo tomamos como si fuera la posicion (0,0) pero necesitamos que este
					//desde la primera (0,0), por eso los axiliares tienen el valor:  ( (0,0) + (0,0) = (0,0) ).
					fila0 <- 0;
					columna0 <- 0;
					//		 Esta posicion es el resultado de filasCoor o columnasCoor(poscion elegida por el usuario), 
					//		 fila0 o columna0(auxiliar para poscionamiento en (0,0) de una matriz 2x2) y i o j (para que itere como si fuera una matriz 2X2)
					//		 						v
					si matrizAtras(filasCoor + fila0 + i,columnasCoor + columna0 + j) = 0 y matrizCortina(filasCoor + fila0 + i,columnasCoor + columna0 + j) = 0 Entonces
						//Aqui utilizamos recursividad para que haga este prodedimento para todo lugar en blanco que haya
						//Porque es lo que hace el buscaminas libera toda la zona del lugar que el jugador elige en los 3 espacios
						//alrededor del mismo y si hay mas espacios vacios los hace con todos
						Alrededor(matrizAtras,matrizCortina,filas,columnas,(filasCoor + fila0 + i),(columnasCoor + columna0 + j));
					SiNo
						si matrizCortina(filasCoor + fila0 + i,columnasCoor + columna0 + j) <> 3 Entonces//Si no es una bandera entonces:
							matrizCortina(filasCoor + fila0 + i,columnasCoor + columna0 + j) <- 1;//Mostramos es espacio
						FinSi
					FinSi
				FinPara
			FinPara
		FinSi
		
		//Este lugar es para el espacio de la esquina superior izquierda del tablero
		si ((filasCoor = 0 ) y (columnasCoor = columnas-1)) Entonces
			matrizCortina(filasCoor,columnasCoor) <- 1; //Se destapa la posicion seleccionada
			Para i <- 0 Hasta 1 Hacer		//2 filas
				Para j <- 0 Hasta 1 Hacer	//2 columnas
					//Supongamos que el espacio elegido es la posicion (0,1) de una matriz 2x2
					//Entonces lo que va a este "para" es ir recorriendo esa matriz desde el primer numero (posicion (0,0)) con la 
					//ayuda de los axiliares "fila0" y "columna0" que permiten que itere desde la primer posicion
					//porque elegimos el espacio a este lo tomamos como si fuera la posicion (0,1) pero necesitamos que este
					//desde la primera (0,0), por eso los axiliares tienen el valor:  ( (0,1) + (0,-1) = (0,0) ).
					fila0 <- 0;
					columna0 <- -1;
					//		 Esta posicion es el resultado de filasCoor o columnasCoor(poscion elegida por el usuario), 
					//		 fila0 o columna0(auxiliar para poscionamiento en (0,0) de una matriz 2x2) y i o j (para que itere como si fuera una matriz 2X2)
					//		 						v
					si matrizAtras(filasCoor + fila0 + i,columnasCoor + columna0 + j) = 0 y matrizCortina(filasCoor + fila0 + i,columnasCoor + columna0 + j) = 0 Entonces
						//Aqui utilizamos recursividad para que haga este prodedimento para todo lugar en blanco que haya
						//Porque es lo que hace el buscaminas libera toda la zona del lugar que el jugador elige en los 3 espacios
						//alrededor del mismo y si hay mas espacios vacios los hace con todos
						Alrededor(matrizAtras,matrizCortina,filas,columnas,(filasCoor + fila0 + i),(columnasCoor + columna0 + j));
					SiNo
						si matrizCortina(filasCoor + fila0 + i,columnasCoor + columna0 + j) <> 3 Entonces//Si no es una bandera entonces:
							matrizCortina(filasCoor + fila0 + i,columnasCoor + columna0 + j) <- 1;//Mostramos es espacio
						FinSi
					FinSi
				FinPara
			FinPara
		FinSi
		
		//Este lugar es para el espacio de la esquina inferior derecha del tablero
		si ((filasCoor = filas-1 ) y (columnasCoor = 0)) Entonces
			matrizCortina(filasCoor,columnasCoor) <- 1; //Se destapa la posicion seleccionada
			Para i <- 0 Hasta 1 Hacer		//2 filas
				Para j <- 0 Hasta 1 Hacer	//2 columnas
					//Supongamos que el espacio elegido es la posicion (1,0) de una matriz 2x2
					//Entonces lo que va a este "para" es ir recorriendo esa matriz desde el primer numero (posicion (0,0)) con la 
					//ayuda de los axiliares "fila0" y "columna0" que permiten que itere desde la primer posicion
					//porque elegimos el espacio a este lo tomamos como si fuera la posicion (1,0) pero necesitamos que este
					//desde la primera (0,0), por eso los axiliares tienen el valor:  ( (1,0) + (-1,0) = (0,0) ).
					fila0 <- -1;
					columna0 <- 0;
					//		 Esta posicion es el resultado de filasCoor o columnasCoor(poscion elegida por el usuario), 
					//		 fila0 o columna0(auxiliar para poscionamiento en (0,0) de una matriz 2x2) y i o j (para que itere como si fuera una matriz 2X2)
					//		 						v
					si matrizAtras(filasCoor + fila0 + i,columnasCoor + columna0 + j) = 0 y matrizCortina(filasCoor + fila0 + i,columnasCoor + columna0 + j) = 0 Entonces
						//Aqui utilizamos recursividad para que haga este prodedimento para todo lugar en blanco que haya
						//Porque es lo que hace el buscaminas libera toda la zona del lugar que el jugador elige en los 3 espacios
						//alrededor del mismo y si hay mas espacios vacios los hace con todos
						Alrededor(matrizAtras,matrizCortina,filas,columnas,(filasCoor + fila0 + i),(columnasCoor + columna0 + j));
					SiNo
						si matrizCortina(filasCoor + fila0 + i,columnasCoor + columna0 + j) <> 3 Entonces//Si no es una bandera entonces:
							matrizCortina(filasCoor + fila0 + i,columnasCoor + columna0 + j) <- 1;//Mostramos es espacio
						FinSi
					FinSi
				FinPara
			FinPara
		FinSi
		
		//Este lugar es para el espacio de la esquina inferior izquierda del tablero
		si ((filasCoor = filas-1 ) y (columnasCoor = columnas-1)) Entonces
			matrizCortina(filasCoor,columnasCoor) <- 1; //Se destapa la posicion seleccionada
			Para i <- 0 Hasta 1 Hacer		//2 filas
				Para j <- 0 Hasta 1 Hacer	//2 columnas
					//Supongamos que el espacio elegido es la posicion (1,1) de una matriz 2x2
					//Entonces lo que va a este "para" es ir recorriendo esa matriz desde el primer numero (posicion (0,0)) con la 
					//ayuda de los axiliares "fila0" y "columna0" que permiten que itere desde la primer posicion
					//porque elegimos el espacio a este lo tomamos como si fuera la posicion (1,0) pero necesitamos que este
					//desde la primera (0,0), por eso los axiliares tienen el valor:  ( (1,1) + (-1,-1) = (0,0) ).
					fila0 <- -1;
					columna0 <- -1;
					//		 Esta posicion es el resultado de filasCoor o columnasCoor(poscion elegida por el usuario), 
					//		 fila0 o columna0(auxiliar para poscionamiento en (0,0) de una matriz 2x2) y i o j (para que itere como si fuera una matriz 2X2)
					//		 						v
					si matrizAtras(filasCoor + fila0 + i,columnasCoor + columna0 + j) = 0 y matrizCortina(filasCoor + fila0 + i,columnasCoor + columna0 + j) = 0 Entonces
						//Aqui utilizamos recursividad para que haga este prodedimento para todo lugar en blanco que haya
						//Porque es lo que hace el buscaminas libera toda la zona del lugar que el jugador elige en los 3 espacios
						//alrededor del mismo y si hay mas espacios vacios los hace con todos
						Alrededor(matrizAtras,matrizCortina,filas,columnas,(filasCoor + fila0 + i),(columnasCoor + columna0 + j));
					SiNo
						si matrizCortina(filasCoor + fila0 + i,columnasCoor + columna0 + j) <> 3 Entonces//Si no es una bandera entonces:
							matrizCortina(filasCoor + fila0 + i,columnasCoor + columna0 + j) <- 1;//Mostramos es espacio
						FinSi
					FinSi
				FinPara
			FinPara
		FinSi
	FinSi
FinSubProceso

//selecccionador de dificultades
SubProceso Dificultad(Filas Por Referencia,Columnas Por Referencia, minas Por Referencia)
	Definir num Como Entero;
	definir bool Como Logico;
	Repetir
		Escribir "    ____________________________________";
		Escribir "    |Seleccione el nivel de dificultad:|";
		Escribir "    |    /\_/\   1- FACIL              |";
		Escribir "    |   ( o.o )  2- NORMAL             |";
		Escribir "    |    > ^ <   3- DIFICIL            |";
		Escribir "    ------------------------------------";
		Leer num;
		bool <- Verdadero;
		Segun num Hacer
			1:
				Filas <- 8;
				Columnas <- 10;
				minas <- 10;
			2:
				Filas <- 14;
				Columnas <- 18;
				minas <- 40;
			3:
				Filas <- 20;
				Columnas <- 24;
				minas <- 99;
			De Otro Modo:
				Limpiar Pantalla;
				Escribir "";
				Escribir "    _______________________________";
				Escribir "    |Ingrese una dificultad valida|";
				Escribir "    -------------------------------";
				Esperar 2 Segundos;
				bool <- falso;
				Limpiar Pantalla;
		FinSegun
	Hasta Que bool = verdadero;
FinSubProceso

//Este Algoritmo es el que hace que funcione el buscaminas y todas sus funciones
SubProceso buscaMinas(nada)//Con un argumento vacio funciona
	Definir num Como Entero;
	Definir jugarOtraVez Como Logico;
	Definir matriz,matrizCortina,Filas,Columnas,minas Como Entero;
	Dimension matriz[30,30],matrizCortina[30,30];
	num <- 0;
	jugarOtraVez <- Verdadero;
	Repetir
		Filas <- 0;
		Columnas <- 0;
		minas <- 0;
		//Seleccionador de dificultad
		Dificultad(Filas,Columnas,minas);
		
		//Creamos primero el tablero de minas aleatorias
		CrearTableroMinasAleatorias(matriz,Filas,Columnas,minas);
		//En este tablero contamos cuantas minas tiene alrededor
		TableroDeMinasAdyacentes(matriz,Filas,Columnas);
		//Creamos el tablero cortina
		tableroCortina(matrizCortina,Filas,Columnas);
		
		//Explora el tablero
		Exploracion(matriz,matrizCortina,Filas,Columnas);
		Repetir
			Limpiar Pantalla;
			Escribir "";
			Escribir "Desea jugar otra vez? (1. Si, 2. No): ";
			Leer num;
		Hasta Que num = 1 o num = 2
		Segun num Hacer
			
			1:
				jugarOtraVez <- Verdadero;
			2:
				jugarOtraVez <- Falso;
		FinSegun		
		Limpiar Pantalla;
	Hasta Que jugarOtraVez = Falso
FinSubProceso



SubProceso juegoBuscaminas
	Definir a Como Entero;
	a <- 0;
	buscaMinas(a);
FinSubProceso
