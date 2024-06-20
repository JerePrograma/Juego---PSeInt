Proceso Principal
    Definir tam, n Como Entero;
    Definir laberinto, visitado Como Caracter;
    Dimension laberinto(10,10);
    Dimension visitado(10,10);
    tam <- 10; // Tamaño del laberinto
	
    // Inicializar laberinto y visitado
    llenarLaberinto(tam, laberinto);
    mostrarLaberinto(tam, laberinto);
    Escribir "---------------------------------";
    InicializarVisitado(tam, visitado);
    mostrarLaberinto(tam, laberinto);
    Escribir "---------------------------------";
	
    // Crear un camino desde [0,0] hasta [9,9]
    crearCamino(tam, laberinto, visitado);
    Escribir "---------------------------------";
	
    // Marcar posiciones de inicio y fin
    laberinto(0, 0) <- "C";
    laberinto(9, 9) <- "[";
    
    // Mostrar el laberinto inicial
    Escribir "";
    mostrarLaberinto(tam, laberinto);
    Escribir "";
	
    // Aplicar reglas adicionales para afinar el laberinto
    Para n <- 0 Hasta 5 Hacer
        aplicarReglas(tam, laberinto);
    FinPara
	
    // Mostrar el laberinto final
    Escribir "";
    mostrarLaberinto(tam, laberinto);
FinProceso

SubProceso llenarLaberinto(tam, laberinto)
    Definir fila, columna Como Entero;
    Para fila <- 0 Hasta tam-1 Hacer
        Para columna <- 0 Hasta tam-1 Hacer
            laberinto(fila, columna) <- "X"; // Inicializar todo con paredes
        FinPara
    FinPara
FinSubProceso

SubProceso InicializarVisitado(tam, visitado)
    Definir fila, columna Como Entero;
    Para fila <- 0 Hasta tam-1 Hacer
        Para columna <- 0 Hasta tam-1 Hacer
            visitado(fila, columna) <- "N"; // Inicializar todo como no visitado
        FinPara
    FinPara
FinSubProceso

SubProceso crearCamino(tam, laberinto, visitado)
    // Crear un camino desde [0,0] hasta [9,9] usando DFS
    Definir exito Como Logico;
    exito <- crearCaminoDFS(0, 0, tam, laberinto, visitado);
    Si exito = Falso Entonces
        Escribir "No se pudo generar un camino válido.";
    FinSi
FinSubProceso

Funcion exito <- crearCaminoDFS(fila, columna, tam, laberinto, visitado)
    Definir dir, nuevaFila, nuevaColumna Como Entero;
    Definir exito Como Logico;
    Definir direcciones Como Entero;
    Dimension direcciones(4, 2);
    Definir randomIndex, tempX, tempY Como Entero;
	
    // Direcciones: derecha, abajo, izquierda, arriba
    direcciones(0, 0) <- 0; direcciones(0, 1) <- 1;
    direcciones(1, 0) <- 1; direcciones(1, 1) <- 0;
    direcciones(2, 0) <- 0; direcciones(2, 1) <- -1;
    direcciones(3, 0) <- -1; direcciones(3, 1) <- 0;
	
    // Marcar como visitado y abrir el camino
    visitado(fila, columna) <- "S";
    laberinto(fila, columna) <- " ";
	
    // Si hemos llegado al final, el camino es exitoso
    Si fila = tam-1 Y columna = tam-1 Entonces
        exito <- Verdadero;
    Sino
        // Mezclar direcciones para obtener caminos aleatorios
        Para dir <- 0 Hasta 3 Hacer
            randomIndex <- Azar(4);
            tempX <- direcciones(dir, 0);
            tempY <- direcciones(dir, 1);
            direcciones(dir, 0) <- direcciones(randomIndex, 0);
            direcciones(randomIndex, 0) <- tempX;
            direcciones(dir, 1) <- direcciones(randomIndex, 1);
            direcciones(randomIndex, 1) <- tempY;
        FinPara
		
        // Intentar moverse en cada dirección
        exito <- Falso;
        Para dir <- 0 Hasta 3 Hacer
            nuevaFila <- fila + direcciones(dir, 0);
            nuevaColumna <- columna + direcciones(dir, 1);
            Si nuevaFila >= 0 Y nuevaFila < tam Y nuevaColumna >= 0 Y nuevaColumna < tam Entonces
                Si visitado(nuevaFila, nuevaColumna) = "N" Entonces
                    exito <- crearCaminoDFS(nuevaFila, nuevaColumna, tam, laberinto, visitado);
                    Si exito Entonces
                        dir <- 3; // Para salir del bucle
                    FinSi
                FinSi
            FinSi
        FinPara
		
        // Si ninguna dirección tuvo éxito, retroceder
        Si exito = Falso Entonces
            laberinto(fila, columna) <- "X";
            visitado(fila, columna) <- "N";
        FinSi
    FinSi
FinFuncion

SubProceso aplicarReglas(tam, laberinto)
    Definir fila, columna Como Entero;
    // Reglas 4-5
    Para fila <- 1 Hasta tam-2 Hacer
        Para columna <- 1 Hasta tam-2 Hacer
            Si (laberinto(fila, columna) = "X" Y contarVecinos(fila, columna, tam, laberinto) >= 4) O (laberinto(fila, columna) = " " Y contarVecinos(fila, columna, tam, laberinto) >= 5) Entonces
                laberinto(fila, columna) <- "X";
            FinSi
        FinPara
    FinPara
FinSubProceso

Funcion vecinos <- contarVecinos(fila, columna, tam, laberinto)
    Definir vecinos Como Entero;
    Definir k, ni, nj, dx, dy Como Entero;
    Dimension dx(4);
    Dimension dy(4);
    vecinos <- 0;
	
    // Solo consideramos las 4 direcciones cardinales
    dx(0) <- -1; dy(0) <- 0;
    dx(1) <- 1; dy(1) <- 0;
    dx(2) <- 0; dy(2) <- -1;
    dx(3) <- 0; dy(3) <- 1;
	
    Para k <- 0 Hasta 3 Hacer
        ni <- fila + dx(k);
        nj <- columna + dy(k);
        // Verificar si el vecino está dentro de los límites
        Si ni >= 0 Y ni < tam Y nj >= 0 Y nj < tam Entonces
            Si laberinto(ni, nj) = "X" Entonces
                vecinos <- vecinos + 1;
            FinSi
        FinSi
    FinPara
FinFuncion

SubProceso mostrarLaberinto(tam, laberinto)
    Definir fila, columna Como Entero;
    Para fila <- 0 Hasta tam-1 Hacer
        Para columna <- 0 Hasta tam-1 Hacer
            Escribir "[", laberinto(fila, columna), "] " Sin Saltar;
        FinPara
        Escribir ""; // Salto de línea después de cada fila
    FinPara
FinSubProceso
