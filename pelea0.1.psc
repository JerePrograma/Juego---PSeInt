Proceso pelea
	
	Definir vidaPj, vidaEnemigo Como Entero;
	Definir ataquePj, ataqueEnemigo, turno Como Entero;
	Definir ganador Como Caracter;
	
	//asignamos vida
	
	vidaPj <- 100;
	vidaEnemigo <- 100;
	
	//se define turno aleatorio
	//0 pj, 1 enemigo
	turno <-azar(3);
	
	//entramos al ciclo
	
	Escribir "Vida del Caballero", vidaPj, " HP";
	Escribir "Vida del Enemigo", vidaEnemigo, " HP";
	
	
	Mientras vidaPj >= 0 Y vidaEnemigo >= 0 Hacer
		
		//asignamos la cantidad de ataque que tendran
		
		ataquePj <- azar(80);
		ataqueEnemigo<- azar(50);
		
		si turno = 1 Entonces
			Escribir " ";
			Escribir "Turno: Enemigo";
			Escribir " La vida actual del Caballero: ", vidaPj, " HP";
			vidaPj <- vidaPj - ataqueEnemigo;
			
			Escribir "Ataque del Enemigo: -", ataqueEnemigo;
			Escribir "Vida del Caballero restante ", vidaPj, " HP";
			turno <- 0;
		SiNo
			Escribir " ";
			Escribir "Turno: Caballero";
			Escribir "La vida actual del Enemigo: ",vidaEnemigo," HP";
			vidaEnemigo <- vidaEnemigo - ataquePj;
			Escribir "Ataque del Caballero: -", ataquePj;
			Escribir "Vida del Enemigo restante: ", vidaEnemigo, " HP";
			turno <- 1;
		FinSi
		
	FinMientras
	Si vidaPj <= 0 Entonces
		ganador<- "Ganador es el enemigo, as muerto en combate";
	SiNo
		ganador<- "Ganador es nuestro Caballero";
	FinSi
	
	Escribir " ";
	Escribir ganador;
	
FinProceso
