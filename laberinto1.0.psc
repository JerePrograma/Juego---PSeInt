//----------------------------------------------------
//------------------   CONSTANTES   ------------------
//----------------------------------------------------

SubProceso ESTADO_INICIAL <- obtenerEstadoInicial
    Definir ESTADO_INICIAL Como Caracter;
    ESTADO_INICIAL <- "0000";
FinSubProceso

SubProceso ESTADO_TECLA_INVALIDA <- obtenerEstadoTeclaInvalida
    Definir ESTADO_TECLA_INVALIDA Como Caracter;
    ESTADO_TECLA_INVALIDA <- "0001";
FinSubProceso

SubProceso ESTADO_MOVIMIENTO_INVALIDO <- obtenerEstadoMovimientoInvalido
    Definir ESTADO_MOVIMIENTO_INVALIDO Como Caracter;
    ESTADO_MOVIMIENTO_INVALIDO <- "0002";
FinSubProceso

SubProceso ESTADO_COLISION_PARED <- obtenerEstadoColisionPared
    Definir ESTADO_COLISION_PARED Como Caracter;
    ESTADO_COLISION_PARED <- "0003";
FinSubProceso

SubProceso ESTADO_MOSTRAR_ESTADISTICAS <- obtenerEstadoMostrarEstadisticas
    Definir ESTADO_MOSTRAR_ESTADISTICAS Como Caracter;
    ESTADO_MOSTRAR_ESTADISTICAS <- "0004";
FinSubProceso


//----------------------------------------------------
//---------------------  INICIO  ---------------------
//----------------------------------------------------

Proceso Principal
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

//----------------------------------------------------
//---------------------   JUEGO   --------------------
//----------------------------------------------------

SubProceso juegoLaberinto
    //Datos Personaje:
    Definir vida, experiencia, fuerza, defensa, nivel, agilidad, inteligencia Como Entero;
    Definir nombre, estado Como Caracter;
    
    //Datos Laberinto
    Definir tamLaberinto Como Entero;
    Definir laberinto, estadoOriginal Como Caracter;
    Dimension laberinto(20,20);
    Dimension estadoOriginal(20,20);
    tamLaberinto <- 20; // Tamaño del laberinto
    
    inicializarLaberinto(tamLaberinto, laberinto);
    inicializarEstadoOriginal(tamLaberinto, laberinto, estadoOriginal);
    
    // Inicializar enemigos en el laberinto
    colocarEnemigosAleatorios(tamLaberinto, laberinto, estadoOriginal, 4); // Colocar 3 enemigos aleatorios
    
    // Mostrar el laberinto
    mostrarLaberinto(tamLaberinto, laberinto);
    
    creacionPersonaje(nombre, vida, experiencia, fuerza, defensa, agilidad, inteligencia, nivel, estado);
    seguimiento(nombre, vida, experiencia, fuerza, defensa, agilidad, inteligencia, nivel, estado, tamLaberinto, laberinto, estadoOriginal);
FinSubProceso


//----------------------------------------------------
//-------------  INICIALIZAR LABERINTO  --------------
//----------------------------------------------------

SubProceso inicializarLaberinto(tam, laberinto)
	
    Definir tamLaberinto Como Entero;
    Definir n Como Entero;
    tamLaberinto <- tam; // Usar el parámetro tam pasado al subproceso
    poblarLaberinto(tamLaberinto, laberinto);
    
    Escribir "Creando Mundo...";
    Escribir "";
    ilustracionMenu;
    Mientras no esConectado(tamLaberinto, laberinto) Hacer
        poblarLaberinto(tamLaberinto, laberinto);
        Para n <- 0 Hasta 4 Hacer
            aplicarReglas(tamLaberinto, laberinto);
        FinPara
    FinMientras
    
    // Limpiar alrededores de la entrada y la salida
    laberinto(0,1) <- " ";
    laberinto(1,0) <- " ";
    laberinto(1,1) <- " ";
    
    laberinto((tamLaberinto-1),(tamLaberinto-1)-1) <- " ";
    laberinto((tamLaberinto-1)-1,(tamLaberinto-1)) <- " ";
    laberinto((tamLaberinto-1)-1,(tamLaberinto-1)-1) <- " ";
    laberinto(tam-1,tam-1) <- "[";
    poblarLaberintoEnemigos(tamLaberinto, laberinto);
	Borrar Pantalla;
FinSubProceso

SubProceso inicializarEstadoOriginal(tam, laberinto, estadoOriginal)
    Definir fila, columna Como Entero;
    Para fila <- 0 Hasta tam-1 Hacer
        Para columna <- 0 Hasta tam-1 Hacer
            estadoOriginal(fila, columna) <- laberinto(fila, columna);
        FinPara
    FinPara
FinSubProceso

SubProceso colocarEnemigosAleatorios(tam, laberinto, estadoOriginal, cantidadEnemigos)
    Definir enemigoPosX, enemigoPosY Como Entero;
    Definir contador Como Entero;
    contador <- 0;
    Mientras contador < cantidadEnemigos Hacer
        enemigoPosX <- lanzarDado(0, tam-1);
        enemigoPosY <- lanzarDado(0, tam-1);
        Si laberinto(enemigoPosX, enemigoPosY) = " " Entonces
            laberinto(enemigoPosX, enemigoPosY) <- "E";
            estadoOriginal(enemigoPosX, enemigoPosY) <- " "; // Actualizar el estadoOriginal con un espacio
            contador <- contador + 1;
        FinSi
    FinMientras
FinSubProceso


//----------------------------------------------------
//---------------  CREACION PERSONAJE  ---------------
//----------------------------------------------------

SubProceso creacionPersonaje(nombrePersonaje Por Referencia, vidaPersonaje Por Referencia, experienciaPersonaje Por Referencia, fuerzaPersonaje Por Referencia, defensaPersonaje Por Referencia, agilidadPersonaje Por Referencia, inteligenciaPersonaje Por Referencia, nivelPersonaje Por Referencia, estadoPersonaje Por Referencia)
    mostrarMensajeIngresarNombre();
    Leer nombrePersonaje;
    inicializarEstadisticas(nombrePersonaje, vidaPersonaje, experienciaPersonaje, fuerzaPersonaje, defensaPersonaje, agilidadPersonaje, inteligenciaPersonaje, nivelPersonaje, estadoPersonaje);
    mostrarMensajeEstadisticasPersonaje(nombrePersonaje, vidaPersonaje, experienciaPersonaje, fuerzaPersonaje, defensaPersonaje, agilidadPersonaje, inteligenciaPersonaje, nivelPersonaje, estadoPersonaje);
	animacionPersonaje;
    Escribir "Presione una tecla para continuar";
    Esperar Tecla;
FinSubProceso

// Proceso principal para crear un personaje con atributos basados en D&D 5e 
SubProceso inicializarEstadisticas(nombrePersonaje, vidaPersonaje Por Referencia, experienciaPersonaje Por Referencia, fuerzaPersonaje Por Referencia, defensaPersonaje Por Referencia, agilidadPersonaje Por Referencia, inteligenciaPersonaje Por Referencia, nivelPersonaje Por Referencia, estadoPersonaje Por Referencia)
    
    // Inicializamos la vida y experiencia base
    vidaPersonaje <- 10 + sumaTresMayoresD6(); // Base de 10 más bonificación
    experienciaPersonaje <- 0;
    nivelPersonaje <- 1;
    estadoPersonaje <- "Normal";
    
    // Ajustamos cada atributo con la suma de los tres mayores de 4d6
    // y aseguramos que estén en el rango de 0 a 20
    fuerzaPersonaje <- ajustarAtributo(sumaTresMayoresD6());
    defensaPersonaje <- ajustarAtributo(sumaTresMayoresD6());
    agilidadPersonaje <- ajustarAtributo(sumaTresMayoresD6());
    inteligenciaPersonaje <- ajustarAtributo(sumaTresMayoresD6());
    
FinSubProceso

//----------------------------------------------------
//--------------------  EJECUCION  -------------------
//----------------------------------------------------

SubProceso seguimiento(nombrePersonaje Por Referencia, vidaPersonaje Por Referencia, experienciaPersonaje Por Referencia, fuerzaPersonaje Por Referencia, defensaPersonaje Por Referencia, agilidadPersonaje Por Referencia, inteligenciaPersonaje Por Referencia, nivelPersonaje Por Referencia, estadoPersonaje Por Referencia, tam, laberinto, estadoOriginal)
    Definir posX, posY, posXNueva, posYNueva Como Entero;
    Definir simboloJugador, estadoAccion Como Caracter;
    Definir juegoActivo Como Logico;
    simboloJugador <- "J";
    juegoActivo <- Verdadero;
    estadoAccion <- "0000";
    
    posX <- 0; posY <- 0;  // Asumiendo que el jugador empieza en la esquina superior izquierda
    laberinto(posX, posY) <- simboloJugador;  // Colocamos al jugador en la posición inicial
    
    Mientras juegoActivo Hacer
        Limpiar Pantalla;
        mostrarLaberinto(tam, laberinto);
        posXNueva <- posX;  // Preparar las nuevas posiciones
        posYNueva <- posY;
        
        // Obtener la nueva posición basada en la entrada del usuario
        presionar(estadoAccion, posX, posY, posXNueva, posYNueva, simboloJugador, laberinto, tam);
        
        // Verificar y actualizar la posición
        Si posXNueva <> posX O posYNueva <> posY Entonces  // Si hay un cambio de posición
            evaluarPosicion(tam, laberinto, estadoOriginal, posXNueva, posYNueva, posX, posY, simboloJugador, juegoActivo, nombrePersonaje, vidaPersonaje, experienciaPersonaje, fuerzaPersonaje, defensaPersonaje, agilidadPersonaje, inteligenciaPersonaje, nivelPersonaje, estadoPersonaje);
            Si juegoActivo Entonces
                // Actualizar las posiciones antiguas y nuevas
                posX <- posXNueva;
                posY <- posYNueva;
            FinSi
        Sino
            Si estadoAccion = "0004" Entonces
                mostrarMensajeEstadisticasPersonaje(nombrePersonaje, vidaPersonaje, experienciaPersonaje, fuerzaPersonaje, defensaPersonaje, agilidadPersonaje, inteligenciaPersonaje, nivelPersonaje, estadoPersonaje);
                Escribir "Presione una tecla para continuar";
                Esperar Tecla;
            FinSi
        FinSi
    FinMientras;
FinSubProceso

SubProceso presionar(estadoAccion Por Referencia, posX, posY, posXNueva Por Referencia, posYNueva Por Referencia, simboloJugador, laberinto, tam)
    Definir eleccionLetra, direccion Como Caracter;
    Definir eleccionNumero Como Entero;
    
    mostrarMensajeAccionesMapa(estadoAccion);
    Leer eleccionLetra;
    
    eleccionLetra <- Minusculas(eleccionLetra);
    Si      eleccionLetra = "a" Entonces
        eleccionNumero <- 1;
    Sino Si eleccionLetra = "s" Entonces
            eleccionNumero <- 2;
        Sino Si eleccionLetra = "d" Entonces
                eleccionNumero <- 3;
            Sino Si eleccionLetra = "w" Entonces
                    eleccionNumero <- 4;
                Sino Si eleccionLetra = "e" Entonces
                        eleccionNumero <- 5;
                    Sino
                        eleccionNumero <- -1; // Invalid
                    FinSi
                FinSi
            FinSi
        FinSi
    FinSi
    
    Segun eleccionNumero Hacer
        1:  // Izquierda
            Si posY > 0 Entonces
                Si laberinto(posX, posY - 1) <> "X" Entonces
                    posYNueva <- posY - 1;
                    estadoAccion <- "0000";
                Sino
                    estadoAccion <- "0003";
                FinSi
            Sino
                estadoAccion <- "0002";
            FinSi
        2:  // Abajo
            Si posX < tam - 1 Entonces
                Si laberinto(posX + 1, posY) <> "X" Entonces
                    posXNueva <- posX + 1;
                    estadoAccion <- "0000";
                Sino
                    estadoAccion <- "0003";
                FinSi
            Sino
                estadoAccion <- "0002";
            FinSi
        3:  // Derecha
            Si posY < tam - 1 Entonces
                Si laberinto(posX, posY + 1) <> "X" Entonces
                    posYNueva <- posY + 1;
                    estadoAccion <- "0000";
                Sino
                    estadoAccion <- "0003";
                FinSi
            Sino
                estadoAccion <- "0002";
            FinSi
        4:  // Arriba
            Si posX > 0 Entonces
                Si laberinto(posX - 1, posY) <> "X" Entonces
                    posXNueva <- posX - 1;
                    estadoAccion <- "0000";
                Sino
                    estadoAccion <- "0003";
                FinSi
            Sino
                estadoAccion <- "0002";
            FinSi
        5:
            estadoAccion <- "0004";
        De Otro Modo:
            estadoAccion <- "0001";
    FinSegun
FinSubProceso

SubProceso evaluarPosicion(tam, laberinto, estadoOriginal, posXNueva, posYNueva, posX, posY, simboloJugador, juegoActivo Por Referencia, nombrePersonaje, vidaPersonaje, experienciaPersonaje, fuerzaPersonaje, defensaPersonaje, agilidadPersonaje, inteligenciaPersonaje, nivelPersonaje, estadoPersonaje)
    Si laberinto(posXNueva, posYNueva) = "X" Entonces
        mostrarMensaje("¡Hay una pared aquí!");
        posXNueva <- posX; // Revertir el movimiento
        posYNueva <- posY;
    Sino
        Si laberinto(posXNueva, posYNueva) = "E" Entonces
            mostrarMensaje("¡Un enemigo! Prepárate para luchar");
            Esperar 2 Segundos;
            pelea(nombrePersonaje, vidaPersonaje, experienciaPersonaje, fuerzaPersonaje, defensaPersonaje, agilidadPersonaje, inteligenciaPersonaje, nivelPersonaje, estadoPersonaje);
            laberinto(posX, posY) <- estadoOriginal(posX, posY); // Actualizar la posición anterior del jugador
            laberinto(posXNueva, posYNueva) <- simboloJugador; // Mover el jugador a la nueva posición
            estadoOriginal(posXNueva, posYNueva) <- " "; // Actualizar estadoOriginal
        Sino
            Si laberinto(posXNueva, posYNueva) = "[" Entonces
                BuscaHongos();
                mostrarMensaje("¡Llegaste, descansa en esta hoguera guerrero!");
                juegoActivo <- Falso;
            Sino
                laberinto(posX, posY) <- estadoOriginal(posX, posY); // Actualizar la posición anterior del jugador
                laberinto(posXNueva, posYNueva) <- simboloJugador; // Mover el jugador a la nueva posición
            FinSi;
        FinSi;
    FinSi;
    Limpiar Pantalla;
FinSubProceso


// Incluimos una función para simular el lanzamiento de un dado de 6 caras
Funcion enteroAleatorio <- lanzarDado(minimo,maximo)
    Definir enteroAleatorio Como Entero;
    enteroAleatorio <- Aleatorio(minimo, maximo);
FinFuncion

// Función para obtener la suma de los tres mayores de cuatro dados D6
Funcion suma <- sumaTresMayoresD6
    Definir dado1, dado2, dado3, dado4 Como Entero;
    Definir menor, suma Como Entero;
    // Lanzamos cuatro dados
    dado1 <- lanzarDado(1,6);
    dado2 <- lanzarDado(1,6);
    dado3 <- lanzarDado(1,6);
    dado4 <- lanzarDado(1,6);
    
    // Encontramos el menor de los cuatro lanzamientos
    menor <- dado1;
    Si menor > dado2 Entonces
        menor <- dado2;
    FinSi
    Si menor > dado3 Entonces
        menor <- dado3;
    FinSi
    Si menor > dado4 Entonces
        menor <- dado4;
    FinSi
    
    // Sumamos todos los dados y restamos el menor
    suma <- dado1 + dado2 + dado3 + dado4 - menor;
FinFuncion

// Función para ajustar un atributo a estar dentro del rango de 0 a 20
Funcion value <- ajustarAtributo(value)
    Si value < 0 Entonces
        value <- 0;
    Sino Si value > 20 Entonces
            value <- 20;
        FinSi
    FinSi
FinFuncion

SubProceso pelea(nombrePersonaje, vidaPersonaje Por Referencia, experienciaPersonaje Por Referencia, fuerzaPersonaje Por Referencia, defensaPersonaje Por Referencia, agilidadPersonaje Por Referencia, inteligenciaPersonaje Por Referencia, nivelPersonaje Por Referencia, estadoPersonaje)
    Definir vidaEnemigo, fuerzaEnemigo, defensaEnemigo, agilidadEnemigo, inteligenciaEnemigo, eleccionNumero, valorDadoPersonaje, valorDadoEnemigo, danioRecibidoPersonaje, danioAlEnemigo, danioRecibidoEnemigo, vidaMaximaPersonaje Como Entero;
	Definir eleccion Como Caracter;
    // Obtener las características del enemigo
    inicializarEnemigo(vidaEnemigo, fuerzaEnemigo, defensaEnemigo, agilidadEnemigo, inteligenciaEnemigo);
    vidaMaximaPersonaje <- vidaPersonaje;
    // Simulación del combate (aquí puedes agregar la lógica del combate)
    Escribir "Vida del enemigo: ", vidaEnemigo;
    Mientras vidaEnemigo > 0 Y vidaPersonaje > 0 Hacer
		danioRecibidoPersonaje <- 0;
		danioRecibidoEnemigo <- 0;
		danioAlEnemigo <- 0;
		Repetir
			mostrarMensajeAccionesPelea;
			Leer eleccion;
			Si eleccion = "a" O eleccion = "A" Entonces
				eleccionNumero <- 1;
			SiNo
				Si eleccion = "d" O eleccion = "D" Entonces
					eleccionNumero <- 2;
				SiNo
					Si eleccion = "e" O eleccion = "E" Entonces
						eleccionNumero <- 3;
					SiNo
						eleccionNumero <- 4;
					FinSi
				FinSi
			FinSi
			valorDadoEnemigo <- lanzarDado(1,2);
			Segun eleccionNumero Hacer
				Caso 1: 
					Escribir "Te posicionas para atacar al enemigo";				
				Caso 2:
					Escribir "Te posicionas para defenderte";
				Caso 3:
					mostrarMensajeEstadisticasPersonaje(nombrePersonaje, vidaPersonaje, experienciaPersonaje, fuerzaPersonaje, defensaPersonaje, agilidadPersonaje, inteligenciaPersonaje, nivelPersonaje, estadoPersonaje);
				Caso 4:
					Escribir "Opción no válida! Ingrese nuevamente";
			FinSegun
			Esperar 2 Segundos;
		Hasta Que eleccionNumero = 1 O eleccionNumero = 2;
		Esperar 1 Segundos;
		Si valorDadoEnemigo = 1 Entonces
			Escribir "El enemigo se posiciona para atacarte!";
		SiNo
			Escribir "El se pone en postura defensiva!";
		FinSi
		Esperar 2 Segundos;
		Si eleccionNumero = 2 Y valorDadoEnemigo = 2 Entonces
			Escribir "Los dos se quedan mirando en postura de defensa";
			Esperar 2 Segundos;
		SiNo
			Si eleccionNumero = 1 Y valorDadoEnemigo = 1 Entonces
				Escribir "Ambos atacan al mismo tiempo! Se cruzan los ataques!";
				Escribir "Atacas!";
				valorDadoPersonaje <- lanzarDadoAnimacion;
				Si valorDadoPersonaje = 1 Entonces
					Escribir "Te tropiezas y te atacas solo";
					Escribir "Te haces ", fuerzaPersonaje * 10 / 100, " de daño";
					vidaPersonaje <- vidaPersonaje - trunc((fuerzaPersonaje * 10 / 100));
				SiNo
					Si valorDadoPersonaje < 3 Entonces
						Escribir "Fallaste! Sacaste un ", valorDadoPersonaje;
					SiNo
						Si valorDadoPersonaje = 6 Entonces
							Escribir "Lo atacas con una furia desenfrenada!! Le haces 200% de tu daño!";
							danioAlEnemigo <- fuerzaPersonaje * 2;
						SiNo
							Escribir "Lo atacas! Sacaste un ", valorDadoPersonaje, ", le haces el ", (valorDadoPersonaje - 1) * 20, "% de tu daño";
							danioAlEnemigo <- redon(fuerzaPersonaje * ((valorDadoPersonaje - 1) * 20 / 100));
						FinSi
					FinSi
				FinSi
				vidaEnemigo <- vidaEnemigo - danioAlEnemigo;
				Escribir "Le hiciste ", danioAlEnemigo, " de daño al enemigo";
				Esperar 3 Segundos;
				Escribir "El enemigo te ataca!";
				valorDadoEnemigo <- lanzarDadoAnimacion;
				Si valorDadoEnemigo = 1 Entonces
					Escribir "Se tropieza y se ataca solo";
					Escribir "Se hace ", fuerzaEnemigo * 10 / 100, " de daño";
					vidaEnemigo <- vidaEnemigo - trunc((fuerzaEnemigo * 10 / 100));
				SiNo
					Si valorDadoEnemigo < 3 Entonces
						Escribir "Falló el ataque! Sacó un ", valorDadoEnemigo;
					SiNo
						Si valorDadoEnemigo = 6 Entonces
							Escribir "Te golpea con toda su furia! Te hace 200% de su daño";
							danioRecibidoPersonaje <- trunc((fuerzaEnemigo * 2));
						SiNo
							Escribir "Sacó un ", valorDadoEnemigo, ", te hace el ", (valorDadoEnemigo - 1) * 20, "% de su daño";
							danioRecibidoPersonaje <- redon(fuerzaEnemigo * ((valorDadoEnemigo - 1) * 20 / 100));
						FinSi
					FinSi
				FinSi
				vidaPersonaje <- vidaPersonaje - danioRecibidoPersonaje;
				Escribir "Recibes ", danioRecibidoPersonaje, " de daño!";
			SiNo
				Si eleccionNumero = 2 Y valorDadoEnemigo = 2 Entonces
					Escribir "Los dos se quedan mirando en postura de defensa";
				SiNo
					Si eleccionNumero = 1 Y valorDadoEnemigo = 2 Entonces
						valorDadoPersonaje <- lanzarDadoAnimacion;
						Si valorDadoPersonaje = 1 Entonces
							Escribir "Te tropezaste y te atacaste solo";
							Escribir "Te haces ", fuerzaPersonaje * 10 / 100, " de daño";
							vidaPersonaje <- vidaPersonaje - redon((fuerzaPersonaje * 10 / 100));
						SiNo
							Si valorDadoPersonaje < 3 Entonces 
								Escribir "Fallaste! Sacaste un ", valorDadoPersonaje;
								danioAlEnemigo <- 0;
							SiNo
								Si valorDadoPersonaje = 6 Entonces
									Escribir "Lo atacas con una furia desenfrenada!! Le haces 200% de tu daño!";
									danioAlEnemigo <- fuerzaPersonaje * 2;
								SiNo
									Escribir "Lo atacas! Sacaste un ", valorDadoPersonaje, ", le haces el ", (valorDadoPersonaje - 1) * 20, "% de tu daño";
									danioAlEnemigo <- redon(fuerzaPersonaje * ((valorDadoPersonaje - 1) * 20 / 100));
									Esperar 2 Segundos;
								FinSi
								valorDadoEnemigo <- lanzarDadoAnimacion;
								Si valorDadoEnemigo < 3 Entonces 
									Escribir "El enemigo no se defiende! Queda al descubierto, sacó un ", valorDadoEnemigo;
									Escribir "Le haces ", danioAlEnemigo, " de daño";
									danioRecibidoEnemigo <- danioAlEnemigo;
								SiNo
									Si valorDadoEnemigo = 6 Y valorDadoPersonaje = 6 Entonces
										Escribir "Se pone en una postura perfecta, pero igual logras conectarle el golpe!";
										Escribir "Le haces ", fuerzaPersonaje, " de daño";
										danioRecibidoEnemigo <- danioAlEnemigo;
									SiNo						
										Si valorDadoEnemigo = 6 Entonces
											Escribir "El enemigo bloquea completamente el ataque! No le haces daño";
										SiNo
											Escribir "El enemigo se defiende! Sacó un ", valorDadoEnemigo, ", reduce el ", (valorDadoEnemigo - 1) * 20, "% del daño recibido";
											danioRecibidoEnemigo <- redon(danioAlEnemigo * (100 - (valorDadoEnemigo - 1) * 20) / 100);
											Escribir "Le hiciste ", danioAlEnemigo, " de daño al enemigo";
										FinSi
									FinSi									
								FinSi								
							FinSi
						FinSi
					FinSi
					Si eleccionNumero = 2 Y valorDadoEnemigo = 1 Entonces
						valorDadoEnemigo <- lanzarDadoAnimacion;
						Si valorDadoEnemigo = 1 Entonces
							Escribir "Se tropieza y se ataca solo";
							Escribir "Se hace ", fuerzaEnemigo * 10 / 100, " de daño";
							vidaEnemigo <- vidaEnemigo - (fuerzaEnemigo * 10 / 100);
						SiNo
							Si valorDadoEnemigo < 3 Entonces 
								Escribir "Falló el ataque! Sacó un ", valorDadoEnemigo;
							SiNo
								Escribir "Se te acerca para acertarte";
								Si eleccionNumero = 2 Entonces
									valorDadoPersonaje <- lanzarDadoAnimacion;
									Si valorDadoPersonaje < 3 Entonces 
										Escribir "Defensa fallida! Quedas al descubierto, sacaste un ", valorDadoPersonaje;
									SiNo
										Escribir "Defensa exitosa! Sacaste un ", valorDadoPersonaje, ", reduces el ", (valorDadoPersonaje - 1) * 20, "% del daño recibido";
										danioRecibidoPersonaje <- redon((valorDadoPersonaje - 1) * 20 / 100);
									FinSi
									Si danioRecibidoPersonaje = 100 Entonces
										Escribir "Bloqueaste completamente el ataque!";
									SiNo
										Si valorDadoEnemigo = 6 Entonces
											Escribir "Te golpea con toda su furia! Te hace 200% de su daño";
											danioRecibidoPersonaje <- redon((fuerzaEnemigo * 2 * (100 - danioRecibidoPersonaje) / 100));
										SiNo
											Escribir "Te dió! Sacó un ", valorDadoEnemigo, ", te hace el ", (valorDadoEnemigo - 1) * 20, "% de su daño";
											danioRecibidoPersonaje <- redon((fuerzaEnemigo * ((valorDadoEnemigo - 1) * 20 / 100)) * (100 - danioRecibidoPersonaje) / 100);
										FinSi
										Escribir "Recibes ", danioRecibidoPersonaje, " de daño!";
										vidaPersonaje <- vidaPersonaje - danioRecibidoPersonaje;
									FinSi
								FinSi
							FinSi
						FinSi
					FinSi
				FinSi
			FinSi
		FinSi
	FinMientras
	Si vidaPersonaje <= 0 Entonces
		Escribir "El enemigo te mató!";
		Escribir "Por la gracia del dios te da una nueva oportunidad y te revive";
		Escribir "El enemigo al ver que te levantas nuevamente, huye";
	SiNo
		Escribir "¡Has derrotado al enemigo!";
		Escribir "Luego de una larga batalla descansas y te recuperas";
	FinSi
	vidaPersonaje <- vidaMaximaPersonaje;
	Esperar 2 Segundos;
FinSubProceso


SubProceso inicializarEnemigo(vidaEnemigo Por Referencia, fuerzaEnemigo Por Referencia, defensaEnemigo Por Referencia, agilidadEnemigo Por Referencia, inteligenciaEnemigo Por Referencia)
    vidaEnemigo <- 10 + Aleatorio(0, 10);
    fuerzaEnemigo <- Aleatorio(1, 5);
    defensaEnemigo <- Aleatorio(1, 5);
    agilidadEnemigo <- Aleatorio(1, 5);
    inteligenciaEnemigo <- Aleatorio(1, 5);
FinSubProceso




//----------------------------------------------------
//-------------------   PANTALLA   -------------------
//----------------------------------------------------

//Imprime el mensaje ingresado dentro de un recuadro
//El mensaje se ajustará a la cantidad de caracteres indicadas en longMensaje
//El recuadro tiene una longitud de longMensaje + 4 ( = los 2 bordes + los 2 espacios de margen)
SubProceso mostrarMensaje(mensaje)
    Definir longMensaje, i Como Entero;
    Definir techo, piso, palabras Como Caracter;
    
    longMensaje <- 38;
    
    techo <- "|-";
    piso <- "|_";
    Para i <- 1 Hasta longMensaje Con Paso 1 Hacer
        techo <- Concatenar(techo, "-");
        piso <- Concatenar(piso, "_");
    FinPara
    techo <- Concatenar(techo, "-|");
    piso <- Concatenar(piso, "_|");
    
    Escribir techo;
    Para i <- 0 Hasta Longitud(mensaje) - 1 Con Paso longMensaje hacer
        palabras <- Subcadena(mensaje, i, i + longMensaje - 1);
        escrituraMensaje(Subcadena(palabras, 0, longMensaje - 1), longMensaje);
    FinPara
    Escribir piso;
FinSubProceso

//Imprime los mensajes ingresados dentro de un recuadro
//Los mensajes se ajustarán a la cantidad de caracteres indicadas en longMensaje
//Si el mensaje es mas largo que esto, se recortará
SubProceso mostrarMensajes(mensajes, cantidad)
    Definir longMensaje, i Como Entero;
    Definir techo, piso, palabras Como Caracter;
    
    longMensaje <- 38;
    
    techo <- "|-";
    piso <- "|_";
    Para i <- 1 Hasta longMensaje Con Paso 1 Hacer
        techo <- Concatenar(techo, "-");
        piso <- Concatenar(piso, "_");
    FinPara
    techo <- Concatenar(techo, "-|");
    piso <- Concatenar(piso, "_|");
    
    Escribir techo;
    Para i <- 0 Hasta cantidad - 1 Con Paso 1 hacer
        escrituraMensaje(Subcadena(mensajes[i],0,longMensaje), longMensaje);
    FinPara
    Escribir piso;
FinSubProceso

//Escribe el mensaje dentro del recuadro colocando saltos de linea en base al tamaño solicitado
SubProceso escrituraMensaje(mensaje, tamanio)
    Definir i como entero;
    
    Para i <- 0 Hasta tamanio - Longitud(mensaje) Con Paso 1 Hacer
        mensaje <- Concatenar(mensaje, " ");
    FinPara
    
    Escribir Sin Saltar "| ";
    Para i <- 0 hasta tamanio-1 Con Paso 1 Hacer
        Escribir Sin Saltar Subcadena(mensaje,i,i);
    FinPara
    Escribir " |";
FinSubProceso

Subproceso mostrarMensajeIngresarNombre
    Definir mensaje Como Caracter;
    mensaje <-                    "Ingrese el nombre de su personaje     ";
    mensaje <- Concatenar(mensaje,"para comenzar"                         );
    mostrarMensaje(mensaje);
FinSubProceso

Subproceso mostrarMensajeAccionesMapa(estado)
    Definir mensaje Como Caracter;
    mensaje <- "";
    Si estado = "0001" Entonces
        mensaje <- "¡Opción inválida!                     ";
    Sino Si estado = "0002" Entonces
            mensaje <- "¡Movimiento Inválido!                 ";
        Sino Si estado = "0003" Entonces
                mensaje <- "¡Una pared bloquea el paso!           ";
            FinSi
        FinSi
    FinSi
    mensaje <- Concatenar(mensaje," Ingrese una acción:                  ");
    mensaje <- Concatenar(mensaje,"            (W) Arriba   (E) Stats    ");
    mensaje <- Concatenar(mensaje,"    Izq (A)     (D) Der               ");
    mensaje <- Concatenar(mensaje,"            (S) Abajo                 ");
    mostrarMensaje(mensaje);
FinSubProceso

Subproceso mostrarMensajeAccionesPelea
    Definir mensaje Como Caracter;
    mensaje <- "";
    mensaje <- Concatenar(mensaje," Ingrese una acción:                     ");
    mensaje <- Concatenar(mensaje,"               (E) Stats                 ");
    mensaje <- Concatenar(mensaje,"    Atacar (A)     (D) Defender          ");
    mensaje <- Concatenar(mensaje,"                                         ");
    mostrarMensaje(mensaje);
FinSubProceso

Subproceso mostrarMensajeMenuInicio(estado)
    ilustracionMenu();
    Definir mensaje Como Caracter;
    mensaje <- "";
    Si estado = "0001" Entonces
        mensaje <- "¡Opción inválida!                     ";
    FinSi
    mensaje <- Concatenar(mensaje," (1) Iniciar Juego                    ");
    mensaje <- Concatenar(mensaje," (2) Salir                            ");
    mostrarMensaje(mensaje);
FinSubProceso

SubProceso mostrarMensajeEstadisticasPersonaje(nombrePersonaje, vidaPersonaje, experienciaPersonaje, fuerzaPersonaje, defensaPersonaje, agilidadPersonaje, inteligenciaPersonaje, nivelPersonaje, estadoPersonaje)
    Definir mensaje, aux Como Caracter;
    Dimension mensaje[10];
    mensaje[0] <- "DATOS PERSONAJE";
    mensaje[1] <- Mayusculas(nombrePersonaje);
    mensaje[2] <- Concatenar("Vida: ", ConvertirATexto(vidaPersonaje));
    mensaje[3] <- Concatenar("Experiencia: ", ConvertirATexto(experienciaPersonaje));
    mensaje[4] <- Concatenar("Fuerza: ", ConvertirATexto(fuerzaPersonaje));
    mensaje[5] <- Concatenar("Defensa: ", ConvertirATexto(defensaPersonaje));
    mensaje[6] <- Concatenar("Agilidad: ", ConvertirATexto(agilidadPersonaje));
    mensaje[7] <- Concatenar("Inteligencia: ", ConvertirATexto(inteligenciaPersonaje));
    mensaje[8] <- Concatenar("Nivel: ", ConvertirATexto(nivelPersonaje));
    mensaje[9] <- Concatenar("Estado: ", estadoPersonaje);
    mostrarMensajes(mensaje, 10);
FinSubProceso

SubProceso mostrarLaberinto(tam, laberinto)
    Definir fila, columna Como Entero;
    Para fila <- 0 Hasta tam-1 Hacer
        Para columna <- 0 Hasta tam-1 Hacer
            Escribir " ", laberinto(fila, columna), " " Sin Saltar;
        FinPara
        Escribir " ";
    FinPara
FinSubProceso

SubProceso ilustracionMenu 
    Escribir "                                         .^^--..__";
    Escribir "                     _                     []       ``-.._";
    Escribir "                  . ` ` .                  ||__           `-._";
    Escribir "                 /    ,-.\                 ||_ ```---..__     `-.";
    Escribir "                /    /:::\\               /|//}          ``--._  `.";
    Escribir "                |    |:::||              |////}                `-. \";
    Escribir "                |    |:::||             //^///                    `.\";
    Escribir "                |    |:::||            //  ||                       `|";
    Escribir "                /    |:::|/        _,-//\  ||";
    Escribir "               /`    |:::|`-,__,-`   |/  \ |";
    Escribir "             /`  |   |   ||           \   |||";
    Escribir "           /`    \   |   ||            |  /||";
    Escribir "         |`       |  |   |)            \ | ||";
    Escribir "        |          \ |   /      ,.__    \| ||";
    Escribir "        /           `         /`    `\   | ||";
    Escribir "       |                     /        \  / ||";
    Escribir "       |                     |        | /  ||";
    Escribir "       /         /           |        `(   ||";
    Escribir "      /          .           /          )  ||";
    Escribir "     |            \          |     ________||";
    Escribir "    /             |          /     `-------.|";
    Escribir "   |\            /          |              ||";
    Escribir "   \/`-._       |           /              ||";
    Escribir "    //   `.    /`           |              ||";
    Escribir "   //`.    `. |             \              ||";
    Escribir "  ///\ `-._  )/             |              ||";
    Escribir " //// )   .(/               |              ||";
    Escribir " ||||   ,`  )               /              //";
    Escribir " ||||  /                    /             || ";
    Escribir " `\\` /`                    |             // ";
    Escribir "     |`                     \            ||  ";
    Escribir "    /                        |           //  ";
    Escribir "  /`                          \         //   ";
    Escribir "/`                            |        ||    ";
    Escribir "`-.___,-.      .-.        ___,/        (/    ";
    Escribir "         `---?`   `?----?`";
    Escribir "USE PANTALLA COMPLETA PARA UNA MEJOR EXPERIENCIA";
	Esperar 3 Segundos;
FinSubProceso

SubProceso poblarLaberinto(tam, laberinto)
    Definir fila, columna Como Entero;
    Definir bloques Como Caracter;
    Dimension bloques(3);
    bloques(0) <- " "; //Espacio en blanco
    bloques(1) <- " "; //Segundo espacio (es necesario porque da 66 porciento de probabilidad de que genere un espacio y hace más rápido el proceso)
    bloques(2) <- "X"; 
    Para fila <- 0 Hasta tam-1 Hacer
        Para columna <- 0 Hasta tam-1 Hacer
            laberinto(fila, columna) <- bloques(Azar(3));
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

SubProceso BuscaHongos
	
	Dimension num[9,9];Dimension fan[9,9];
	Definir num,fan,minaPisada,numeroMinasCaracter, opcionLetra como caracter;
	Definir salir,retirada como caracter;
	Definir numeroMinas,op,fil,col,i,j,xe,ye,verificar,varX,varY,busX,busY,marX,marY,nivel,opc, cantidadMuertes como Entero;
	Definir juegoHongos Como Logico;
	juegoHongos <- Verdadero;
	retirada<-'';
	cantidadMuertes <- 0;
	Repetir
		limpiar pantalla;
		Escribir "********************************************************************";
		Escribir "********************************************************************";
		Escribir "************     BUSCA HONGOS DEL REINO OLVIDADO      **************";	
		Escribir "************ FELICIDADES JUGADOR, SUPERASTE ESTE MAPA **************";
		Escribir "***  PARA PASAR AL PRÓXIMO DEBERÁS PASAR POR UN CAMPO DE HONGOS  ***";
		Escribir "************** PRESIONE CUALQUIER TECLA PARA CONTINUAR **************";
		Escribir "********************************************************************";
		Leer opcionLetra;
		
		
		Repetir
			limpiar pantalla;
			Escribir "**************  NIVEL    ";
			Escribir "**************  1. FACIL [5 hongos]  ";
			Escribir "**************  2. INTERMEDIO [10 hongos]    ";
			Escribir "**************  3. DIFICIL  [15 hongos]  ";
			Leer opc;
			Segun opc Hacer
				1:
					nivel<-5;
				2:
					nivel<-10;
				3:
					nivel<-15;
				De Otro Modo:
					Escribir "Opcion no valida";
			FinSegun
		Hasta Que opc>=1 y opc<=3
		
		numeroMinas<-0;
		op<-1;
		para fil<-0 hasta 7 con paso 1 hacer
			Para col<-0 Hasta 7 Con Paso 1 Hacer
				num[fil,col]<-"-";
				fan[fil,col]<-"-";
			FinPara
		finpara
		
		//UBICACION DE HONGOS AL AZAR
		Para i<-1 Hasta nivel Con Paso 1 Hacer
			xe <- azar(6)+1;
			ye <- azar(6)+1;
			si num[xe,ye]="-" entonces
				num[xe,ye]<-"X";
			Sino
				i<-i-1;
			finsi
		FinPara
		
		Repetir					
			//VERIFICAR SI HAY HONGOS
			verificar<-0;
			para fil<-1 hasta 7 con paso 1 hacer
				Para col<-1 Hasta 7 Con Paso 1 Hacer
					si fan[fil,col]="-" Entonces
						verificar<-1;
					FinSi
				FinPara
			finpara
			si verificar=0 entonces
				Escribir "_______________________________________________";
				Escribir "Has encontrado todas los hongos!!";
				Escribir "GANASTE!!"; retirada <- "s";
				Esperar Tecla;
			FinSi
			
			LimpiarPantalla;
			
			Escribir "---------------------------------";
			Escribir "       1   2   3   4   5   6    ";
			
			Escribir 1,"    | ",fan[1,1]," | ",fan[1,2]," | ",fan[1,3]," | ",fan[1,4]," | ",fan[1,5]," | ",fan[1,6]," | ";
			Escribir 2,"    | ",fan[2,1]," | ",fan[2,2]," | ",fan[2,3]," | ",fan[2,4]," | ",fan[2,5]," | ",fan[2,6]," |      *Marcar Hongo Presione [10]";
			Escribir 3,"    | ",fan[3,1]," | ",fan[3,2]," | ",fan[3,3]," | ",fan[3,4]," | ",fan[3,5]," | ",fan[3,6]," |        Despues tecla [enter]";
			Escribir 4,"    | ",fan[4,1]," | ",fan[4,2]," | ",fan[4,3]," | ",fan[4,4]," | ",fan[4,5]," | ",fan[4,6]," |      *Retirada presione [11]";
			Escribir 5,"    | ",fan[5,1]," | ",fan[5,2]," | ",fan[5,3]," | ",fan[5,4]," | ",fan[5,5]," | ",fan[5,6]," |        Despues tecla [enter]";
			Escribir 6,"    | ",fan[6,1]," | ",fan[6,2]," | ",fan[6,3]," | ",fan[6,4]," | ",fan[6,5]," | ",fan[6,6]," | ";
			//Escribir 7,"    | ",fan[7,1]," | ",fan[7,2]," | ",fan[7,3]," | ",fan[7,4]," | ",fan[7,5]," | ",fan[7,6]," | ",fan[7,7]," | ";
			Escribir "**********************************";
			Escribir "***** PARA JUGAR INGRESÁ LAS COORDENADAS (X primero, Y segundo) *****";
			
			Escribir "Coordenada en  X";
			Leer varX;
			Escribir "Coordenada en  Y";
			Leer varY;
			
			si varX>=1 y varY>=1 y varX<=7 y varY<=7 entonces
				minaPisada<-num[varY,varX];
				
				si !minaPisada="X" entonces
					
					Repetir					
						busX<-varX;
						busY<-varY;
						Segun op Hacer
							1:
								busX<-busX-1;
							2:
								busX<-busX-1;busY<-busY-1;
							3:
								busY<-busY-1;
							4:
								busX<-busX+1;busY<-busY-1;
							5:
								busX<-busX+1;
							6:
								busX<-busX+1;busY<-busY+1;
							7:
								busY<-busY+1;
							8:
								busX<-busX-1;busY<-busY+1;
							De Otro Modo:
								Escribir "Error: Terminando escaneo Hongos";
						FinSegun
						op<-op+1;
						si num[busY,busX]='X' Entonces
							numeroMinas <- numeroMinas+1;
						FinSi
						
						
					Hasta Que op=9
					numeroMinasCaracter<-ConvertirATexto(numeroMinas);
					fan[varY,varX]<- numeroMinasCaracter;
					op<-1;numeroMinas<-0;
				Sino
					LimpiarPantalla;
					Escribir "       1   2   3   4   5   6   ";
					para j<-1 hasta 6 con paso 1 hacer
						Escribir j,"     | ",num[j,1]," | ",num[j,2]," | ",num[j,3]," | ",num[j,4]," | ",num[j,5]," | ",num[j,6]," | ";
					FinPara
					
					Escribir "*************************************";
					Escribir "HAS PISADO UN HONGO Amanita phalloides, SI ES MORTAL !!";
					Escribir "*************************************";
					
					cantidadMuertes <- cantidadMuertes +1;
					Si cantidadMuertes < 3 Entonces
						Escribir "El dios todo benevolente de este universo te dió otra oportunidad, no la desaproveches";
					SiNo
						Escribir "Haz muerto horriblemente por el veneno acumulado de los hongos";
						retirada<-"s";
					FinSi
					esperar tecla;
				FinSi
			Sino si varX=11 o varY=11 entonces
					Escribir "¿Estas seguro que quieres retirarte del Juego?[S/N]";
					leer retirada;
					Si retirada='s' o retirada='S' Entonces
						Escribir "*************************************";
						Escribir "Eres un cobarde";
						Escribir "*************************************";
						Esperar 3 Segundos;
					FinSi
				Sino si	varX=10 o varY=10 entonces
						Escribir "Digite cordenada X de hongo que desea marcar";
						Leer marX;
						Escribir "Digite cordenada Y de hongo que desea marcar";
						Leer marY;
						fan[marY,marX]<-"?";
					FinSi
					
				FinSi
				
			FinSi
			
		Hasta Que retirada='s' o retirada='S'
		retirada<-'';
		juegoHongos <- Falso;
	Hasta Que juegoHongos = Falso;
	animacionCierre;
FinSubProceso

SubProceso alea <- lanzarDadoAnimacion
	
    Definir i, j, altura, contador, alea Como Entero;
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
    alea <- lanzarDado(1,6);
    
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
        Esperar 50 Milisegundos; // Ajusta la velocidad del salto
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
		Si altura < 9 Entonces
			Esperar 100 Milisegundos; // Ajusta la velocidad del salto
		SiNo
			Esperar 200 Milisegundos;
		FinSi
        
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
FinSubProceso

SubProceso animacionCierre
    Definir i, j, altura, contador Como Entero;
    Definir dragon Como Caracter;
    Dimension dragon[40]; 
	
    dragon[0] <- "                         /\\";
    dragon[1] <- "                         ||";
    dragon[2] <- "                         ||";
    dragon[3] <- "                         ||";
    dragon[4] <- "                         ||                                               ~-----~";
    dragon[5] <- "                         ||                                            /===--  ---~~~";
    dragon[6] <- "                         ||                                      /==~- --   -    ---~~~";
    dragon[7] <- "                         ||                (/ (               /=----         ~~_  --(   ";
    dragon[8] <- "                         ||               / ;              /=----               \\__~";
    dragon[9] <- "                       ~==_=~           (              ~-~~      ~~~~        ~~~--\\~ ";
    dragon[10] <- "      \\                (c_\\_        .I.             /~--    ~~~--   -~     (";
    dragon[11] <- "       `\\               (}| /       / : \\           / ~~------~     ~~\\   (";
    dragon[12] <- "       \\                 |/ \\      |===|          /~/             ~~~ \\ \\(";
    dragon[13] <- "      ``~\\              ~~\\  )~.~_ >._.< _~-~     |`_          ~~-~     )\\";
    dragon[14] <- "        -~                 {  /  ) \\___/ (   \\   |    _       ~~         ";
    dragon[15] <- "       \\ -~\\                -<__/  -   -  L~ -;   \\\\    \\ _ _/";
    dragon[16] <- "       `` ~~=\\                  {    :    }\\ ,\\    ||   _ :(";
    dragon[17] <- "        \\  ~~=\\__                \\ _/ \\_ /  )  } _//   ( `| ";
    dragon[18] <- "        ``    , ~\\--~=\\           \\     /  / _/ /      (   ";
    dragon[19] <- "         \\`    } ~ ~~ -~=\\   _~_  / \\ / \\ )^ ( // :_  /                                     GRACIAS POR JUGAR!!!!";
    dragon[20] <- "         |    ,          _~-     ~~__-_  / - |/     \\ (";
    dragon[21] <- "         \\  ,_--_     _/              \\_ --- , -~ .   \\";
    dragon[22] <- "           )/      /\\ / /\\   ,~,         \\__ _}     \\_   ~_                                 El código de Da Vinci";
    dragon[23] <- "           ,      { ( _ ) } ~ - \\_    ~\\  (-:-)        \\   ~";
    dragon[24] <- "                  / O  O  )~ \\~_ ~\\   )->  \\ :|    _,       }";
    dragon[25] <- "                 (\\  _/)  } | \\~_ ~  /~(   | :)   /          }";
    dragon[26] <- "                <``  >;,,/  )= \\~__ {{{    \\ =(  ,   ,       ";
    dragon[27] <- "               {o_o }_/     |v   ~__  _    )-v|     :       ,";
    dragon[28] <- "               {/ \\_)       {_/   \\~__ ~\\_ \\\\_}    {        /~\\";
    dragon[29] <- "               ,/!           _/     ~__ _-~ \\_  :         ,   ~ ";
    dragon[30] <- "              (  )                   /, ~___~    | /     ,   \\ ~";
    dragon[31] <- "              /, )                 (-)   ~____~ ;     ,      , }";
    dragon[32] <- "           /, )                    / \\         /  ,~-        ~";
    dragon[33] <- "     (    /                     / (         /  /           ~";
    dragon[34] <- "    ~ ~  ,, /) ,                 (/( \\)      ( -)          /~";
    dragon[35] <- "  (  ~~ )`  ~}                      \\)      _/ /           ~";
    dragon[36] <- " { |) /`,--.(  }                           (  /          /~";
    dragon[37] <- "(` ~ ( c|~~| `}   )                         /:\\         ,";
    dragon[38] <- " ~ )/  ) ))  |),                          (/ | \\)";
    dragon[39] <- "  (` (-~(( `~`   )                          (/ ";
	
    contador <- 0;
	
    // Movimiento del dragón hacia arriba
    Para altura <- 39 Hasta 0 Con Paso -1 Hacer
        Borrar Pantalla;
        // Espacios iniciales para mover el dragón hacia arriba
        espacios(altura);
        // Mostrar solo parte visible del dragón (líneas 0 a 25)
        Para j <- 0 Hasta 39 Hacer
            Si j + altura < 40 Entonces
                Escribir dragon[j + altura];
            FinSi
        FinPara
        // Esperar un poco antes de la siguiente iteración
        Esperar 200 Milisegundos;
        contador <- contador + 1;
    FinPara
	Escribir "----------------------------------------------------------------";
	Escribir "-------- PRESIONE CUALQUIER TECLA PARA EMPEZAR DE NUEVO --------";
	Escribir "----------------------------------------------------------------";
	Esperar Tecla;
FinSubProceso

SubProceso espacios(x)
    Definir i Como Entero;
    Para i <- 0 Hasta x-1 Hacer
        Escribir Sin Saltar " ";
    FinPara
FinSubProceso

SubProceso animacionPersonaje
    Definir pj, arbol,arbol1 Como Caracter;
    Definir i, j Como Entero;
    
    Escribir "Presione una tecla para iniciar la partida";
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

//subproceso utilizado para generar una matriz simulando un espacio de "estrellas"
SubProceso rellenarMatrizEspacial(tam, matrizEspacial)
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
		Esperar 40 Milisegundos;
	FinPara
FinSubProceso


//subproceso que dibuja un dragon para la presentación del juego
SubProceso dibujarDragon
	Esperar  1 Segundos;
	
	Escribir "                                            .~))>>";
	Esperar 40 Milisegundos;
	Escribir "                                            .~)>>";
	Esperar 40 Milisegundos;
	
	Escribir "                                       .~))))>>>";
	Esperar 40 Milisegundos;
	
	Escribir "                                         .~))>> "; 
	Esperar 40 Milisegundos;
	
	Escribir "                                    .~))>>)))>>      .-~))>> ";
	Esperar 40 Milisegundos;
	
	Escribir "                                   .~)))))>>       .-~))>>)> ";
	Esperar 40 Milisegundos;
	
	Escribir "                                .~)))>>))))>>  .-~)>>)> ";
	Esperar 40 Milisegundos;
	
	Escribir "                               .~))>>))))>>  .-~)))))>>)>";
	Esperar 40 Milisegundos;
	
	Escribir "                               //)>))))))  .-~))))>>)>";
	Esperar 40 Milisegundos;
	
	Escribir "                              //))>>))) .-~))>>)))))>>)>";
	Esperar 40 Milisegundos;
	
	Escribir "                             //))))) .-~)>>)))))>>)>";
	Esperar 40 Milisegundos;
	
	Escribir "                            //)>))) //))))))>>))))>>)>";
	Esperar 40 Milisegundos;
	
	Escribir "                           |/))))) //)))))>>)))>>)>";
	Esperar 40 Milisegundos;
	
	Escribir "                 (\_(\-\b  |))>)) //)))>>)))))))>>)>";
	Esperar 40 Milisegundos;
	
	Escribir "                _/`-`  ~|b |>))) //)>>)))))))>>)>";
	Esperar 40 Milisegundos;
	
	Escribir "                (@) (@)  /\b|))) //))))))>>))))>>";
	Esperar 40 Milisegundos;
	
    Escribir "              _/       /  \b)) //))>>)))))>>>_._";
	Esperar 40 Milisegundos;
	
	Escribir "              (6,   6) / ^  \b)//))))))>>)))>>   ~~-. ";
	Esperar 40 Milisegundos;
	
	Escribir "               ~^~^~, /\  ^  \b/)>>))))>>      _.     `, ";
	Esperar 40 Milisegundos;
	
	Escribir "               \^^^/ (  ^   \b)))>>        .         `, ";
	Esperar 40 Milisegundos;
	
	Escribir "                `-   ((   ^  ~)_          /             , ";
	Esperar 40 Milisegundos;
	
	Escribir "                      (((   ^    `\        |               `. ";
	Esperar 40 Milisegundos;
	
	Escribir "                     / ((((        \        \      .         `. ";
	Esperar 40 Milisegundos;
	
	Escribir "                    /   (((((  \    \    _.-~\     Y,         ;";
	Esperar 40 Milisegundos;
	
	Escribir "                   /   / (((((( \    \.-~   _.` _.-~,       ; ";
	Esperar 40 Milisegundos;
	
	Escribir "                  /   /   `(((((()    )    (((((~      `,     ; ";
	Esperar 40 Milisegundos;
	
	Escribir "                _/  _/      `++/   /                  ;     ;";
	Esperar 40 Milisegundos;
	
	Escribir "             _.-~_.-~           `/  /`                    ";
	Esperar 40 Milisegundos;
	
	Escribir "            ((((~~             `/ /              _.-~ __.--~ ";
	Esperar 40 Milisegundos;
	
	Escribir "                             ((((          __.-~ _.-~ ";
	Esperar 40 Milisegundos;
	
	Escribir "                                         .   .~~ ";
	Esperar 40 Milisegundos;
	
	Escribir "                                        :    ,";
	Esperar 40 Milisegundos;
	
	Escribir "                                        ~~~~~ ";
	Esperar 40 Milisegundos;
	
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
		Esperar 40 Milisegundos;
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
	Esperar 30 Milisegundos;
    Escribir "                                                                                                                        ";
	Esperar 30 Milisegundos;
    Escribir "                       |\\                                                              /|                             ";
    Esperar 30 Milisegundos;
	Escribir "                       | \\                                                            / |                             ";
    Esperar 30 Milisegundos;
	Escribir "                       |  \\                                                          /  |                             ";
    Esperar 30 Milisegundos;
	Escribir "                       |   \\                                                        /   |                             ";    
    Esperar 30 Milisegundos;
	Escribir "            _____)    \\                                                      /    (____                           ";
    Esperar 30 Milisegundos;
	Escribir "           \\          \\                                                    /         /                            ";
    Esperar 30 Milisegundos;
	Escribir "            \\          \\                                                  /         /                             ";
    Esperar 30 Milisegundos;
	Escribir "            \\           `--_____                                _____--          /                              ";
    Esperar 30 Milisegundos;
	Escribir "             \\                  \\                              /                 /                               ";    
    Esperar 30 Milisegundos;
	Escribir "            ____)                  \\                            /                 (____                          ";
    Esperar 30 Milisegundos;
	Escribir "            \\                       \\        /|      |\\        /                      /                          ";
    Esperar 30 Milisegundos;
	Escribir "             \\                       \\      | /      \\ |      /                      /                           ";
    Esperar 30 Milisegundos;
	Escribir "              \\                       \\     ||        ||     /                      /                            ";
    Esperar 30 Milisegundos;
	Escribir "               \\                       \\    | \\______/ |    /                      /                             ";
    Esperar 30 Milisegundos;
	Escribir "                \\                       \\  / \\        / \\  /                      /                              ";
    Esperar 30 Milisegundos;
	Escribir "                /                        \\| (*\\  \\/  /*) |/                       \\                              ";
    Esperar 30 Milisegundos;
	Escribir "               /                          \\   \\| \\/ |/   /                         \\                             ";
    Esperar 30 Milisegundos;
	Escribir "              /                            |   |    |   |                           \\                            ";
    Esperar 30 Milisegundos;
	Escribir "             /                             |\\ _\\____/_ /|                            \\                           ";
    Esperar 30 Milisegundos;
	Escribir "            /______                       | | \\)____(/ | |                      ______\\                          ";
    Esperar 30 Milisegundos;
	Escribir "                   )                      |  \\ |/vv\\| /  |                     (                               ";
    Esperar 30 Milisegundos;
	Escribir "                  /                      /    | |  | |    \\                     \\                              ";
	Esperar 30 Milisegundos;
	Escribir "                 /                      /     ||\\^^/||     \\                     \\                             ";
    Esperar 30 Milisegundos;
	Escribir "                /                      /     / \\====/ \\     \\                     \\                            ";
    Esperar 30 Milisegundos;
	Escribir "              /_______           ____/      \\________/      \\____           ______\\                           ";
    Esperar 30 Milisegundos;
	Escribir "                     )         /   |       |  ____  |       |   \\         (                                     ";
    Esperar 30 Milisegundos;
	Escribir "                     |       /     |       \\________/       |     \\       |                                     ";
    Esperar 30 Milisegundos;
	Escribir "                     |     /       |       |  ____  |       |       \\     |                                     ";
    Esperar 30 Milisegundos;
	Escribir "                     |   /         |       \\________/       |         \\   |                                     ";
    Esperar 30 Milisegundos;
	Escribir "                     | /            \\      \\ ______ /      /______..    \\ |                                  ";
    Esperar 30 Milisegundos;
	Escribir "                     /              |      \\\\______//      |        \\     \\                                 ";
    Esperar 30 Milisegundos;
	Escribir "                                    |       \\ ____ /       |LLLLL/_  \\                                      ";
    Esperar 30 Milisegundos;
	Escribir "                                    |      / \\____/ \\      |      \\   |                                     ";
    Esperar 30 Milisegundos;
	Escribir "                                    |     / / \\__/ \\ \\     |     __\\  /__                                    ";
	Esperar 30 Milisegundos;
    Escribir "                                    |    | |        | |    |     \\      /                                     ";
	Esperar 30 Milisegundos;
    Escribir "                                    |    | |        | |    |      \\    /                                      ";
	Esperar 30 Milisegundos;
    Escribir "                                    |    |  \\      /  |    |       \\  /                                       ";
	Esperar 30 Milisegundos;
    Escribir "                                    |     \\__\\    /__/     |        \\/                                        ";
	Esperar 30 Milisegundos;
    Escribir "                                   /    ___\\  )  (  /___    \\                                               ";
	Esperar 30 Milisegundos;
    Escribir "                                  |/\\/\\|    )      (    |/\\/\\|                                              ";
	Esperar 30 Milisegundos;
    Escribir "                                  ( (  )                (  ) )                                              ";      
	Esperar 30 Milisegundos;
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
	Escribir "*                          1. Laberinto del Dragón                   *";
	Escribir "*                          2. Buscaminas                             *";
	Escribir "*                          3. Salir                                  *";
	Escribir "*                                                                    *";
	Escribir "**********************************************************************";
	
	Escribir "Por favor, ingrese una opción (1, 2, 3): ";
	Leer opcion;
	
	Segun opcion Hacer
		Caso 1:
			juegoLaberinto;
		Caso 2:
			Escribir "Cargando Buscaminas...";			
			Esperar 1 Segundos;
			juegoBuscaminas;
		Caso 3:
			Escribir "Saliendo...";
			
		De Otro Modo:
			Escribir "Opción no válida. Por favor, ingrese una opción correcta.";
			Esperar 3 Segundos;
			Borrar Pantalla;
			pantallaEleccionJuego();
	FinSegun
FinSubProceso

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
	animacionCierre;
FinSubProceso

SubProceso juegoBuscaminas
	Definir a Como Entero;
	a <- 0;
	buscaMinas(a);
FinSubProceso