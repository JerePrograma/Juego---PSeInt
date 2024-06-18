SubProceso BuscaHongos
	
	Dimension num[9,9];Dimension fan[9,9];
	Definir num,fan,mina_pisada,num_minas_car como caracter;
	Definir salir,retirada como caracter;
	Definir num_minas,opcion_numero,op,fil,col,i,j,xe,ye,verificar,varX,varY,busX,busY,marX,marY,nivel,opc como Entero;
	retirada<-'';
	Repetir
		limpiar pantalla;
		Escribir "*******************************************************************";
		Escribir "*******************************************************************";
		Escribir "**************   BUSCA HONGOS DEL REINO OLVIDADO    ****************";	
		Escribir "**************        1. JUEGO NUEVO                ****************";
		Escribir "**************        2. SALIR                      ****************";
		Escribir "*******************************************************************";
		Escribir "*******************************************************************";
		Escribir "*****PARA JUGAR INGRESÁ LAS COORDENADAS (X primero, Y segundo)*****";
		Leer opcion_numero;
		
		Segun opcion_numero Hacer
		1:
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
			
			num_minas<-0;
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
					Escribir "GANASTE!!"; retirada<-"s";
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
				
				Escribir "Coordenada en  X";
				Leer varX;
				Escribir "Coordenada en  Y";
				Leer varY;
				
				si varX>=1 y varY>=1 y varX<=7 y varY<=7 entonces
					mina_pisada<-num[varY,varX];
					
					si !mina_pisada="X" entonces
						
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
									num_minas <- num_minas+1;
								FinSi
								
								
						Hasta Que op=9
							num_minas_car<-ConvertirATexto(num_minas);
							fan[varY,varX]<- num_minas_car;
							op<-1;num_minas<-0;
					Sino
						LimpiarPantalla;
						Escribir "       1   2   3   4   5   6   ";
						para j<-1 hasta 6 con paso 1 hacer
							Escribir j,"     | ",num[j,1]," | ",num[j,2]," | ",num[j,3]," | ",num[j,4]," | ",num[j,5]," | ",num[j,6]," | ";
						FinPara
						
						Escribir "*************************************";
						Escribir "HAS PISADO UN HONGO Amanita phalloides, SI ES MORTAL !!";
						Escribir "GAME OVER";
						Escribir "YOU DEAD, in game!!!";
						esperar tecla;
						retirada<-"s";
					FinSi
				Sino si varX=11 o varY=11 entonces
						Escribir "¿Estas seguro que quieres retirarte del Juego?[S/N]";
						leer retirada;
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
		2:
			Escribir "Gracias por usar este aparato de creacion hee magico!!";
		
		De Otro Modo:
			Escribir "Entrada no valida, eres un orco?";
		FinSegun
		
Hasta Que opcion_numero=2
FinSubProceso