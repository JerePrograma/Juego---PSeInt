SubProceso presionar ( p1,p2,px Por Referencia,py Por Referencia, signo Por Referencia )
	Definir eleccion Como entero;//ojo que deberia ser caracter
	Escribir "Digite una A S D W para moverte";
	Leer eleccion;
	//eleccion<-Minusculas(eleccion);
	
	Segun eleccion Hacer
		a:
			px<-p1;
			py<-p2-1;
			signo<-"<";
		s:
			px<-p1+1;
			py<-p2;
			signo<-"v";
		d:
			px<-p1;
			py<-p2+1;
			signo<-">";
		w:
			px<-p1-1;
			py<-p2;
			signo<-"^";
		De Otro Modo:
			Escribir "Te saliste del mapa, te moriste no hay de otra";
	FinSegun
FinSubProceso

SubProceso seguimiento( tam,pintar_1 )
	Definir i,j Como Entero;
	Definir px,py,p1,p2 Como Entero;
	Definir signo Como Caracter;
	
	p1<-0;
	p2<-0;
	
	presionar(p1,p2,px,py,signo);
	
	// Abajo                       Derecha              Izquierda           Arriba
	Mientras ((px<-p1+1 y py<-p2) o (px<-p1 y py <-p2+1) o (px<-p1 y py<-p2-1) o (px<-p1-1 y py<-p2)) y (pintar_1(px,py)<>"x") y pintar_1(px,py)<>"[]" Hacer
		
		pintar_1(px,py)<-signo;
		
		solo_pintar(tam,pintar_1);
		
		p1<-px; //tomar posicion anterior
		p2<-py;
		
		presionar(p1,p2,px,py,signo);
		
		Si pintar_1(px,py)<>"x" Entonces
			pintar_1(p1,p2)<-"o";
		FinSi
		
		
		Si pintar_1(px,py)="x" Entonces
			Escribir "Chocaste contra una pared de clavos";
		FinSi
		
		Si pintar_1(px,py)="[]" Entonces
			Escribir "llegaste, descansa aqui guerrero!";
		FinSi
		
	FinMientras
	Si pintar_1(px,py)="t" Entonces
		solo_pintar(tam,pintar_1);
	FinSi
	
	
FinSubProceso

SubProceso solo_pintar( tam,pintar_1 )//solo pinta la pantalla
	Definir i,j Como Entero;
	
	Para i<-0 Hasta tam-1 Hacer
		Para j<-0 Hasta tam-1 Hacer
			Escribir pintar_1(i,j)Sin Saltar;
		FinPara
		Escribir " ";
	FinPara
	
FinSubProceso

SubProceso definirParedes( tam,pintar_1 )
	Definir i,j,menos,alea Como Entero;
	menos<-tam-1;
	
	Para i<-0 Hasta tam-1 Hacer
		
		Para j<-0 Hasta tam-1 hacer//agregado hacer en i y j
			Si i<-0 o i<-tam-1 o j<-0 o j<-tam-1 Entonces
				pintar_1(i,j)<-pintar_1(i,j);
			SiNo
				si i<- trunc(tam/2) y j<- tam-menos Entonces //agregado entonces
					
					pintar_1(i,j)<-pintar_1(i,j);
					menos<-menos-1;
					si menos<-1 o menos<-0 Entonces
						pintar_1(i,j)<-"x"; //faltara espacio?
						pintar_1(i,j+1)<-"x";
					FinSi
				SiNo
					pintar_1(i,j)<-"x";
				FinSi
			FinSi
		FinPara
	FinPara
	
FinSubProceso



SubProceso pintarPantalla( tam,pintar_1 )//pinta en la pantalla y asigna valores a la matriz con o y p
	Definir i,j Como Entero;
	Para i<-0 Hasta tam-1 Hacer
		Para j<-0 Hasta tam-1 Hacer
			pintar_1(i,j)<-"o";
			Si j<-0 y i<-0 Entonces
				pintar_1(i,j)<-"C";
			FinSi
			Si j<-tam-1 y i<-tam-1 Entonces
				pintar_1(i,j)<-"[]";
			FinSi
		FinPara
		Escribir " ";
	FinPara
	
FinSubProceso




Proceso laberinto
	
	
	Definir tam,p_actual Como Entero;
	Definir pintar_1, comienza Como Caracter;
	Escribir "defina el tamaño de la matriz";
	Leer tam;
	Dimension pintar_1(10,10);
	Escribir "Comienza el viaje en (escribir 1er mapa)";
	
	pintarPantalla(tam,pintar_1);
	definirParedes(tam,pintar_1);
	
	Escribir "Cargando Juego ...";
	Escribir "Digite cualquier letra para continuar";
	Leer comienza;
	
	solo_pintar(tam,pintar_1);
	Escribir "En que posicion quieres moverte?";
	
	seguimiento(tam,pintar_1);
FinProceso
