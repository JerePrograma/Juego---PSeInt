Proceso animacion
    Definir pj Como Caracter;
    Definir i, j,k Como Entero;
    
    Escribir "Presione una tecla para iniciar la animación";
    Esperar Tecla;
    
    Dimension pj[5];
    
    pj[0] <- " |__|__|  |--|";
    pj[1] <- " |0 | 0|  | _|";  
    pj[2] <- "||-- --|| ||";
    pj[3] <- "#|__ __|--#";
    pj[4] <- " |__|__|  ";
    
    Para i <- 0 Hasta 10  Hacer // Ajustamos el número de iteraciones para moverse a lo largo de la pantalla
        Borrar Pantalla;
        
        // Mostrar el personaje y el movimiento hacia la derecha
        Para j <- 0 Hasta 4 Hacer
            // Imprimir espacios en blanco para simular el movimiento hacia la derecha
            Para k <- 0 Hasta i Hacer
                Escribir " ";
            FinPara
            Escribir pj[j];
        FinPara
        
        // Esperar un poco antes de pasar a la siguiente iteración
        Esperar 0.5 Segundos;
    FinPara
    
    Esperar 10 Segundos;
    Borrar Pantalla;
FinProceso
//   -_-_-
//  |    |
//  \ Y /
//  |~~|   +
//  |w|   __
// | |   | |
// ******
// *OO*
// *****
//W******W
//()****()
//               |#####|
//                 ||
//      (\^^/)    ||
//      [* *]    ||
//    O######====#
//   || ***     |
//#=|| ===     v
//   // \\
//  ||  ||
// //   \\