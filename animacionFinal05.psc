Proceso animacionFinal05
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
        Para j <- 0 Hasta 25 Hacer
            Si j + altura < 40 Entonces
                Escribir dragon[j + altura];
            FinSi
        FinPara
        // Esperar un poco antes de la siguiente iteración
        Esperar 200 Milisegundos;
        contador <- contador + 1;
    FinPara
	
FinProceso

SubProceso espacios(x)
    Definir i Como Entero;
    Para i <- 0 Hasta x-1 Hacer
        Escribir Sin Saltar " ";
    FinPara
FinSubProceso
