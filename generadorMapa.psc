Proceso Principal
    Definir tam, n Como Entero;
    Definir laberinto, estadoOriginal Como Caracter;
    Dimension laberinto(20,20);
    Dimension estadoOriginal(20,20);
    tam <- 20; // Tamaño del laberinto
    poblarLaberinto(tam, laberinto);
    
    Escribir "Creando Mundo...";
	Escribir "";
    
	
    Mientras no esConectado(tam, laberinto) Hacer
		poblarLaberinto(tam, laberinto);
		Para n <- 0 Hasta 4 Hacer
			aplicarReglas(tam, laberinto);
		FinPara
	
	FinMientras
    // Limpiar alrededores de la entrada y la salida
    laberinto(0,1) <- " ";
    laberinto(1,0) <- " ";
    laberinto(1,1) <- " ";
    
    laberinto((tam-1),(tam-1)-1) <- " ";
    laberinto((tam-1)-1,(tam-1)) <- " ";
    laberinto((tam-1)-1,(tam-1)-1) <- " ";
	
	poblarLaberintoEnemigos(tam, laberinto);

    
    mostrarLaberinto(tam, laberinto);
	
	//Confirmación
    Si esConectado(tam, laberinto) Entonces
        Escribir "La entrada y la salida están conectadas.";
    Sino
        Escribir "La entrada y la salida no están conectadas.";
    FinSi
	


FinProceso

SubProceso poblarLaberinto(tam,laberinto)
	Definir fila, columna Como Entero;
	Definir bloques Como Caracter;
	Dimension bloques(3);
	bloques(0) <- " "; //Espacio en blanco
	bloques(1) <- " "; //Segundo espacio (es necesario porque da 66 porciento de probabilidad de que genere un espacio y hace más rapido el proceso)
	bloques(2) <- "X"; 
	Para fila <- 0 Hasta tam-1 Hacer
		Para columna <- 0 Hasta tam-1 Hacer
			laberinto(fila, columna) <- bloques(azar(3));
		FinPara
	FinPara
FinSubProceso

SubProceso vecinos <- contarVecinos(fila, columna, tam, laberinto)
    Definir vecinos Como Entero;
    Definir k, ni, nj Como Entero;
    Definir dx Como Entero;
    Definir dy Como Entero;
    Dimension dx(8);
    Dimension dy(8);
    vecinos <- 0;
    
    dx(0) <- -1; dy(0) <- -1;
    dx(1) <- -1; dy(1) <- 0;
    dx(2) <- -1; dy(2) <- 1;
    dx(3) <- 0; dy(3) <- -1;
    dx(4) <- 0; dy(4) <- 1;
    dx(5) <- 1; dy(5) <- -1;
    dx(6) <- 1; dy(6) <- 0;
    dx(7) <- 1; dy(7) <- 1;
    
    Para k <- 0 Hasta 7 Hacer
        ni <- fila + dx(k);
        nj <- columna + dy(k);
        
        // Verificar si el vecino está dentro de los límites
        Si ni >= 1 Y ni <= tam-1 Y nj >= 1 Y nj <= tam-1 Entonces
            Si laberinto(ni, nj) = "X" Entonces
                vecinos <- vecinos + 1;
            FinSi
        FinSi
    FinPara
    
FinSubProceso

SubProceso poblarLaberintoEnemigos(tam, laberinto)
    Definir fila, columna Como Entero;
    Definir contadorE Como Entero;
    Definir posicionFila, posicionColumna Como Entero;
    contadorE <- 0;

    Mientras contadorE < 20 Hacer
        posicionFila <- Azar(tam-1); // Genera una fila aleatoria
        posicionColumna <- Azar(tam-1); // Genera una columna aleatoria

        Si laberinto(posicionFila, posicionColumna) = " " Entonces
            laberinto(posicionFila, posicionColumna) <- "E";
            contadorE <- contadorE + 1;
        FinSi
    FinMientras
FinSubProceso



SubProceso aplicarReglas(tam, laberinto) 
    Definir fila, columna Como Entero;
    
    // Reglas 4-5
    Para fila <- 1 Hasta tam-1 Hacer
        Para columna <- 1 Hasta tam-1 Hacer
            Si laberinto(fila, columna) = "X" y contarVecinos(fila, columna, tam, laberinto) >= 4 o laberinto(fila, columna) = " " y contarVecinos(fila, columna, tam, laberinto) >= 5 Entonces
                laberinto(fila, columna) <- "X";
            FinSi
        FinPara
    FinPara
    
    // Punto de entrada y de salida
    laberinto(0,0) <- "C";
    laberinto(tam-1,tam-1) <- "[";
        
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

SubProceso conectado <- esConectado(tam, laberinto)
    Definir visitado Como Logico;
    Dimension visitado(20, 20);
    Definir fila, columna Como Entero;
    Definir conectado Como Logico;
    
    // Inicializar el arreglo de visitados
    Para fila <- 0 Hasta tam-1 Hacer
        Para columna <- 0 Hasta tam-1 Hacer
            visitado(fila, columna) <- Falso;
        FinPara
    FinPara
    
    // Inicializar DFS desde la entrada
    conectado <- DFS(0, 0, tam, laberinto, visitado);
    
FinSubProceso

SubProceso encontrado <- DFS(fila, columna, tam, laberinto, visitado)
    Definir dx, dy Como Entero;
    Definir nx, ny Como Entero;
    Definir k Como Entero;
    Dimension dx(4);
    Dimension dy(4);
    Definir encontrado Como Logico;
    
    // Movimientos posibles (derecha, abajo, izquierda, arriba)
    dx(0) <- 1; dy(0) <- 0;
    dx(1) <- 0; dy(1) <- 1;
    dx(2) <- -1; dy(2) <- 0;
    dx(3) <- 0; dy(3) <- -1;
    
    // Si se llega a la salida
    Si fila = tam-1 Y columna = tam-1 Entonces
        encontrado <- Verdadero;
    Sino
        // Marcar como visitado
        visitado(fila, columna) <- Verdadero;
        encontrado <- Falso;
        
        // Probar cada movimiento posible
        Para k <- 0 Hasta 3 Hacer
            nx <- fila + dx(k);
            ny <- columna + dy(k);
            
            // Verificar si el siguiente paso es válido
            Si nx >= 0 Y nx < tam Y ny >= 0 Y ny < tam Y no visitado(nx, ny) Y laberinto(nx, ny) <> "X" Entonces
                encontrado <- DFS(nx, ny, tam, laberinto, visitado);
                Si encontrado Entonces
                    k <- 4; // Salir del bucle para evitar seguir buscando
                FinSi
            FinSi
        FinPara
    FinSi
	
FinSubProceso

