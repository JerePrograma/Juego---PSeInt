/* Este codigo ha sido generado por el modulo psexport 20230113-w32 de PSeInt.
Es posible que el codigo generado no sea completamente correcto. Si encuentra
errores por favor reportelos en el foro (http://pseint.sourceforge.net). */

// En java, el nombre de un archivo fuente debe coincidir con el nombre de la clase que contiene,
// por lo que este archivo debería llamarse "PRINCIPAL.java."

// Hay dos errores que se pueden generar al exportar un algoritmo con subprocesos desde PSeint a Java:
// 1) En java no se puede elegir entre pasaje por copia o por referencia. Técnicamente solo existe el
// pasaje por copia, pero los identificadores de objetos representan en realidad referencias a los
// objetos. Entonces, el pasaje para tipos nativos actúa como si fuera por copia, mientras que el
// pasaje para objetos (como por ejemplo String) actúa como si fuera por referencia. Esto puede llevar
// a que el algoritmo exportado no se comporte de la misma forma que el algoritmo original, en cuyo
// caso deberán modificarse algunos métodos (subprocesos exportados) para corregir el problema.
// 2) Las funciones que hacen lectura por teclado deben lazar una excepción. Si una función A es
// invocada por otra B, B también debe manejar (lanzar en este caso) las execpciones que lance A.
// Esto no se cumple en el código generado automáticamante: las funciones que realizan lecturas
// directamente incluyen el código que indica que pueden generar dicha excepción, pero las que
// lo hacen indirectamente (invocando a otras que sí lo hacen), puede que no, y deberán ser
// corregidas manualmente.

import entidades.Personaje;
import servicios.PersonajeServicio;

import java.io.*;
import java.math.*;

import static servicios.PersonajeServicio.mostrarmensajeestadisticaspersonaje;
import static servicios.PersonajeServicio.mostrarmensajeingresarnombre;
import static utilidades.Util.*;

public class JuegoLaberintoDragon {
    static PersonajeServicio personajeServicio = new PersonajeServicio();
    static BufferedReader bufEntrada = new BufferedReader(new InputStreamReader(System.in));

    // ----------------------------------------------------
    // ------------------   CONSTANTES   ------------------
    // ----------------------------------------------------
    public static String obtenerestadoinicial() {
        String estado_inicial;
        estado_inicial = "0000";
        return estado_inicial;
    }

    public static String obtenerestadoteclainvalida() {
        String estado_tecla_invalida;
        estado_tecla_invalida = "0001";
        return estado_tecla_invalida;
    }

    public static String obtenerestadomovimientoinvalido() {
        String estado_movimiento_invalido;
        estado_movimiento_invalido = "0002";
        return estado_movimiento_invalido;
    }

    public static String obtenerestadocolisionpared() {
        String estado_colision_pared;
        estado_colision_pared = "0003";
        return estado_colision_pared;
    }

    public static String obtenerestadomostrarestadisticas() {
        String estado_mostrar_estadisticas;
        estado_mostrar_estadisticas = "0004";
        return estado_mostrar_estadisticas;
    }

    // ----------------------------------------------------
    // ---------------------  INICIO  ---------------------
    // ----------------------------------------------------
    public static void main(String[] args) throws IOException, InterruptedException {
        String[] dragonmatriz;
        String[][] matrizespacial;
        int tam;
        String[] textoarcadedavinci;
        matrizespacial = new String[30][30];
        textoarcadedavinci = new String[24];
        dragonmatriz = new String[11];
        tam = 29;
        rellenarmatrizespacial(tam, matrizespacial);
        System.out.println(); // no hay forma directa de borrar la consola en Java
        dibujardragon();
        inicializarmatrizdragon(dragonmatriz);
        simularmovimiento(dragonmatriz);
        inicializartextomatriz(textoarcadedavinci);
        pantallapreviacargajuegos();
        System.in.read(); // a diferencia del pseudocódigo, espera un Enter, no cualquier tecla
        System.out.println(); // no hay forma directa de borrar la consola en Java
        pantallaeleccionjuego();
    }

    // ----------------------------------------------------
    // ---------------------   JUEGO   --------------------
    // ----------------------------------------------------
    public static void juegolaberinto() throws IOException, InterruptedException {
        String[][] estadooriginal;
        String[][] laberinto;
        int tamlaberinto;
        laberinto = new String[20][20];
        estadooriginal = new String[20][20];
        tamlaberinto = 20;
        // Tamaño del laberinto
        inicializarlaberinto(tamlaberinto, laberinto);
        inicializarestadooriginal(tamlaberinto, laberinto, estadooriginal);
        // Inicializar enemigos en el laberinto
        colocarenemigosaleatorios(tamlaberinto, laberinto, estadooriginal, 4);
        // Colocar 3 enemigos aleatorios
        // Mostrar el laberinto
        mostrarlaberinto(tamlaberinto, laberinto);
        Personaje personaje = personajeServicio.crearPersonaje();
        seguimiento(personaje, tamlaberinto, laberinto, estadooriginal);
    }

    // ----------------------------------------------------
    // -------------  INICIALIZAR LABERINTO  --------------
    // ----------------------------------------------------
    public static void inicializarlaberinto(int tam, String[][] laberinto) throws InterruptedException {
        int n;
        int tamlaberinto;
        tamlaberinto = tam;
        // Usar el parámetro tam pasado al subproceso
        poblarlaberinto(tamlaberinto, laberinto);
        System.out.println("Creando Mundo...");
        System.out.println();
        ilustracionmenu();
        while (!esconectado(tamlaberinto, laberinto)) {
            poblarlaberinto(tamlaberinto, laberinto);
            for (n = 0; n <= 4; ++n) {
                aplicarreglas(tamlaberinto, laberinto);
            }
        }
        // Limpiar alrededores de la entrada y la salida
        laberinto[0][1] = " ";
        laberinto[1][0] = " ";
        laberinto[1][1] = " ";
        laberinto[(tamlaberinto - 1)][(tamlaberinto - 1) - 1] = " ";
        laberinto[(tamlaberinto - 1) - 1][(tamlaberinto - 1)] = " ";
        laberinto[(tamlaberinto - 1) - 1][(tamlaberinto - 1) - 1] = " ";
        laberinto[tam - 1][tam - 1] = "[";
        poblarlaberintoenemigos(tamlaberinto, laberinto);
        System.out.println(); // no hay forma directa de borrar la consola en Java
    }

    public static void inicializarestadooriginal(double tam, String[][] laberinto, String[][] estadooriginal) {
        int columna;
        int fila;
        for (fila = 0; fila <= tam - 1; ++fila) {
            for (columna = 0; columna <= tam - 1; ++columna) {
                estadooriginal[fila][columna] = laberinto[fila][columna];
            }
        }
    }

    public static void colocarenemigosaleatorios(int tam, String[][] laberinto, String[][] estadooriginal, int cantidadenemigos) {
        int contador;
        int enemigoposx;
        int enemigoposy;
        contador = 0;
        while (contador < cantidadenemigos) {
            enemigoposx = lanzarDado(0, (tam - 1));
            enemigoposy = lanzarDado(0, (tam - 1));
            if (laberinto[enemigoposx][enemigoposy].equals(" ")) {
                laberinto[enemigoposx][enemigoposy] = "E";
                estadooriginal[enemigoposx][enemigoposy] = " ";
                // Actualizar el estadoOriginal con un espacio
                contador = contador + 1;
            }
        }
    }

    // ----------------------------------------------------
    // --------------------  EJECUCION  -------------------
    // ----------------------------------------------------
    public static void seguimiento(Personaje personaje, int tam, String[][] laberinto, String[][] estadooriginal) throws IOException, InterruptedException {
        String estadoaccion;
        boolean juegoactivo;
        int posx;
        int posxnueva;
        int posy;
        int posynueva;
        String simbolojugador;
        simbolojugador = "J";
        juegoactivo = true;
        estadoaccion = "0000";
        posx = 0;
        posy = 0;
        // Asumiendo que el jugador empieza en la esquina superior izquierda
        laberinto[posx][posy] = simbolojugador;
        // Colocamos al jugador en la posición inicial
        while (juegoactivo) {
            System.out.println(); // no hay forma directa de borrar la consola en Java
            mostrarlaberinto(tam, laberinto);
            posxnueva = posx;
            // Preparar las nuevas posiciones
            posynueva = posy;
            // Obtener la nueva posición basada en la entrada del usuario
            presionar(estadoaccion, posx, posy, posxnueva, posynueva, simbolojugador, laberinto, tam);
            // Verificar y actualizar la posición
            if (posxnueva != posx || posynueva != posy) {
                // Si hay un cambio de posición
                evaluarposicion(tam, laberinto, estadooriginal, posxnueva, posynueva, posx, posy, simbolojugador, juegoactivo, personaje);
                if (juegoactivo) {
                    // Actualizar las posiciones antiguas y nuevas
                    posx = posxnueva;
                    posy = posynueva;
                }
            } else {
                if (estadoaccion.equals("0004")) {
                    System.out.println("Presione una tecla para continuar");
                    System.in.read(); // a diferencia del pseudocódigo, espera un Enter, no cualquier tecla
                }
            }
        }
    }

    public static void presionar(String estadoaccion, int posx, int posy, double posxnueva, double posynueva, String simbolojugador, String[][] laberinto, double tam) throws IOException {
        String direccion;
        String eleccionletra;
        int eleccionnumero;
        mostrarmensajeaccionesmapa(estadoaccion);
        eleccionletra = bufEntrada.readLine();
        eleccionletra = eleccionletra.toLowerCase();
        if (eleccionletra.equals("a")) {
            eleccionnumero = 1;
        } else {
            if (eleccionletra.equals("s")) {
                eleccionnumero = 2;
            } else {
                if (eleccionletra.equals("d")) {
                    eleccionnumero = 3;
                } else {
                    if (eleccionletra.equals("w")) {
                        eleccionnumero = 4;
                    } else {
                        if (eleccionletra.equals("e")) {
                            eleccionnumero = 5;
                        } else {
                            eleccionnumero = -1;
                            // Invalid
                        }
                    }
                }
            }
        }
        switch (eleccionnumero) {
            case 1:
                // Izquierda
                if (posy > 0) {
                    if (!laberinto[posx][posy - 1].equals("X")) {
                        posynueva = posy - 1;
                        estadoaccion = "0000";
                    } else {
                        estadoaccion = "0003";
                    }
                } else {
                    estadoaccion = "0002";
                }
                break;
            case 2:
                // Abajo
                if (posx < tam - 1) {
                    if (!laberinto[posx + 1][posy].equals("X")) {
                        posxnueva = posx + 1;
                        estadoaccion = "0000";
                    } else {
                        estadoaccion = "0003";
                    }
                } else {
                    estadoaccion = "0002";
                }
                break;
            case 3:
                // Derecha
                if (posy < tam - 1) {
                    if (!laberinto[posx][posy + 1].equals("X")) {
                        posynueva = posy + 1;
                        estadoaccion = "0000";
                    } else {
                        estadoaccion = "0003";
                    }
                } else {
                    estadoaccion = "0002";
                }
                break;
            case 4:
                // Arriba
                if (posx > 0) {
                    if (!laberinto[posx - 1][posy].equals("X")) {
                        posxnueva = posx - 1;
                        estadoaccion = "0000";
                    } else {
                        estadoaccion = "0003";
                    }
                } else {
                    estadoaccion = "0002";
                }
                break;
            case 5:
                estadoaccion = "0004";
                break;
            default:
                estadoaccion = "0001";
        }
    }

    public static void evaluarposicion(int tam, String laberinto[][], String estadooriginal[][], int posxnueva, int posynueva, int posx, int posy, String simbolojugador, boolean juegoactivo, Personaje personaje) throws InterruptedException, IOException {
        if (laberinto[posxnueva][posynueva].equals("X")) {
            mostrarmensaje("¡Hay una pared aquí!");
            posxnueva = posx;
            // Revertir el movimiento
            posynueva = posy;
        } else {
            if (laberinto[posxnueva][posynueva].equals("E")) {
                mostrarmensaje("¡Un enemigo! Prepárate para luchar");
                Thread.sleep(2 * 1000);
                pelea(personaje);
                laberinto[posx][posy] = estadooriginal[posx][posy];
                // Actualizar la posición anterior del jugador
                laberinto[posxnueva][posynueva] = simbolojugador;
                // Mover el jugador a la nueva posición
                estadooriginal[posxnueva][posynueva] = " ";
                // Actualizar estadoOriginal
            } else {
                if (laberinto[posxnueva][posynueva].equals("[")) {
                    buscahongos();
                    mostrarmensaje("¡Llegaste, descansa en esta hoguera guerrero!");
                    juegoactivo = false;
                } else {
                    laberinto[posx][posy] = estadooriginal[posx][posy];
                    // Actualizar la posición anterior del jugador
                    laberinto[posxnueva][posynueva] = simbolojugador;
                    // Mover el jugador a la nueva posición
                }
            }
        }
        System.out.println(""); // no hay forma directa de borrar la consola en Java
    }



    public static void pelea(Personaje personaje) throws IOException, InterruptedException {
        int agilidadenemigo;
        int danioalenemigo;
        int daniorecibidoenemigo;
        int daniorecibidopersonaje;
        int defensaenemigo;
        String eleccion;
        int eleccionnumero;
        int fuerzaenemigo = 0;
        int inteligenciaenemigo;
        int valordadoenemigo;
        int valordadopersonaje;
        int vidaenemigo = 0;
        int vidamaximapersonaje;
        // Obtener las características del enemigo
     //   inicializarenemigo(vidaenemigo, fuerzaenemigo, defensaenemigo, agilidadenemigo, inteligenciaenemigo);
        // Simulación del combate (aquí puedes agregar la lógica del combate)
        System.out.println("Vida del enemigo: " + vidaenemigo);
        while (vidaenemigo > 0 && personaje.getVida() > 0) {
            daniorecibidopersonaje = 0;
            daniorecibidoenemigo = 0;
            danioalenemigo = 0;
            do {
                mostrarmensajeaccionespelea();
                eleccion = bufEntrada.readLine();
                if (eleccion.equals("a") || eleccion.equals("A")) {
                    eleccionnumero = 1;
                } else {
                    if (eleccion.equals("d") || eleccion.equals("D")) {
                        eleccionnumero = 2;
                    } else {
                        if (eleccion.equals("e") || eleccion.equals("E")) {
                            eleccionnumero = 3;
                        } else {
                            eleccionnumero = 4;
                        }
                    }
                }
                valordadoenemigo = lanzarDado(1, 2);
                switch (eleccionnumero) {
                    case 1:
                        System.out.println("Te posicionas para atacar al enemigo");
                        break;
                    case 2:
                        System.out.println("Te posicionas para defenderte");
                        break;
                    case 3:
                        //mostrarmensajeestadisticaspersonaje(nombrepersonaje, vidapersonaje, experienciapersonaje, fuerzapersonaje, defensapersonaje, agilidadpersonaje, inteligenciapersonaje, nivelpersonaje, estadopersonaje);
                        break;
                    case 4:
                        System.out.println("Opción no válida! Ingrese nuevamente");
                        break;
                }
                Thread.sleep(2 * 1000);
            } while (!(eleccionnumero == 1 || eleccionnumero == 2));
            Thread.sleep(1 * 1000);
            if (valordadoenemigo == 1) {
                System.out.println("El enemigo se posiciona para atacarte!");
            } else {
                System.out.println("El se pone en postura defensiva!");
            }
            Thread.sleep(2 * 1000);
            if (eleccionnumero == 2 && valordadoenemigo == 2) {
                System.out.println("Los dos se quedan mirando en postura de defensa");
                Thread.sleep(2 * 1000);
            } else {
                if (eleccionnumero == 1 && valordadoenemigo == 1) {
                    System.out.println("Ambos atacan al mismo tiempo! Se cruzan los ataques!");
                    System.out.println("Atacas!");
                    valordadopersonaje = lanzarDadoAnimacion();
                    if (valordadopersonaje == 1) {
                        System.out.println("Te tropiezas y te atacas solo");
                        System.out.println("Te haces " + personaje.getFuerza() * 10 / 100 + " de daño");
                        personaje.setVida(personaje.getVida() -  (int) Math.floor((personaje.getFuerza() * 10 / 100)));
                    } else {
                        if (valordadopersonaje < 3) {
                            System.out.println("Fallaste! Sacaste un " + valordadopersonaje);
                        } else {
                            if (valordadopersonaje == 6) {
                                System.out.println("Lo atacas con una furia desenfrenada!! Le haces 200% de tu daño!");
                                danioalenemigo =  (int) personaje.getFuerza() * 2;
                            } else {
                                System.out.println("Lo atacas! Sacaste un " + valordadopersonaje + ", le haces el " + (valordadopersonaje - 1) * 20 + "% de tu daño");
                                danioalenemigo = (int) Math.round(personaje.getFuerza() * ((valordadopersonaje - 1) * 20 / 100));
                            }
                        }
                    }
                    vidaenemigo = vidaenemigo - danioalenemigo;
                    System.out.println("Le hiciste " + danioalenemigo + " de daño al enemigo");
                    Thread.sleep(2 * 1000);
                    System.out.println("El enemigo te ataca!");
                    valordadoenemigo = lanzarDadoAnimacion();
                    if (valordadoenemigo == 1) {
                        System.out.println("Se tropieza y se ataca solo");
                        System.out.println("Se hace " + fuerzaenemigo * 10 / 100 + " de daño");
                        vidaenemigo = vidaenemigo - (int) Math.floor((fuerzaenemigo * 10 / 100));
                    } else {
                        if (valordadoenemigo < 3) {
                            System.out.println("Falló el ataque! Sacó un " + valordadoenemigo);
                        } else {
                            if (valordadoenemigo == 6) {
                                System.out.println("Te golpea con toda su furia! Te hace 200% de su daño");
                                daniorecibidopersonaje = (int) Math.floor((fuerzaenemigo * 2));
                            } else {
                                System.out.println("Sacó un " + valordadoenemigo + ", te hace el " + (valordadoenemigo - 1) * 20 + "% de su daño");
                                daniorecibidopersonaje = Math.round(fuerzaenemigo * ((valordadoenemigo - 1) * 20 / 100));
                            }
                        }
                    }
                    personaje.setVida(personaje.getVida() - daniorecibidopersonaje);
                    System.out.println("Recibes " + daniorecibidopersonaje + " de daño!");
                } else {
                    if (eleccionnumero == 2 && valordadoenemigo == 2) {
                        System.out.println("Los dos se quedan mirando en postura de defensa");
                    } else {
                        if (eleccionnumero == 1 && valordadoenemigo == 2) {
                            valordadopersonaje = lanzarDadoAnimacion();
                            if (valordadopersonaje == 1) {
                                System.out.println("Te tropezaste y te atacaste solo");
                                System.out.println("Te haces " + personaje.getFuerza() * 10 / 100 + " de daño");
                                personaje.setVida(personaje.getVida() - (int) Math.round((personaje.getFuerza() * 10 / 100)));
                            } else {
                                if (valordadopersonaje < 3) {
                                    System.out.println("Fallaste! Sacaste un " + valordadopersonaje);
                                    danioalenemigo = 0;
                                } else {
                                    if (valordadopersonaje == 6) {
                                        System.out.println("Lo atacas con una furia desenfrenada!! Le haces 200% de tu daño!");
                                        danioalenemigo = (int) personaje.getFuerza() * 2;
                                    } else {
                                        System.out.println("Lo atacas! Sacaste un " + valordadopersonaje + ", le haces el " + (valordadopersonaje - 1) * 20 + "% de tu daño");
                                        danioalenemigo = (int) Math.round(personaje.getFuerza() * ((valordadopersonaje - 1) * 20 / 100));
                                        Thread.sleep(2 * 1000);
                                    }
                                    valordadoenemigo = lanzarDadoAnimacion();
                                    if (valordadoenemigo < 3) {
                                        System.out.println("El enemigo no se defiende! Queda al descubierto, sacó un " + valordadoenemigo);
                                        daniorecibidoenemigo = danioalenemigo;
                                    } else {
                                        if (valordadoenemigo == 6 && valordadopersonaje == 6) {
                                            System.out.println("Se pone en una postura perfecta, pero igual logras conectarle el golpe!");
                                            System.out.println("Le haces " + personaje.getFuerza() + " de daño");
                                            daniorecibidoenemigo = danioalenemigo;
                                        } else {
                                            if (valordadoenemigo == 6) {
                                                System.out.println("El enemigo bloquea completamente el ataque! No le haces daño");
                                            } else {
                                                System.out.println("El enemigo se defiende! Sacó un " + valordadoenemigo + ", reduce el " + (valordadoenemigo - 1) * 20 + "% del daño recibido");
                                                daniorecibidoenemigo = Math.round(danioalenemigo * (100 - (valordadoenemigo - 1) * 20) / 100);
                                                System.out.println("Le hiciste " + danioalenemigo + " de daño al enemigo");
                                            }
                                        }
                                    }
                                }
                            }
                        }
                        if (eleccionnumero == 2 && valordadoenemigo == 1) {
                            valordadoenemigo = lanzarDadoAnimacion();
                            if (valordadoenemigo == 1) {
                                System.out.println("Se tropieza y se ataca solo");
                                System.out.println("Se hace " + fuerzaenemigo * 10 / 100 + " de daño");
                                vidaenemigo = vidaenemigo - (fuerzaenemigo * 10 / 100);
                            } else {
                                if (valordadoenemigo < 3) {
                                    System.out.println("Falló el ataque! Sacó un " + valordadoenemigo);
                                } else {
                                    System.out.println("Se te acerca para acertarte");
                                    if (eleccionnumero == 2) {
                                        valordadopersonaje = lanzarDadoAnimacion();
                                        if (valordadopersonaje < 3) {
                                            System.out.println("Defensa fallida! Quedas al descubierto, sacaste un " + valordadopersonaje);
                                        } else {
                                            System.out.println("Defensa exitosa! Sacaste un " + valordadopersonaje + ", reduces el " + (valordadopersonaje - 1) * 20 + "% del daño recibido");
                                            daniorecibidopersonaje = Math.round((valordadopersonaje - 1) * 20 / 100);
                                        }
                                        if (daniorecibidopersonaje == 100) {
                                            System.out.println("Bloqueaste completamente el ataque!");
                                        } else {
                                            if (valordadoenemigo == 6) {
                                                System.out.println("Te golpea con toda su furia! Te hace 200% de su daño");
                                                daniorecibidopersonaje = Math.round((fuerzaenemigo * 2 * (100 - daniorecibidopersonaje) / 100));
                                            } else {
                                                System.out.println("Te dió! Sacó un " + valordadoenemigo + ", te hace el " + (valordadoenemigo - 1) * 20 + "% de su daño");
                                                daniorecibidopersonaje = Math.round((fuerzaenemigo * ((valordadoenemigo - 1) * 20 / 100)) * (100 - daniorecibidopersonaje) / 100);
                                            }
                                            System.out.println("Recibes " + daniorecibidopersonaje + " de daño!");
                                            personaje.setVida(personaje.getVida() - daniorecibidopersonaje);
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
        if (personaje.getVida() <= 0) {
            System.out.println("El enemigo te mató!");
            System.out.println("Por la gracia del dios te da una nueva oportunidad y te revive");
            System.out.println("El enemigo al ver que te levantas nuevamente, huye");
        } else {
            System.out.println("¡Has derrotado al enemigo!");
            System.out.println("Luego de una larga batalla descansas y te recuperas");
        }
        personaje.setVida(personaje.getVidaMaxima());
        Thread.sleep(2 * 1000);
    }
//////////////////////////////////////////////////////////MEJORAR LÓGICA CREACIÓN ENEMIGO - PATRÓN DE DISEÑO FACTORY
//    public static void inicializarenemigo(double vidaenemigo, int fuerzaenemigo, int defensaenemigo, int agilidadenemigo, int inteligenciaenemigo) {
//        vidaenemigo = 10 + aleatorio(0, 10);
//        fuerzaenemigo = aleatorio(1, 5);
//        defensaenemigo = aleatorio(1, 5);
//        agilidadenemigo = aleatorio(1, 5);
//        inteligenciaenemigo = aleatorio(1, 5);
//    }

    // ----------------------------------------------------
    // -------------------   PANTALLA   -------------------
    // ----------------------------------------------------
    // Imprime el mensaje ingresado dentro de un recuadro
    // El mensaje se ajustará a la cantidad de caracteres indicadas en longMensaje
    // El recuadro tiene una longitud de longMensaje + 4 ( = los 2 bordes + los 2 espacios de margen)
    public static void mostrarmensaje(String mensaje) {
        int i;
        int longmensaje;
        String palabras;
        String piso;
        String techo;
        longmensaje = 38;
        techo = "|-";
        piso = "|_";
        for (i = 1; i <= longmensaje; ++i) {
            techo = techo.concat("-");
            piso = piso.concat("_");
        }
        techo = techo.concat("-|");
        piso = piso.concat("_|");
        System.out.println(techo);
        for (i = 0; i <= mensaje.length() - 1; i += longmensaje) {
            palabras = mensaje.substring(i, i + longmensaje);
            escrituraMensaje(palabras.substring(0, longmensaje), longmensaje);
        }
        System.out.println(piso);
    }

    public static void mostrarmensajeaccionespelea() {
        String mensaje;
        mensaje = "";
        mensaje = mensaje.concat(" Ingrese una acción:                     ");
        mensaje = mensaje.concat("               (E) Stats                 ");
        mensaje = mensaje.concat("    Atacar (A)     (D) Defender          ");
        mensaje = mensaje.concat("                                         ");
        mostrarmensaje(mensaje);
    }

    public static void mostrarmensajemenuinicio(String estado) throws InterruptedException {
        String mensaje;
        ilustracionmenu();
        mensaje = "";
        if (estado.equals("0001")) {
            mensaje = "¡Opción inválida!                     ";
        }
        mensaje = mensaje.concat(" (1) Iniciar Juego                    ");
        mensaje = mensaje.concat(" (2) Salir                            ");
        mostrarmensaje(mensaje);
    }

    public static void mostrarlaberinto(double tam, String laberinto[][]) {
        int columna;
        int fila;
        for (fila = 0; fila <= tam - 1; ++fila) {
            for (columna = 0; columna <= tam - 1; ++columna) {
                System.out.print("[" + laberinto[fila][columna] + "] ");
            }
            System.out.println(" ");
        }
    }

    public static void ilustracionmenu() throws InterruptedException {
        System.out.println("                                         .^^--..__");
        System.out.println("                     _                     []       ``-.._");
        System.out.println("                  . ` ` .                  ||__           `-._");
        System.out.println("                 /    ,-.\\                 ||_ ```---..__     `-.");
        System.out.println("                /    /:::\\\\               /|//}          ``--._  `.");
        System.out.println("                |    |:::||              |////}                `-. \\");
        System.out.println("                |    |:::||             //^///                    `.\\");
        System.out.println("                |    |:::||            //  ||                       `|");
        System.out.println("                /    |:::|/        _,-//\\  ||");
        System.out.println("               /`    |:::|`-,__,-`   |/  \\ |");
        System.out.println("             /`  |   |   ||           \\   |||");
        System.out.println("           /`    \\   |   ||            |  /||");
        System.out.println("         |`       |  |   |)            \\ | ||");
        System.out.println("        |          \\ |   /      ,.__    \\| ||");
        System.out.println("        /           `         /`    `\\   | ||");
        System.out.println("       |                     /        \\  / ||");
        System.out.println("       |                     |        | /  ||");
        System.out.println("       /         /           |        `(   ||");
        System.out.println("      /          .           /          )  ||");
        System.out.println("     |            \\          |     ________||");
        System.out.println("    /             |          /     `-------.|");
        System.out.println("   |\\            /          |              ||");
        System.out.println("   \\/`-._       |           /              ||");
        System.out.println("    //   `.    /`           |              ||");
        System.out.println("   //`.    `. |             \\              ||");
        System.out.println("  ///\\ `-._  )/             |              ||");
        System.out.println(" //// )   .(/               |              ||");
        System.out.println(" ||||   ,`  )               /              //");
        System.out.println(" ||||  /                    /             || ");
        System.out.println(" `\\\\` /`                    |             // ");
        System.out.println("     |`                     \\            ||  ");
        System.out.println("    /                        |           //  ");
        System.out.println("  /`                          \\         //   ");
        System.out.println("/`                            |        ||    ");
        System.out.println("`-.___,-.      .-.        ___,/        (/    ");
        System.out.println("         `---?`   `?----?`");
        System.out.println("USE PANTALLA COMPLETA PARA UNA MEJOR EXPERIENCIA");
        Thread.sleep(3 * 1000);
    }

    public static void poblarlaberinto(double tam, String laberinto[][]) {
        String bloques[];
        int columna;
        int fila;
        bloques = new String[3];
        bloques[0] = " ";
        // Espacio en blanco
        bloques[1] = " ";
        // Segundo espacio (es necesario porque da 66 porciento de probabilidad de que genere un espacio y hace más rápido el proceso)
        bloques[2] = "X";
        for (fila = 0; fila <= tam - 1; ++fila) {
            for (columna = 0; columna <= tam - 1; ++columna) {
                laberinto[fila][columna] = bloques[(int) (Math.floor(Math.random() * 3))];
            }
        }
    }

    public static int contarvecinos(double fila, double columna, double tam, String laberinto[][]) {
        int dx[];
        int dy[];
        int k;
        int ni;
        int nj;
        int vecinos;
        dx = new int[8];
        dy = new int[8];
        vecinos = 0;
        dx[0] = -1;
        dy[0] = -1;
        dx[1] = -1;
        dy[1] = 0;
        dx[2] = -1;
        dy[2] = 1;
        dx[3] = 0;
        dy[3] = -1;
        dx[4] = 0;
        dy[4] = 1;
        dx[5] = 1;
        dy[5] = -1;
        dx[6] = 1;
        dy[6] = 0;
        dx[7] = 1;
        dy[7] = 1;
        for (k = 0; k <= 7; ++k) {
            ni = (int) fila + dx[k];
            nj = (int) columna + dy[k];
            // Verificar si el vecino está dentro de los límites
            if (ni >= 1 && ni <= tam - 1 && nj >= 1 && nj <= tam - 1) {
                if (laberinto[ni][nj].equals("X")) {
                    vecinos = vecinos + 1;
                }
            }
        }
        return vecinos;
    }

    public static void poblarlaberintoenemigos(int tam, String laberinto[][]) {
        int columna;
        int contadore;
        int fila;
        int posicioncolumna;
        int posicionfila;
        contadore = 0;
        while (contadore < 20) {
            posicionfila = (int) Math.floor(Math.random() * tam - 1);
            // Genera una fila aleatoria
            posicioncolumna = (int) Math.floor(Math.random() * tam - 1);
            // Genera una columna aleatoria
            if (laberinto[posicionfila][posicioncolumna].equals(" ")) {
                laberinto[posicionfila][posicioncolumna] = "E";
                contadore = contadore + 1;
            }
        }
    }

    public static void aplicarreglas(int tam, String laberinto[][]) {
        int columna;
        int fila;
        // Reglas 4-5
        for (fila = 1; fila <= tam - 1; ++fila) {
            for (columna = 1; columna <= tam - 1; ++columna) {
                if (laberinto[fila][columna].equals("X") && contarvecinos(fila, columna, tam, laberinto) >= 4 || laberinto[fila][columna].equals(" ") && contarvecinos(fila, columna, tam, laberinto) >= 5) {
                    laberinto[fila][columna] = "X";
                }
            }
        }
        // Punto de entrada y de salida
        laberinto[0][0] = "C";
        laberinto[tam - 1][tam - 1] = "[";
    }

    public static boolean esconectado(int tam, String laberinto[][]) {
        int columna;
        boolean conectado;
        int fila;
        boolean visitado[][];
        visitado = new boolean[20][20];
        // Inicializar el arreglo de visitados
        for (fila = 0; fila <= tam - 1; ++fila) {
            for (columna = 0; columna <= tam - 1; ++columna) {
                visitado[fila][columna] = false;
            }
        }
        // Inicializar DFS desde la entrada
        conectado = dfs(0, 0, tam, laberinto, visitado);
        return conectado;
    }

    public static boolean dfs(int fila, int columna, int tam, String laberinto[][], boolean visitado[][]) {
        int dx[];
        int dy[];
        boolean encontrado;
        int k;
        int nx;
        int ny;
        dx = new int[4];
        dy = new int[4];
        // Movimientos posibles (derecha, abajo, izquierda, arriba)
        dx[0] = 1;
        dy[0] = 0;
        dx[1] = 0;
        dy[1] = 1;
        dx[2] = -1;
        dy[2] = 0;
        dx[3] = 0;
        dy[3] = -1;
        // Si se llega a la salida
        if (fila == tam - 1 && columna == tam - 1) {
            encontrado = true;
        } else {
            // Marcar como visitado
            visitado[fila][columna] = true;
            encontrado = false;
            // Probar cada movimiento posible
            for (k = 0; k <= 3; ++k) {
                nx = fila + dx[k];
                ny = columna + dy[k];
                // Verificar si el siguiente paso es válido
                if (nx >= 0 && nx < tam && ny >= 0 && ny < tam && !visitado[nx][ny] && !laberinto[nx][ny].equals("X")) {
                    encontrado = dfs(nx, ny, tam, laberinto, visitado);
                    if (encontrado) {
                        k = 4;
                        // Salir del bucle para evitar seguir buscando
                    }
                }
            }
        }
        return encontrado;
    }

    public static void buscahongos() throws IOException, InterruptedException {
        int busx;
        int busy;
        int cantidadmuertes;
        int col;
        String fan[][];
        int fil;
        int i;
        int j;
        boolean juegohongos;
        int marx;
        int mary;
        String minapisada;
        int nivel = 0;
        String num[][];
        int numerominas;
        String numerominascaracter;
        int op;
        int opc;
        String opcionletra;
        String retirada;
        String salir;
        int varx;
        int vary;
        int verificar;
        int x;
        int y;
        num = new String[9][9];
        fan = new String[9][9];
        juegohongos = true;
        retirada = "";
        cantidadmuertes = 0;
        do {
            System.out.println(""); // no hay forma directa de borrar la consola en Java
            System.out.println("********************************************************************");
            System.out.println("********************************************************************");
            System.out.println("************     BUSCA HONGOS DEL REINO OLVIDADO      **************");
            System.out.println("************ FELICIDADES JUGADOR, SUPERASTE ESTE MAPA **************");
            System.out.println("***  PARA PASAR AL PRÓXIMO DEBERÁS PASAR POR UN CAMPO DE HONGOS  ***");
            System.out.println("************** PRESIONE CUALQUIER TECLA PARA CONTINUAR **************");
            System.out.println("********************************************************************");
            opcionletra = bufEntrada.readLine();
            do {
                System.out.println(""); // no hay forma directa de borrar la consola en Java
                System.out.println("**************  NIVEL    ");
                System.out.println("**************  1. FACIL [5 hongos]  ");
                System.out.println("**************  2. INTERMEDIO [10 hongos]    ");
                System.out.println("**************  3. DIFICIL  [15 hongos]  ");
                opc = Integer.parseInt(bufEntrada.readLine());
                switch (opc) {
                    case 1:
                        nivel = 5;
                        break;
                    case 2:
                        nivel = 10;
                        break;
                    case 3:
                        nivel = 15;
                        break;
                    default:
                        System.out.println("Opcion no valida");
                }
            } while (!(opc >= 1 && opc <= 3));
            numerominas = 0;
            op = 1;
            for (fil = 0; fil <= 7; ++fil) {
                for (col = 0; col <= 7; ++col) {
                    num[fil][col] = "-";
                    fan[fil][col] = "-";
                }
            }
            // UBICACION DE HONGOS AL AZAR
            for (i = 1; i <= nivel; ++i) {
                x = (int) Math.floor(Math.random() * 6) + 1;
                y = (int) Math.floor(Math.random() * 6) + 1;
                if (num[x][y].equals("-")) {
                    num[x][y] = "X";
                } else {
                    i = i - 1;
                }
            }
            do {
                // VERIFICAR SI HAY HONGOS
                verificar = 0;
                for (fil = 1; fil <= 7; ++fil) {
                    for (col = 1; col <= 7; ++col) {
                        if (fan[fil][col].equals("-")) {
                            verificar = 1;
                        }
                    }
                }
                if (verificar == 0) {
                    System.out.println("_______________________________________________");
                    System.out.println("Has encontrado todas los hongos!!");
                    System.out.println("GANASTE!!");
                    retirada = "s";
                    System.in.read(); // a diferencia del pseudocódigo, espera un Enter, no cualquier tecla
                }
                System.out.println(""); // no hay forma directa de borrar la consola en Java
                System.out.println("---------------------------------");
                System.out.println("       1   2   3   4   5   6    ");
                System.out.println(1 + "    | " + fan[1][1] + " | " + fan[1][2] + " | " + fan[1][3] + " | " + fan[1][4] + " | " + fan[1][5] + " | " + fan[1][6] + " | ");
                System.out.println(2 + "    | " + fan[2][1] + " | " + fan[2][2] + " | " + fan[2][3] + " | " + fan[2][4] + " | " + fan[2][5] + " | " + fan[2][6] + " |      *Marcar Hongo Presione [10]");
                System.out.println(3 + "    | " + fan[3][1] + " | " + fan[3][2] + " | " + fan[3][3] + " | " + fan[3][4] + " | " + fan[3][5] + " | " + fan[3][6] + " |        Despues tecla [enter]");
                System.out.println(4 + "    | " + fan[4][1] + " | " + fan[4][2] + " | " + fan[4][3] + " | " + fan[4][4] + " | " + fan[4][5] + " | " + fan[4][6] + " |      *Retirada presione [11]");
                System.out.println(5 + "    | " + fan[5][1] + " | " + fan[5][2] + " | " + fan[5][3] + " | " + fan[5][4] + " | " + fan[5][5] + " | " + fan[5][6] + " |        Despues tecla [enter]");
                System.out.println(6 + "    | " + fan[6][1] + " | " + fan[6][2] + " | " + fan[6][3] + " | " + fan[6][4] + " | " + fan[6][5] + " | " + fan[6][6] + " | ");
                // Escribir 7,"    | ",fan[7,1]," | ",fan[7,2]," | ",fan[7,3]," | ",fan[7,4]," | ",fan[7,5]," | ",fan[7,6]," | ",fan[7,7]," | ";
                System.out.println("**********************************");
                System.out.println("***** PARA JUGAR INGRESÁ LAS COORDENADAS (X primero, Y segundo) *****");
                System.out.println("Coordenada en  X");
                varx = Integer.parseInt(bufEntrada.readLine());
                System.out.println("Coordenada en  Y");
                vary = Integer.parseInt(bufEntrada.readLine());
                if (varx >= 1 && vary >= 1 && varx <= 7 && vary <= 7) {
                    minapisada = num[vary][varx];
                    if (!minapisada.equals("X")) {
                        do {
                            busx = varx;
                            busy = vary;
                            switch (op) {
                                case 1:
                                    busx = busx - 1;
                                    break;
                                case 2:
                                    busx = busx - 1;
                                    busy = busy - 1;
                                    break;
                                case 3:
                                    busy = busy - 1;
                                    break;
                                case 4:
                                    busx = busx + 1;
                                    busy = busy - 1;
                                    break;
                                case 5:
                                    busx = busx + 1;
                                    break;
                                case 6:
                                    busx = busx + 1;
                                    busy = busy + 1;
                                    break;
                                case 7:
                                    busy = busy + 1;
                                    break;
                                case 8:
                                    busx = busx - 1;
                                    busy = busy + 1;
                                    break;
                                default:
                                    System.out.println("Error: Terminando escaneo Hongos");
                            }
                            op = op + 1;
                            if (num[busy][busx].equals("X")) {
                                numerominas = numerominas + 1;
                            }
                        } while (op != 9);
                        numerominascaracter = Double.toString(numerominas);
                        fan[vary][varx] = numerominascaracter;
                        op = 1;
                        numerominas = 0;
                    } else {
                        System.out.println(""); // no hay forma directa de borrar la consola en Java
                        System.out.println("       1   2   3   4   5   6   ");
                        for (j = 1; j <= 6; ++j) {
                            System.out.println(j + "     | " + num[j][1] + " | " + num[j][2] + " | " + num[j][3] + " | " + num[j][4] + " | " + num[j][5] + " | " + num[j][6] + " | ");
                        }
                        System.out.println("*************************************");
                        System.out.println("HAS PISADO UN HONGO Amanita phalloides, SI ES MORTAL !!");
                        System.out.println("*************************************");
                        cantidadmuertes = cantidadmuertes + 1;
                        if (cantidadmuertes < 3) {
                            System.out.println("El dios todo benevolente de este universo te dió otra oportunidad, no la desaproveches");
                        } else {
                            System.out.println("Haz muerto horriblemente por el veneno acumulado de los hongos");
                            retirada = "s";
                        }
                        System.in.read(); // a diferencia del pseudocódigo, espera un Enter, no cualquier tecla
                    }
                } else {
                    if (varx == 11 || vary == 11) {
                        System.out.println("¿Estas seguro que quieres retirarte del Juego?[S/N]");
                        retirada = bufEntrada.readLine();
                        if (retirada.equals("s") || retirada.equals("S")) {
                            System.out.println("*************************************");
                            System.out.println("Eres un cobarde");
                            System.out.println("*************************************");
                            Thread.sleep(3 * 1000);
                        }
                    } else {
                        if (varx == 10 || vary == 10) {
                            System.out.println("Digite cordenada X de hongo que desea marcar");
                            marx = Integer.parseInt(bufEntrada.readLine());
                            System.out.println("Digite cordenada Y de hongo que desea marcar");
                            mary = Integer.parseInt(bufEntrada.readLine());
                            fan[mary][marx] = "?";
                        }
                    }
                }
            } while (!(retirada.equals("s") || retirada.equals("S")));
            retirada = "";
            juegohongos = false;
        } while (juegohongos != false);
        animacioncierre();
    }

    public static int lanzarDadoAnimacion() throws InterruptedException {
        int alea;
        int altura;
        int contador;
        String cubo1[];
        String cubo2[];
        String cubo3[];
        String cubox1[];
        String cubox2[];
        String cubox3[];
        String cubox4[];
        String cubox5[];
        String cubox6[];
        int i;
        int j;
        cubo1 = new String[8];
        cubo2 = new String[8];
        cubo3 = new String[8];
        cubox1 = new String[8];
        cubox2 = new String[8];
        cubox3 = new String[8];
        cubox4 = new String[8];
        cubox5 = new String[8];
        cubox6 = new String[8];
        // Definición del primer cubo
        cubo1[1] = "         ______ ";
        cubo1[2] = "        /     /\\\\";
        cubo1[3] = "       /  0  /  \\\\";
        cubo1[4] = "      /_____/  0 \\\\";
        cubo1[5] = "      \\\\ 0 0 \\\\ 0  /";
        cubo1[6] = "       \\\\ 0 0 \\\\  /";
        cubo1[7] = "        \\\\_____\\\\/";
        // Definición del segundo cubo
        cubo2[1] = "   _______";
        cubo2[2] = "  /\\\\ o o o\\\\";
        cubo2[3] = " /o \\\\ o o o\\\\";
        cubo2[4] = "<    >------>";
        cubo2[5] = " \\\\ o/  o   /";
        cubo2[6] = "  \\\\/______/";
        cubo2[7] = "";
        // Definición del tercer cubo
        cubo3[1] = "  _______";
        cubo3[2] = " | o   o |\\\\";
        cubo3[3] = " |   o   |o \\\\";
        cubo3[4] = " | o   o |o |";
        cubo3[5] = " |_______|o |";
        cubo3[6] = " \\\\  o   \\\\ |";
        cubo3[7] = "  \\\\______\\\\|";
        // Definición de las caras del dado
        // Cara 1
        cubox1[1] = "  _______";
        cubox1[2] = " |       |\\\\";
        cubox1[3] = " |   O   |o\\\\ ";
        cubox1[4] = " |       | o|";
        cubox1[5] = " |_______|o |";
        cubox1[6] = " \\\\  o o \\\\ |";
        cubox1[7] = "  \\\\______\\\\|";
        // Cara 2
        cubox2[1] = "  _______";
        cubox2[2] = " |       |\\\\";
        cubox2[3] = " |  o  o |o\\\\ ";
        cubox2[4] = " |       | o|";
        cubox2[5] = " |_______|o |";
        cubox2[6] = " \\\\   o  \\\\ |";
        cubox2[7] = "  \\\\______\\\\|";
        // Cara 3
        cubox3[1] = "  _______";
        cubox3[2] = " |  o    |\\\\";
        cubox3[3] = " |    o  | \\\\ ";
        cubox3[4] = " |  o    |oo|";
        cubox3[5] = " |_______|oo|";
        cubox3[6] = " \\\\  o o \\\\ |";
        cubox3[7] = "  \\\\______\\\\|";
        // Cara 4
        cubox4[1] = "  _______";
        cubox4[2] = " |  o o  |\\\\";
        cubox4[3] = " |       | \\\\ ";
        cubox4[4] = " |  o o  |oo|";
        cubox4[5] = " |_______|o |";
        cubox4[6] = " \\\\  o o \\\\o|";
        cubox4[7] = "  \\\\______\\\\|";
        // Cara 5
        cubox5[1] = "  _______";
        cubox5[2] = " |  o  o |\\\\";
        cubox5[3] = " |   o   | \\\\ ";
        cubox5[4] = " |  o  o |o |";
        cubox5[5] = " |_______|o |";
        cubox5[6] = " \\\\   o  \\\\ |";
        cubox5[7] = "  \\\\______\\\\|";
        // Cara 6
        cubox6[1] = "  _______";
        cubox6[2] = " | o  o  |\\\\";
        cubox6[3] = " | o  o  | \\\\ ";
        cubox6[4] = " | o  o  | o|";
        cubox6[5] = " |_______|o |";
        cubox6[6] = " \\\\ o o  \\\\o|";
        cubox6[7] = "  \\\\______\\\\|";
        // Inicio de la simulación
        alea = lanzarDado(1, 6);
        contador = 0;
        // Contador para alternar entre cubos
        // Movimiento del dado hacia abajo y arriba
        for (altura = 0; altura <= 10; ++altura) {
            System.out.println(""); // no hay forma directa de borrar la consola en Java
            for (i = 0; i <= altura; ++i) {
                System.out.println("");
            }
            switch (contador % 3) {
                case 0:
                    for (j = 1; j <= 7; ++j) {
                        System.out.println(cubo1[j]);
                    }
                    break;
                case 1:
                    for (j = 1; j <= 7; ++j) {
                        System.out.println(cubo2[j]);
                    }
                    break;
                case 2:
                    for (j = 1; j <= 7; ++j) {
                        System.out.println(cubo3[j]);
                    }
                    break;
            }
            Thread.sleep(50);
            // Ajusta la velocidad del salto
            contador = contador + 1;
        }
        for (altura = 10; altura >= 0; --altura) {
            System.out.println(""); // no hay forma directa de borrar la consola en Java
            for (i = 0; i <= altura; ++i) {
                System.out.println("");
            }
            switch (contador % 3) {
                case 0:
                    for (j = 1; j <= 7; ++j) {
                        System.out.println(cubo1[j]);
                    }
                    break;
                case 1:
                    for (j = 1; j <= 7; ++j) {
                        System.out.println(cubo2[j]);
                    }
                    break;
                case 2:
                    for (j = 1; j <= 7; ++j) {
                        System.out.println(cubo3[j]);
                    }
                    break;
            }
            if (altura < 9) {
                Thread.sleep(100);
                // Ajusta la velocidad del salto
            } else {
                Thread.sleep(200);
            }
            contador = contador + 1;
        }
        // Mostrar el resultado del dado
        System.out.println(""); // no hay forma directa de borrar la consola en Java
        switch (alea) {
            case 1:
                for (j = 1; j <= 7; ++j) {
                    System.out.println(cubox1[j]);
                }
                break;
            case 2:
                for (j = 1; j <= 7; ++j) {
                    System.out.println(cubox2[j]);
                }
                break;
            case 3:
                for (j = 1; j <= 7; ++j) {
                    System.out.println(cubox3[j]);
                }
                break;
            case 4:
                for (j = 1; j <= 7; ++j) {
                    System.out.println(cubox4[j]);
                }
                break;
            case 5:
                for (j = 1; j <= 7; ++j) {
                    System.out.println(cubox5[j]);
                }
                break;
            case 6:
                for (j = 1; j <= 7; ++j) {
                    System.out.println(cubox6[j]);
                }
                break;
        }
        return alea;
    }

    public static void animacioncierre() throws IOException, InterruptedException {
        int altura;
        int contador;
        String dragon[];
        int i;
        int j;
        dragon = new String[40];
        dragon[0] = "                         /\\\\";
        dragon[1] = "                         ||";
        dragon[2] = "                         ||";
        dragon[3] = "                         ||";
        dragon[4] = "                         ||                                               ~-----~";
        dragon[5] = "                         ||                                            /===--  ---~~~";
        dragon[6] = "                         ||                                      /==~- --   -    ---~~~";
        dragon[7] = "                         ||                (/ (               /=----         ~~_  --(   ";
        dragon[8] = "                         ||               / ;              /=----               \\\\__~";
        dragon[9] = "                       ~==_=~           (              ~-~~      ~~~~        ~~~--\\\\~ ";
        dragon[10] = "      \\\\                (c_\\\\_        .I.             /~--    ~~~--   -~     (";
        dragon[11] = "       `\\\\               (}| /       / : \\\\           / ~~------~     ~~\\\\   (";
        dragon[12] = "       \\\\                 |/ \\\\      |===|          /~/             ~~~ \\\\ \\\\(";
        dragon[13] = "      ``~\\\\              ~~\\\\  )~.~_ >._.< _~-~     |`_          ~~-~     )\\\\";
        dragon[14] = "        -~                 {  /  ) \\\\___/ (   \\\\   |    _       ~~         ";
        dragon[15] = "       \\\\ -~\\\\                -<__/  -   -  L~ -;   \\\\\\\\    \\\\ _ _/";
        dragon[16] = "       `` ~~=\\\\                  {    :    }\\\\ ,\\\\    ||   _ :(";
        dragon[17] = "        \\\\  ~~=\\\\__                \\\\ _/ \\\\_ /  )  } _//   ( `| ";
        dragon[18] = "        ``    , ~\\\\--~=\\\\           \\\\     /  / _/ /      (   ";
        dragon[19] = "         \\\\`    } ~ ~~ -~=\\\\   _~_  / \\\\ / \\\\ )^ ( // :_  /                                     GRACIAS POR JUGAR!!!!";
        dragon[20] = "         |    ,          _~-     ~~__-_  / - |/     \\\\ (";
        dragon[21] = "         \\\\  ,_--_     _/              \\\\_ --- , -~ .   \\\\";
        dragon[22] = "           )/      /\\\\ / /\\\\   ,~,         \\\\__ _}     \\\\_   ~_                                 El código de Da Vinci";
        dragon[23] = "           ,      { ( _ ) } ~ - \\\\_    ~\\\\  (-:-)        \\\\   ~";
        dragon[24] = "                  / O  O  )~ \\\\~_ ~\\\\   )->  \\\\ :|    _,       }";
        dragon[25] = "                 (\\\\  _/)  } | \\\\~_ ~  /~(   | :)   /          }";
        dragon[26] = "                <``  >;,,/  )= \\\\~__ {{{    \\\\ =(  ,   ,       ";
        dragon[27] = "               {o_o }_/     |v   ~__  _    )-v|     :       ,";
        dragon[28] = "               {/ \\\\_)       {_/   \\\\~__ ~\\\\_ \\\\\\\\_}    {        /~\\\\";
        dragon[29] = "               ,/!           _/     ~__ _-~ \\\\_  :         ,   ~ ";
        dragon[30] = "              (  )                   /, ~___~    | /     ,   \\\\ ~";
        dragon[31] = "              /, )                 (-)   ~____~ ;     ,      , }";
        dragon[32] = "           /, )                    / \\\\         /  ,~-        ~";
        dragon[33] = "     (    /                     / (         /  /           ~";
        dragon[34] = "    ~ ~  ,, /) ,                 (/( \\\\)      ( -)          /~";
        dragon[35] = "  (  ~~ )`  ~}                      \\\\)      _/ /           ~";
        dragon[36] = " { |) /`,--.(  }                           (  /          /~";
        dragon[37] = "(` ~ ( c|~~| `}   )                         /:\\\\         ,";
        dragon[38] = " ~ )/  ) ))  |),                          (/ | \\\\)";
        dragon[39] = "  (` (-~(( `~`   )                          (/ ";
        contador = 0;
        // Movimiento del dragón hacia arriba
        for (altura = 39; altura >= 0; --altura) {
            System.out.println(""); // no hay forma directa de borrar la consola en Java
            // Espacios iniciales para mover el dragón hacia arriba
            espacios(altura);
            // Mostrar solo parte visible del dragón (líneas 0 a 25)
            for (j = 0; j <= 39; ++j) {
                if (j + altura < 40) {
                    System.out.println(dragon[j + altura]);
                }
            }
            // Esperar un poco antes de la siguiente iteración
            Thread.sleep(200);
            contador = contador + 1;
        }
        System.out.println("----------------------------------------------------------------");
        System.out.println("-------- PRESIONE CUALQUIER TECLA PARA EMPEZAR DE NUEVO --------");
        System.out.println("----------------------------------------------------------------");
        System.in.read(); // a diferencia del pseudocódigo, espera un Enter, no cualquier tecla
    }

    public static void espacios(double x) {
        int i;
        for (i = 0; i <= x - 1; ++i) {
            System.out.print(" ");
        }
    }

    public static void animacionpersonaje() throws IOException, InterruptedException {
        String arbol;
        String arbol1[];
        int i;
        int j;
        String pj[];
        System.out.println("Presione una tecla para iniciar la partida");
        System.in.read(); // a diferencia del pseudocódigo, espera un Enter, no cualquier tecla
        arbol1 = new String[10];
        pj = new String[12];
        pj[0] = "   ==(W{==========- ";
        pj[1] = "     ||  (.--.)    ";
        pj[2] = "     | \\_,|**|,__  |";
        pj[3] = "      \\    --    ),";
        pj[4] = "      /`\\_. .__/\\ \\ ";
        pj[5] = "     (   | .  |~~~~|";
        pj[6] = "     )__/==0==-\\<>/";
        pj[7] = "       /~\\___/~~\\/ ";
        pj[8] = "      /-~~   \\  | ";
        pj[9] = "      /-~~   \\  | ";
        pj[10] = "      /|~    | \\ ";
        pj[11] = "      ---     ---";
        arbol1[0] = "              v .   ._, |_  .,               v .   ._, |_  .,             v .   ._, |_  .,  ";
        arbol1[1] = "           `-._\\/  .  \\ /    |/_             `-._\\/  .  \\ /    |/_        _\\_.___\\\\, \\\\/ -.\\||     ";
        arbol1[2] = "               \\\\  _\\, y | \\//                \\\\  _\\, y | \\//              `-._\\/  .  \\ /    |/_  ";
        arbol1[3] = "          _\\_.___\\\\, \\\\/ -.\\||           _\\_.___\\\\, \\\\/ -.\\||             _\\_.___\\\\, \\\\/ -.\\||      ";
        arbol1[4] = "             -,--. ._||  / / ,              -,--. ._||  / / ,                   -,--. ._||  / / ,    ";
        arbol1[5] = "                /     -. ./ / |/_.                 /     -. ./ / |/_.        /    -. ./ / |/_.        ";
        arbol1[6] = "                      |    |//                      |    |//                     |    |//            ";
        arbol1[7] = "                      |_    /                       |_    /                      |_    /           ";
        arbol1[8] = "                      |-   |                        |-   |                       |-   |             ";
        arbol1[9] = " --------------------/ ,  . \\----------------------/ ,  . \\---------------------/ ,  . \\---------------       ";
        for (i = 0; i <= 70; ++i) {
            // Ajustamos el número de iteraciones para moverse a lo largo de la pantalla
            System.out.println(""); // no hay forma directa de borrar la consola en Java
            // Mostrar el personaje y el movimiento
            for (j = 0; j <= 11; ++j) {
                espacios(i);
                System.out.println(pj[j]);
            }
            for (j = 0; j <= 9; ++j) {
                System.out.println(arbol1[j]);
            }
            // Esperar un poco antes de pasar a la siguiente iteración
            Thread.sleep(30);
        }
        System.out.println("------------------------------------------------------------------------------------------------------");
        System.out.println("COMIENZA LA PARTIDA");
        Thread.sleep(3 * 1000);
        System.out.println(""); // no hay forma directa de borrar la consola en Java
    }

    // subproceso utilizado para generar una matriz simulando un espacio de "estrellas"
    public static void rellenarmatrizespacial(double tam, String matrizespacial[][]) throws InterruptedException {
        int i;
        int j;
        for (i = 0; i <= tam - 1; ++i) {
            for (j = 0; j <= tam - 1; ++j) {
                matrizespacial[i][j] = "*";
            }
        }
        for (i = 0; i <= tam - 1; ++i) {
            for (j = 0; j <= tam - 1; ++j) {
                System.out.print(matrizespacial[i][j] + " ");
            }
            System.out.println("");
            Thread.sleep(40);
        }
    }

    // subproceso que dibuja un dragon para la presentación del juego
    public static void dibujardragon() throws InterruptedException {
        Thread.sleep(1 * 1000);
        System.out.println("                                            .~))>>");
        Thread.sleep(40);
        System.out.println("                                            .~)>>");
        Thread.sleep(40);
        System.out.println("                                       .~))))>>>");
        Thread.sleep(40);
        System.out.println("                                         .~))>> ");
        Thread.sleep(40);
        System.out.println("                                    .~))>>)))>>      .-~))>> ");
        Thread.sleep(40);
        System.out.println("                                   .~)))))>>       .-~))>>)> ");
        Thread.sleep(40);
        System.out.println("                                .~)))>>))))>>  .-~)>>)> ");
        Thread.sleep(40);
        System.out.println("                               .~))>>))))>>  .-~)))))>>)>");
        Thread.sleep(40);
        System.out.println("                               //)>))))))  .-~))))>>)>");
        Thread.sleep(40);
        System.out.println("                              //))>>))) .-~))>>)))))>>)>");
        Thread.sleep(40);
        System.out.println("                             //))))) .-~)>>)))))>>)>");
        Thread.sleep(40);
        System.out.println("                            //)>))) //))))))>>))))>>)>");
        Thread.sleep(40);
        System.out.println("                           |/))))) //)))))>>)))>>)>");
        Thread.sleep(40);
        System.out.println("                 (\\_(\\-\\b  |))>)) //)))>>)))))))>>)>");
        Thread.sleep(40);
        System.out.println("                _/`-`  ~|b |>))) //)>>)))))))>>)>");
        Thread.sleep(40);
        System.out.println("                (@) (@)  /\\b|))) //))))))>>))))>>");
        Thread.sleep(40);
        System.out.println("              _/       /  \\b)) //))>>)))))>>>_._");
        Thread.sleep(40);
        System.out.println("              (6,   6) / ^  \\b)//))))))>>)))>>   ~~-. ");
        Thread.sleep(40);
        System.out.println("               ~^~^~, /\\  ^  \\b/)>>))))>>      _.     `, ");
        Thread.sleep(40);
        System.out.println("               \\^^^/ (  ^   \\b)))>>        .         `, ");
        Thread.sleep(40);
        System.out.println("                `-   ((   ^  ~)_          /             , ");
        Thread.sleep(40);
        System.out.println("                      (((   ^    `\\        |               `. ");
        Thread.sleep(40);
        System.out.println("                     / ((((        \\        \\      .         `. ");
        Thread.sleep(40);
        System.out.println("                    /   (((((  \\    \\    _.-~\\     Y,         ;");
        Thread.sleep(40);
        System.out.println("                   /   / (((((( \\    \\.-~   _.` _.-~,       ; ");
        Thread.sleep(40);
        System.out.println("                  /   /   `(((((()    )    (((((~      `,     ; ");
        Thread.sleep(40);
        System.out.println("                _/  _/      `++/   /                  ;     ;");
        Thread.sleep(40);
        System.out.println("             _.-~_.-~           `/  /`                    ");
        Thread.sleep(40);
        System.out.println("            ((((~~             `/ /              _.-~ __.--~ ");
        Thread.sleep(40);
        System.out.println("                             ((((          __.-~ _.-~ ");
        Thread.sleep(40);
        System.out.println("                                         .   .~~ ");
        Thread.sleep(40);
        System.out.println("                                        :    ,");
        Thread.sleep(40);
        System.out.println("                                        ~~~~~ ");
        Thread.sleep(40);
    }

    // subproceso utilizado para inicializar una matriz con la imagen de un dragón.Forma parte de la presentación
    public static void inicializarmatrizdragon(String dragonmatriz[]) {
        dragonmatriz[0] = "                  \\||/ ";
        dragonmatriz[1] = "                 |  @___oo ";
        dragonmatriz[2] = "       /\\  /\\   / (__,,,,| ";
        dragonmatriz[3] = "      ) /^\\) ^\\/ _) ";
        dragonmatriz[4] = "      )   /^\\/   _) ";
        dragonmatriz[5] = "      )   _ /  / _) ";
        dragonmatriz[6] = "  /\\  )/\\/ ||  | )_) ";
        dragonmatriz[7] = " <  >      |(,,) )__) ";
        dragonmatriz[8] = "  ||      /    \\)___)\\ ";
        dragonmatriz[9] = "  | \\____(      )___) )___ ";
        dragonmatriz[10] = "  \\______(_______;;; __;;; ";
    }

    // proceso para simular que el dragon se desplaza
    public static void simularmovimiento(String dragonmatriz[]) throws InterruptedException {
        int i;
        int j;
        for (i = 0; i <= 40; ++i) {
            System.out.println(""); // no hay forma directa de borrar la consola en Java
            for (j = 0; j <= 10; ++j) {
                movimiento(i);
                System.out.println(dragonmatriz[j]);
            }
            Thread.sleep(40);
        }
        System.out.println(""); // no hay forma directa de borrar la consola en Java
    }

    // Este subproceso sirve para agregar espacios
    public static void movimiento(double i) {
        int j;
        for (j = 0; j <= i; ++j) {
            System.out.print(" ");
        }
    }

    // Incializa una matriz que guarda el nombre "ARCADE DA VINCI"
    public static void inicializartextomatriz(String textoarcadedavinci[]) throws InterruptedException {
        textoarcadedavinci[0] = "     @@@@        @@@@          @@@@@        @@@@           @@@@           @@@@@           ";
        textoarcadedavinci[1] = "    ( @@ \\\\      |  @ \\\\     ( @@@@@      ( @@  \\\\         | @ \\\\       | @@@@@           ";
        textoarcadedavinci[2] = "   ( @@  \\\\ \\\\   | @@@ |     | @         (  @@   \\\\ \\\\     | @ | |      |  @@             ";
        textoarcadedavinci[3] = "  ( @@ D  \\\\ \\\\  |  @ <      | @        (  @@ D   \\\\ \\\\    | @@@ |      | @@@@@            ";
        textoarcadedavinci[4] = " (  @@@@  \\\\ \\\\  |_| \\\\_\\\\   \\\\@@@@|   (  @@@@     \\\\ \\\\   |@@@@/       | @@@@@|            ";
        textoarcadedavinci[5] = "                                                                                      ";
        textoarcadedavinci[6] = "                                                                                      ";
        textoarcadedavinci[7] = "                                                                                      ";
        textoarcadedavinci[8] = "                                                                                      ";
        textoarcadedavinci[9] = "                  @@@@             @@@@                                              ";
        textoarcadedavinci[10] = "                |  @ \\\\          ( @@ \\\\                                              ";
        textoarcadedavinci[11] = "                | @  | |        ( @@   \\\\ \\\\                                              ";
        textoarcadedavinci[12] = "                | @@@  |        ( @@ D  \\\\ \\\\                                              ";
        textoarcadedavinci[13] = "                |@@@@ /         ( @@@@   \\\\ \\\\                                              ";
        textoarcadedavinci[14] = "                                                                                      ";
        textoarcadedavinci[15] = "                                                                                      ";
        textoarcadedavinci[16] = "                                                                                      ";
        textoarcadedavinci[17] = "                                                                                      ";
        textoarcadedavinci[18] = "                                                                                      ";
        textoarcadedavinci[19] = "        ((        ((    @@@@@    (    (         @@@@@       @@@@@                           ";
        textoarcadedavinci[20] = "        \\\\ \\\\   / /    |_   _|   | \\\\ | |     ( @@@@@      |_   _|                        ";
        textoarcadedavinci[21] = "         \\\\ \\\\_/ /       | |     |  \\\\| |     | @            | |                          ";
        textoarcadedavinci[22] = "          \\\\    /        | |     | |\\\\  |     | @            | |                          ";
        textoarcadedavinci[23] = "           \\\\_/        |_   _|   |_| \\\\_|     \\\\@@@@|      |_   _|                        ";
        simularmovimientotextoarcade(textoarcadedavinci);
        Thread.sleep(1 * 1000);
        System.out.println(""); // no hay forma directa de borrar la consola en Java
    }

    // Proceso para simular movimiento en el texto del arcade
    public static void simularmovimientotextoarcade(String textoarcadedavinci[]) throws InterruptedException {
        int i;
        int j;
        int k;
        for (i = 0; i <= 40; ++i) {
            System.out.println(""); // no hay forma directa de borrar la consola en Java
            for (j = 0; j <= 23; ++j) {
                for (k = 0; k <= i; ++k) {
                    System.out.print(" ");
                }
                System.out.println(textoarcadedavinci[j]);
            }
            Thread.sleep(50);
        }
    }

    // Subproceso que muestra un dragón que da la bienvenida al jugador
    public static void pantallapreviacargajuegos() throws InterruptedException {
        Thread.sleep(30);
        System.out.println("                                                                                                                        ");
        Thread.sleep(30);
        System.out.println("                       |\\\\                                                              /|                             ");
        Thread.sleep(30);
        System.out.println("                       | \\\\                                                            / |                             ");
        Thread.sleep(30);
        System.out.println("                       |  \\\\                                                          /  |                             ");
        Thread.sleep(30);
        System.out.println("                       |   \\\\                                                        /   |                             ");
        Thread.sleep(30);
        System.out.println("            _____)    \\\\                                                      /    (____                           ");
        Thread.sleep(30);
        System.out.println("           \\\\          \\\\                                                    /         /                            ");
        Thread.sleep(30);
        System.out.println("            \\\\          \\\\                                                  /         /                             ");
        Thread.sleep(30);
        System.out.println("            \\\\           `--_____                                _____--          /                              ");
        Thread.sleep(30);
        System.out.println("             \\\\                  \\\\                              /                 /                               ");
        Thread.sleep(30);
        System.out.println("            ____)                  \\\\                            /                 (____                          ");
        Thread.sleep(30);
        System.out.println("            \\\\                       \\\\        /|      |\\\\        /                      /                          ");
        Thread.sleep(30);
        System.out.println("             \\\\                       \\\\      | /      \\\\ |      /                      /                           ");
        Thread.sleep(30);
        System.out.println("              \\\\                       \\\\     ||        ||     /                      /                            ");
        Thread.sleep(30);
        System.out.println("               \\\\                       \\\\    | \\\\______/ |    /                      /                             ");
        Thread.sleep(30);
        System.out.println("                \\\\                       \\\\  / \\\\        / \\\\  /                      /                              ");
        Thread.sleep(30);
        System.out.println("                /                        \\\\| (*\\\\  \\\\/  /*) |/                       \\\\                              ");
        Thread.sleep(30);
        System.out.println("               /                          \\\\   \\\\| \\\\/ |/   /                         \\\\                             ");
        Thread.sleep(30);
        System.out.println("              /                            |   |    |   |                           \\\\                            ");
        Thread.sleep(30);
        System.out.println("             /                             |\\\\ _\\\\____/_ /|                            \\\\                           ");
        Thread.sleep(30);
        System.out.println("            /______                       | | \\\\)____(/ | |                      ______\\\\                          ");
        Thread.sleep(30);
        System.out.println("                   )                      |  \\\\ |/vv\\\\| /  |                     (                               ");
        Thread.sleep(30);
        System.out.println("                  /                      /    | |  | |    \\\\                     \\\\                              ");
        Thread.sleep(30);
        System.out.println("                 /                      /     ||\\\\^^/||     \\\\                     \\\\                             ");
        Thread.sleep(30);
        System.out.println("                /                      /     / \\\\====/ \\\\     \\\\                     \\\\                            ");
        Thread.sleep(30);
        System.out.println("              /_______           ____/      \\\\________/      \\\\____           ______\\\\                           ");
        Thread.sleep(30);
        System.out.println("                     )         /   |       |  ____  |       |   \\\\         (                                     ");
        Thread.sleep(30);
        System.out.println("                     |       /     |       \\\\________/       |     \\\\       |                                     ");
        Thread.sleep(30);
        System.out.println("                     |     /       |       |  ____  |       |       \\\\     |                                     ");
        Thread.sleep(30);
        System.out.println("                     |   /         |       \\\\________/       |         \\\\   |                                     ");
        Thread.sleep(30);
        System.out.println("                     | /            \\\\      \\\\ ______ /      /______..    \\\\ |                                  ");
        Thread.sleep(30);
        System.out.println("                     /              |      \\\\\\\\______//      |        \\\\     \\\\                                 ");
        Thread.sleep(30);
        System.out.println("                                    |       \\\\ ____ /       |LLLLL/_  \\\\                                      ");
        Thread.sleep(30);
        System.out.println("                                    |      / \\\\____/ \\\\      |      \\\\   |                                     ");
        Thread.sleep(30);
        System.out.println("                                    |     / / \\\\__/ \\\\ \\\\     |     __\\\\  /__                                    ");
        Thread.sleep(30);
        System.out.println("                                    |    | |        | |    |     \\\\      /                                     ");
        Thread.sleep(30);
        System.out.println("                                    |    | |        | |    |      \\\\    /                                      ");
        Thread.sleep(30);
        System.out.println("                                    |    |  \\\\      /  |    |       \\\\  /                                       ");
        Thread.sleep(30);
        System.out.println("                                    |     \\\\__\\\\    /__/     |        \\\\/                                        ");
        Thread.sleep(30);
        System.out.println("                                   /    ___\\\\  )  (  /___    \\\\                                               ");
        Thread.sleep(30);
        System.out.println("                                  |/\\\\/\\\\|    )      (    |/\\\\/\\\\|                                              ");
        Thread.sleep(30);
        System.out.println("                                  ( (  )                (  ) )                                              ");
        Thread.sleep(30);
        System.out.println("                     =============================================================================================== ");
        System.out.println("                      * ===========================================================================================* ");
        System.out.println("                    * *                                                                                            * * ");
        System.out.println("                    * *                                                                                            * * ");
        System.out.println("                    * *                                                                                            * * ");
        System.out.println("                    * *                                                                                            * * ");
        System.out.println("                    * *                      BIENVENIDOS A JUEGOS DA VINCI                                         * * ");
        System.out.println("                    * *                                                                                            * * ");
        System.out.println("                    * *                (Presione una tecla para acceder a nuestros juegos)                         * * ");
        System.out.println("                    * *                                                                                            * * ");
        System.out.println("                    * *                                                                                            * * ");
        System.out.println("                    * *                                                                                            * * ");
        System.out.println("                    * *                                                                                            * * ");
        System.out.println("                     * =========================================================================================== * ");
        System.out.println("                     =============================================================================================== ");
    }

    // Subproceso que muestra la pantalla que carga los juegos o la salida
    public static void pantallaeleccionjuego() throws IOException, InterruptedException {
        int opcion;
        System.out.println("**********************************************************************");
        System.out.println("*                                                                    *");
        System.out.println("*                     SELECCIONA UN JUEGO                            *");
        System.out.println("*                                                                    *");
        System.out.println("**********************************************************************");
        System.out.println("*                                                                    *");
        System.out.println("*                          1. Laberinto del Dragón                   *");
        System.out.println("*                          2. Buscaminas                             *");
        System.out.println("*                          3. Salir                                  *");
        System.out.println("*                                                                    *");
        System.out.println("**********************************************************************");
        System.out.println("Por favor, ingrese una opción (1, 2, 3): ");
        opcion = Integer.parseInt(bufEntrada.readLine());
        switch (opcion) {
            case 1:
                juegolaberinto();
                break;
            case 2:
                System.out.println("Cargando Buscaminas...");
                Thread.sleep(1 * 1000);
                juegobuscaminas();
                break;
            case 3:
                System.out.println("Saliendo...");
                break;
            default:
                System.out.println("Opción no válida. Por favor, ingrese una opción correcta.");
                Thread.sleep(3 * 1000);
                System.out.println(""); // no hay forma directa de borrar la consola en Java
                pantallaeleccionjuego();
        }
    }

    // Este algoritmo simplemente genera un tablero cortina totalmente tapado
    public static void tablerocortina(double matriz[][], double filas, double columnas) {
        int i;
        int j;
        // Tablero cortina, por que va a ser el q permita que no se vea el tablero con las bombas descubierto desde un principio
        // 0 = es para cuando el espacio este tapado
        // 1 = es para el espacio que este destapado, osea se vera en blanco o un numero (eso a medida que el jugar este jugando)
        // 2 = es para el espacio en el que el jugador decida colocar una bandera (para decidir si se gana el juego se podria pedir
        // que se marquen todas las minas con banderas).
        for (i = 0; i <= filas - 1; ++i) {
            for (j = 0; j <= columnas - 1; ++j) {
                matriz[i][j] = 0;
            }
        }
    }

    // Este algoritmo muestra lo que el jugador tiene que ver dependiendo lo que vaya seleccionando
    // Por ejemplo: si aun no a elegido nada el tablero estara totalmente tapado,
    // si selecciona un espacio para limpiar, motrara el lugar que corresponda pero no todo el tablero.
    public static void mostrartablero(String matriz[][], String cortina[][], double filas, double columnas) {
        int i;
        int j;
        // Mostrar los números de columna en la parte superior
        System.out.print("   ");
        for (j = 0; j <= columnas - 1; ++j) {
            // /Este condicional es para cuando haya columnas con mas de 1 digito se siga viendo bien
            if (j < 10) {
                System.out.print(" " + j + 1 + " ");
            } else {
                System.out.print(j + 1 + " ");
            }
        }
        System.out.println("");
        // Salto de línea
        // Mostrar los guiones entre los números de columna y la matriz
        System.out.print("   ");
        for (j = 0; j <= columnas - 1; ++j) {
            System.out.print("---");
        }
        System.out.println("");
        // Salto de línea
        // Mostrar el tablero con números de filas y columnas
        for (i = 0; i <= filas - 1; ++i) {
            // Mostrar el número de la fila al principio
            if (i < 9) {
                System.out.print(" " + i + 1 + "|");
            } else {
                System.out.print(i + 1 + "|");
            }
            for (j = 0; j <= columnas - 1; ++j) {
                // Comprobar si en la matrizCortina está liberado el lugar para mostrar la matriz de minas
                if (cortina[i][j].equals("0")) {
                    // Si es el valor 0 en la matrizCortina, entonces muestra la matrizCortina
                    System.out.print(" . ");
                } else {
                    if (cortina[i][j].equals("1")) {
                        // Si es el valor 1 en la matrizCortina, entonces muestra la matriz de minas
                        if (matriz[i][j].equals("0")) {
                            // En la matriz de minas si es = 0 entonces muestra un "  " (espacio vacío)
                            System.out.print("   ");
                        } else {
                            // Y si no es ninguno de los anteriores muestra el número de bombas que tiene alrededor ese espacio
                            System.out.print(" " + matriz[i][j] + " ");
                        }
                    } else {
                        if (cortina[i][j].equals("2")) {
                            // Si es un 2, en este espacio se colocó una bandera
                            System.out.print(" P ");
                            // La P parece una bandera
                        }
                    }
                }
            }
            // Mostrar el número de la fila al final
            System.out.println("|" + i + 1);
        }
        // Mostrar los guiones entre la matriz y los números de columna en la parte inferior
        System.out.print("   ");
        for (j = 0; j <= columnas - 1; ++j) {
            System.out.print("---");
        }
        System.out.println("");
        // Salto de línea
        // Mostrar los números de columna en la parte inferior
        System.out.print("   ");
        for (j = 0; j <= columnas - 1; ++j) {
            // /Este condicional es para cuando haya columnas con mas de 1 digito se siga viendo bien
            if (j < 10) {
                System.out.print(" " + j + 1 + " ");
            } else {
                System.out.print(j + 1 + " ");
            }
        }
        System.out.println("");
        // Salto de línea
    }

    // Este algoritmo muestra el tablero y todas las minas del mismo, exclusiva para el final del juego
    public static void mostrartablerofinjuego(String[][] matriz, String[][] cortina, double filas, double columnas) {
        int i;
        int j;
        // Mostrar los números de columna en la parte superior
        System.out.print("   ");
        for (j = 0; j <= columnas - 1; ++j) {
            // /Este condicional es para cuando haya columnas con mas de 1 digito se siga viendo bien
            if (j < 10) {
                System.out.print(" " + j + 1 + " ");
            } else {
                System.out.print(j + 1 + " ");
            }
        }
        System.out.println("");
        // Salto de línea
        // Mostrar los guiones entre los números de columna y la matriz
        System.out.print("   ");
        for (j = 0; j <= columnas - 1; ++j) {
            System.out.print("---");
        }
        System.out.println("");
        // Salto de línea
        // Mostrar el tablero con números de filas y columnas
        for (i = 0; i <= filas - 1; ++i) {
            // Mostrar el número de la fila al principio
            if (i < 9) {
                System.out.print(" " + i + 1 + "|");
            } else {
                System.out.print(i + 1 + "|");
            }
            for (j = 0; j <= columnas - 1; ++j) {
                // Comprobar si en la matrizCortina está liberado el lugar para mostrar la matriz de minas
                if (cortina[i][j].equals("0") || cortina[i][j].equals("2")) {
                    // /Esto es lo unico que cambie para mostrar la matriz al final del juego
                    if (matriz[i][j].equals("11")) {
                        System.out.print(" X ");
                    } else {
                        if (cortina[i][j].equals("0")) {
                            // Si es el valor 0 en la matrizCortina, entonces muestra la matrizCortina
                            System.out.print(" . ");
                        }
                    }
                } else {
                    if (cortina[i][j].equals("1")) {
                        // Si es el valor 1 en la matrizCortina, entonces muestra la matriz de minas
                        if (matriz[i][j].equals("0")) {
                            // En la matriz de minas si es = 0 entonces muestra un "  " (espacio vacío)
                            System.out.print("   ");
                        } else {
                            // Y si no es ninguno de los anteriores muestra el número de bombas que tiene alrededor ese espacio
                            System.out.print(" " + matriz[i][j] + " ");
                        }
                    } else {
                        if (cortina[i][j].equals("2")) {
                            // Si es un 2, en este espacio se colocó una bandera
                            System.out.print(" P ");
                            // La P parece una bandera
                        }
                    }
                }
            }
            // Mostrar el número de la fila al final
            System.out.println("|" + i + 1);
        }
        // Mostrar los guiones entre la matriz y los números de columna en la parte inferior
        System.out.print("   ");
        for (j = 0; j <= columnas - 1; ++j) {
            System.out.print("---");
        }
        System.out.println("");
        // Salto de línea
        // Mostrar los números de columna en la parte inferior
        System.out.print("   ");
        for (j = 0; j <= columnas - 1; ++j) {
            // /Este condicional es para cuando haya columnas con mas de 1 digito se siga viendo bien
            if (j < 10) {
                System.out.print(" " + j + 1 + " ");
            } else {
                System.out.print(j + 1 + " ");
            }
        }
        System.out.println("");
        // Salto de línea
    }

    // Este Algoritmo crea una matriz con minas en lugares aleatorios
    public static void creartablerominasaleatorias(double matriz[][], double filas, double columnas, int minas) {
        int contadorminas;
        int i;
        int j;
        boolean primeravez;
        contadorminas = 0;
        primeravez = true;
        // Generamos una matriz con las minas aleatorias
        do {
            for (i = 0; i <= filas - 1; ++i) {
                for (j = 0; j <= columnas - 1; ++j) {
                    if (Math.floor(Math.random() * 10) == 0 && contadorminas != minas) {
                        // Agrega una mina
                        if (primeravez == true) {
                            // Si es la primera vez que se ejecuta el codigo
                            matriz[i][j] = 11;
                            // simplemente agrega el numero a una matriz de cero
                            contadorminas = contadorminas + 1;
                            // Sino
                        } else {
                            if (matriz[i][j] == 10) {
                                // Verifica si en la posicion actual (hay osea el 11)
                                matriz[i][j] = 11;
                                // o no una mina(osea el 10)
                                contadorminas = contadorminas + 1;
                            }
                        }
                    } else {
                        if (primeravez == true) {
                            // Si es la primera vez que se ejecuta el codigo
                            matriz[i][j] = 10;
                            // simplemente agrega el numero a una matriz de cero
                        }
                    }
                }
            }
            // Escribir contadorMinas;
            primeravez = false;
        } while (contadorminas != minas);
    }

    // Este algoritmo coloca en la matriz creada en cada espacio que no tiene minas, cuantas minas tiene alrededor
    public static void tablerodeminasadyacentes(int tablero[][], double filas, double columnas) {
        int i;
        int j;
        int minascercanas;
        minascercanas = 0;
        // muestra las los numeros correspondientes a las minas
        for (i = 0; i <= filas - 1; ++i) {
            for (j = 0; j <= columnas - 1; ++j) {
                // esquina superior izquierda
                if (i == 0 && j == 0) {
                    if (tablero[i][j] == 11) {
                        tablero[i][j] = 11;
                    } else {
                        // 6
                        if (tablero[i][j + 1] == 11) {
                            minascercanas = minascercanas + 1;
                        }
                        // 8
                        if (tablero[i + 1][j] == 11) {
                            minascercanas = minascercanas + 1;
                        }
                        // 9
                        if (tablero[i + 1][j + 1] == 11) {
                            minascercanas = minascercanas + 1;
                        }
                        tablero[i][j] = minascercanas;
                    }
                    minascercanas = 0;
                }
                // esquina supeior derecha
                if (i == 0 && j == columnas - 1) {
                    if (tablero[i][j] == 11) {
                        tablero[i][j] = 11;
                    } else {
                        // 4
                        if (tablero[i][j - 1] == 11) {
                            minascercanas = minascercanas + 1;
                        }
                        // 7
                        if (tablero[i + 1][j - 1] == 11) {
                            minascercanas = minascercanas + 1;
                        }
                        // 8
                        if (tablero[i + 1][j] == 11) {
                            minascercanas = minascercanas + 1;
                        }
                        tablero[i][j] = minascercanas;
                    }
                    minascercanas = 0;
                }
                // esquina inferior izquierda
                if (i == filas - 1 && j == 0) {
                    if (tablero[i][j] == 11) {
                        tablero[i][j] = 11;
                    } else {
                        // 2
                        if (tablero[i - 1][j] == 11) {
                            minascercanas = minascercanas + 1;
                        }
                        // 3
                        if (tablero[i - 1][j + 1] == 11) {
                            minascercanas = minascercanas + 1;
                        }
                        // 6
                        if (tablero[i][j + 1] == 11) {
                            minascercanas = minascercanas + 1;
                        }
                        tablero[i][j] = minascercanas;
                    }
                    minascercanas = 0;
                }
                // esquina inferior derecha
                if (i == filas - 1 && j == columnas - 1) {
                    if (tablero[i][j] == 11) {
                        tablero[i][j] = 11;
                    } else {
                        // 1
                        if (tablero[i - 1][j - 1] == 11) {
                            minascercanas = minascercanas + 1;
                        }
                        // 2
                        if (tablero[i - 1][j] == 11) {
                            minascercanas = minascercanas + 1;
                        }
                        // 4
                        if (tablero[i][j - 1] == 11) {
                            minascercanas = minascercanas + 1;
                        }
                        tablero[i][j] = minascercanas;
                    }
                    minascercanas = 0;
                }
                // borde superior
                if (i == 0 && j != 0 && j != columnas - 1) {
                    if (tablero[i][j] == 11) {
                        tablero[i][j] = 11;
                    } else {
                        // 4
                        if (tablero[i][j - 1] == 11) {
                            minascercanas = minascercanas + 1;
                        }
                        // 6
                        if (tablero[i][j + 1] == 11) {
                            minascercanas = minascercanas + 1;
                        }
                        // 7
                        if (tablero[i + 1][j - 1] == 11) {
                            minascercanas = minascercanas + 1;
                        }
                        // 8
                        if (tablero[i + 1][j] == 11) {
                            minascercanas = minascercanas + 1;
                        }
                        // 9
                        if (tablero[i + 1][j + 1] == 11) {
                            minascercanas = minascercanas + 1;
                        }
                        tablero[i][j] = minascercanas;
                    }
                    minascercanas = 0;
                }
                // borde derecho
                if (i != 0 && i != filas - 1 && j == columnas - 1) {
                    if (tablero[i][j] == 11) {
                        tablero[i][j] = 11;
                    } else {
                        // 1
                        if (tablero[i - 1][j - 1] == 11) {
                            minascercanas = minascercanas + 1;
                        }
                        // 2
                        if (tablero[i - 1][j] == 11) {
                            minascercanas = minascercanas + 1;
                        }
                        // 4
                        if (tablero[i][j - 1] == 11) {
                            minascercanas = minascercanas + 1;
                        }
                        // 7
                        if (tablero[i + 1][j - 1] == 11) {
                            minascercanas = minascercanas + 1;
                        }
                        // 8
                        if (tablero[i + 1][j] == 11) {
                            minascercanas = minascercanas + 1;
                        }
                        tablero[i][j] = minascercanas;
                    }
                    minascercanas = 0;
                }
                // borde inferior
                if (i == filas - 1 && j != 0 && j != columnas - 1) {
                    if (tablero[i][j] == 11) {
                        tablero[i][j] = 11;
                    } else {
                        // 1
                        if (tablero[i - 1][j - 1] == 11) {
                            minascercanas = minascercanas + 1;
                        }
                        // 2
                        if (tablero[i - 1][j] == 11) {
                            minascercanas = minascercanas + 1;
                        }
                        // 3
                        if (tablero[i - 1][j + 1] == 11) {
                            minascercanas = minascercanas + 1;
                        }
                        // 4
                        if (tablero[i][j - 1] == 11) {
                            minascercanas = minascercanas + 1;
                        }
                        // 6
                        if (tablero[i][j + 1] == 11) {
                            minascercanas = minascercanas + 1;
                        }
                        tablero[i][j] = minascercanas;
                    }
                    minascercanas = 0;
                }
                // borde izquierdo
                if (i != 0 && i != filas - 1 && j == 0) {
                    if (tablero[i][j] == 11) {
                        tablero[i][j] = 11;
                    } else {
                        // 2
                        if (tablero[i - 1][j] == 11) {
                            minascercanas = minascercanas + 1;
                        }
                        // 3
                        if (tablero[i - 1][j + 1] == 11) {
                            minascercanas = minascercanas + 1;
                        }
                        // 6
                        if (tablero[i][j + 1] == 11) {
                            minascercanas = minascercanas + 1;
                        }
                        // 8
                        if (tablero[i + 1][j] == 11) {
                            minascercanas = minascercanas + 1;
                        }
                        // 9
                        if (tablero[i + 1][j + 1] == 11) {
                            minascercanas = minascercanas + 1;
                        }
                        tablero[i][j] = minascercanas;
                    }
                    minascercanas = 0;
                }
                // centro
                if (i != 0 && i != filas - 1 && j != 0 && j != columnas - 1) {
                    if (tablero[i][j] == 11) {
                        tablero[i][j] = 11;
                    } else {
                        // 1
                        if (tablero[i - 1][j - 1] == 11) {
                            minascercanas = minascercanas + 1;
                        }
                        // 2
                        if (tablero[i - 1][j] == 11) {
                            minascercanas = minascercanas + 1;
                        }
                        // 3
                        if (tablero[i - 1][j + 1] == 11) {
                            minascercanas = minascercanas + 1;
                        }
                        // 4
                        if (tablero[i][j - 1] == 11) {
                            minascercanas = minascercanas + 1;
                        }
                        // 6
                        if (tablero[i][j + 1] == 11) {
                            minascercanas = minascercanas + 1;
                        }
                        // 7
                        if (tablero[i + 1][j - 1] == 11) {
                            minascercanas = minascercanas + 1;
                        }
                        // 8
                        if (tablero[i + 1][j] == 11) {
                            minascercanas = minascercanas + 1;
                        }
                        // 9
                        if (tablero[i + 1][j + 1] == 11) {
                            minascercanas = minascercanas + 1;
                        }
                        tablero[i][j] = minascercanas;
                    }
                }
                minascercanas = 0;
            }
        }
    }

    // Proceso para decubrir los lugares sin minas a los alrededores
    public static void exploracion(String[][] matrizatras, String[][] matrizcortina, int filas, int columnas) throws IOException, InterruptedException {
        int columnascoordenadas = 0;
        int filascoordenadas;
        boolean gano;
        int i;
        int j;
        boolean perdio;
        perdio = false;
        gano = false;
        do {
            do {
                System.out.println(""); // no hay forma directa de borrar la consola en Java
                // Vamos mostrando el tablero
                mostrartablero(matrizatras, matrizcortina, filas, columnas);
                // Esta parte es para que el usuario elija donde poner el puntero para desbloquear el tablero
                System.out.println("");
                System.out.println("      COORDENADAS A SELECCIONAR: ");
                System.out.println("");
                System.out.println("Para poner o quitar banderas ingrese -2");
                System.out.println("        (menos 2, en simbolo)");
                System.out.println("");
                System.out.print("       Fila: ");
                filascoordenadas = Integer.parseInt(bufEntrada.readLine());
                // Fila de posicion seleccionada
                if (filascoordenadas == -2) {
                    colocarquitarbandera(matrizatras, matrizcortina, filas, columnas);
                } else {
                    System.out.print("       Columna: ");
                    columnascoordenadas = Integer.parseInt(bufEntrada.readLine());
                    // Columna de posicion seleccionada
                    if (columnascoordenadas == -2) {
                        colocarquitarbandera(matrizatras, matrizcortina, filas, columnas);
                    } else {
                        // Validamos las coordenadas dentro del rango permitido
                        if (filascoordenadas >= 1 && filascoordenadas <= filas && columnascoordenadas >= 1 && columnascoordenadas <= columnas) {
                            filascoordenadas = filascoordenadas - 1;
                            // Ajustamos para que coincida con el índice de la matriz
                            columnascoordenadas = columnascoordenadas - 1;
                            // Ajustamos para que coincida con el índice de la matriz
                            // Verificamos si hay una bandera en la posición seleccionada
                            if (matrizcortina[filascoordenadas][columnascoordenadas].equals("2")) {
                                System.out.println("      Hay una bandera");
                                filascoordenadas = -1;
                                // Esto es para cuando el jugador seleccione una posición con una bandera, pueda seguir jugando en caso que sea una mina
                                Thread.sleep(2 * 1000);
                            }
                        }
                    }
                }
                // Este "Hasta que" cierra el bucle interior que se repite hasta que las coordenadas sean válidas
            } while (!(filascoordenadas != -2 && columnascoordenadas != -2 && ((filascoordenadas >= 0 && filascoordenadas <= filas - 1) && (columnascoordenadas >= 0 && columnascoordenadas <= columnas - 1))));
            if (matrizatras[filascoordenadas][columnascoordenadas].equals("11")) {
                // Si la posición seleccionada hay una mina (11) entonces pierde
                System.out.println(""); // no hay forma directa de borrar la consola en Java
                perdio = true;
                System.out.println("    .__.       .___.    .____.  .______.  .__.    .__. ");
                System.out.println("    |  |      / ._. \\  /  .__|  |  ____|  |__|    |__| ");
                System.out.println("    |  |     |  | |  | \\___. \\  |  __|      .______.   ");
                System.out.println("    |  |___. |  |_|  | .___|  | |  |___.   /  .__.  \\  ");
                System.out.println("    |______|  \\_____/  |_____/  |______|   \\_/    \\_/  ");
                System.out.println("");
                Thread.sleep(2 * 1000);
                mostrartablerofinjuego(matrizatras, matrizcortina, filas, columnas);
                System.out.println("");
                System.out.println("Oprima una tecla");
                System.in.read(); // a diferencia del pseudocódigo, espera un Enter, no cualquier tecla
            } else {
                System.out.println(""); // no hay forma directa de borrar la consola en Java
                alrededor(matrizatras, matrizcortina, filas, columnas, filascoordenadas, columnascoordenadas);
                gano = ganabuscamina(matrizatras, matrizcortina, filas, columnas);
                if (gano == true) {
                    // Si "gano" da Verdadero entonces
                    System.out.println("    ___              ___ .__. .___  .__.  ._. ._. ._.");
                    System.out.println("    \\  \\    ____    /  / |  | |   \\ |  |  | | | | | |");
                    System.out.println("     \\  \\  /    \\  /  /  |  | |    \\|  |  | | | | | |");
                    System.out.println("      \\  \\/  /\\  \\/  /   |  | |  |\\    |  |_| |_| |_|");
                    System.out.println("       \\____/  \\____/    |__| |__| \\___|  |_| |_| |_|");
                    Thread.sleep(2 * 1000);
                    System.out.println("");
                    mostrartablerofinjuego(matrizatras, matrizcortina, filas, columnas);
                    System.out.println("Oprima una tecla");
                    System.in.read(); // a diferencia del pseudocódigo, espera un Enter, no cualquier tecla
                }
            }
        } while (!(gano == true || perdio == true));
        animacioncierre();
    }

    // Este algoritmo es para que el jugador ingrese o quite una bandera
    public static void colocarquitarbandera(String[][] matrizatras, String matrizcortina[][], double filas, double columnas) throws IOException, InterruptedException {
        int columnascoordenadas;
        boolean dejarponerbanderas;
        int filascoordenadas;
        int siono;
        filascoordenadas = 0;
        columnascoordenadas = 0;
        siono = 0;
        dejarponerbanderas = false;
        System.out.println(""); // no hay forma directa de borrar la consola en Java
        do {
            System.out.println(""); // no hay forma directa de borrar la consola en Java
            // Vamos mostrando el tablero
            mostrartablero(matrizatras, matrizcortina, filas, columnas);
            System.out.println("");
            System.out.println("En qué COORDENADAS quiere colocar o");
            System.out.println("        quitar una bandera?: ");
            System.out.println("");
            System.out.println("Para dejar de poner banderas ingrese -1");
            System.out.println("");
            System.out.print("      Fila: ");
            filascoordenadas = Integer.parseInt(bufEntrada.readLine());
            // Fila de posicion seleccionada
            if (filascoordenadas == -1) {
                dejarponerbanderas = true;
            } else {
                System.out.print("      Columna: ");
                columnascoordenadas = Integer.parseInt(bufEntrada.readLine());
                // Columna de posicion seleccionada
                if (filascoordenadas == -1 || columnascoordenadas == -1) {
                    dejarponerbanderas = true;
                } else {
                    filascoordenadas = filascoordenadas - 1;
                    // Esto es para que tengan coherencia los numeros que elegimos con la matriz (si elije 1 como primera fila, para el algoritmo debe ser 0)
                    columnascoordenadas = columnascoordenadas - 1;
                    // Esto es para que tengan coherencia los numeros que elegimos con la matriz
                    if ((filascoordenadas >= 0 && filascoordenadas <= filas - 1) && (columnascoordenadas >= 0 && columnascoordenadas <= columnas - 1)) {
                        if (matrizcortina[filascoordenadas][columnascoordenadas].equals("2")) {
                            // Si en esta posición ya hay una bandera entonces
                            matrizcortina[filascoordenadas][columnascoordenadas].equals("0");
                            // Lo muestra un lugar tapado
                        } else {
                            if (matrizcortina[filascoordenadas][columnascoordenadas].equals("1")) {
                                // Si está destapado no puede colocar una bandera allí
                                System.out.println("No es posible colocar una bandera aquí");
                                Thread.sleep(2 * 1000);
                            } else {
                                if (matrizcortina[filascoordenadas][columnascoordenadas].equals("0")) {
                                    // Si está tapado entonces muestra una bandera
                                    matrizcortina[filascoordenadas][columnascoordenadas].equals("2");
                                }
                            }
                        }
                    }
                }
            }
        } while (dejarponerbanderas != true);
    }

    // Este algoritmo comprueba si gano o todavia no, el jugador
    public static boolean ganabuscamina(String[][] matrizatras, String[][] matrizcortina, double filas, double columnas) {
        int contcolumnas;
        int contfilas;
        boolean gano;
        gano = true;
        contfilas = 0;
        contcolumnas = 0;
        while (gano == true && contfilas <= filas - 1) {
            // Si no gano todavia o si las iteraciones llegan hasta las que tiene la matriz se corta el ciclo
            contcolumnas = 0;
            while (gano == true && contcolumnas <= columnas - 1) {
                // Si no gano todavia o si las iteraciones llegan hasta las que tiene la matriz se corta el ciclo
                if (matrizcortina[contfilas][contcolumnas].equals("0") && !matrizatras[contfilas][contcolumnas].equals("11")) {
                    gano = false;
                    // si la matriz cortina esta tapada y en la matriz de numeros hay un numero distinto a 11
                }
                // Entonces todavia no gano por lo tanto es falso
                contcolumnas = contcolumnas + 1;
            }
            contfilas = contfilas + 1;
        }
        return gano;
    }

    // Busca los alrededores de una poscicion seleccionada si hay lugares adyasentes sin minas
    public static void alrededor(String[][] matrizatras, String[][] matrizcortina, double filas, double columnas, int filascoor, int columnascoor) {
        int columna0;
        int fila0;
        int i;
        int j;
        boolean perdio;
        fila0 = 0;
        columna0 = 0;
        // Si la posicion seleccionada por el usuario es un numero solo muestra el numero
        if (!matrizatras[filascoor][columnascoor].equals("0")) {
            if (matrizatras[filascoor][columnascoor].equals("11")) {
                perdio = true;
            } else {
                if (!matrizcortina[filascoor][columnascoor].equals("2")) {
                    // Si es distinto a 2 (osea si no hay una bandera) se muestra el espacio
                    matrizcortina[filascoor][columnascoor].equals("1");
                }
            }
        } else {
            // Si es 0
            // Este lugar es para todos los espacios del medio, que no sean de los bordes del tablero
            if (((filascoor != 0 && filascoor != filas - 1) && (columnascoor != 0 && columnascoor != columnas - 1))) {
                matrizcortina[filascoor][columnascoor].equals("1");
                // Se destapa la posicion seleccionada
                for (i = 0; i <= 2; ++i) {
                    // 3 filas
                    for (j = 0; j <= 2; ++j) {
                        // 3 columnas
                        // Supongamos que el espacio elegido es la posicion (1,1) de una matriz 3x3
                        // Entonces lo que va a este "para" es ir recorriendo esa matriz desde el primer numero (posicion (0,0)) con la
                        // ayuda de los axiliares "fila0" y "columna0" que permiten que itere desde la primer posicion
                        // porque elegimos el espacio a este lo tomamos como si fuera el medio (1,1) pero necesitamos que este
                        // desde el primero (0,0), por eso los axiliares tienen el valor: ( (1,1) + (-1,-1) = (0,0) ).
                        fila0 = -1;
                        columna0 = -1;
                        // Esta posicion es el resultado de filasCoor o columnasCoor(poscion elegida por el usuario),
                        // fila0 o columna0(auxiliar para poscionamiento en (0,0) de una matriz 3x3) y i o j (para que itere como si fuera una matriz 3X3)
                        // |
                        if (matrizatras[filascoor + fila0 + i][columnascoor + columna0 + j].equals("0") && matrizcortina[filascoor + fila0 + i][columnascoor + columna0 + j].equals("0")) {
                            // Aqui utilizamos recursividad para que haga este prodedimento para todo lugar en blanco que haya
                            // Porque es lo que hace el buscaminas libera toda la zona del lugar que el jugador elige en los 8 espacios
                            // alrededor del mismo y si hay mas espacios vacios los hace con todos
                            alrededor(matrizatras, matrizcortina, filas, columnas, (filascoor + fila0 + i), (columnascoor + columna0 + j));
                        } else {
                            if (!matrizcortina[filascoor + fila0 + i][columnascoor + columna0 + j].equals("2")) {
                                // Si no es una bandera entonces:
                                matrizcortina[filascoor + fila0 + i][columnascoor + columna0 + j].equals("1");
                                // Mostramos es espacio
                            }
                        }
                    }
                }
            }
            // Este lugar es para todos los espacios del borde superior del tablero,sin las esquinas
            if (((filascoor == 0) && (columnascoor != 0 && columnascoor != columnas - 1))) {
                matrizcortina[filascoor][columnascoor].equals("1");
                // Se destapa la posicion seleccionada
                for (i = 0; i <= 1; ++i) {
                    // 2 filas
                    for (j = 0; j <= 2; ++j) {
                        // 3 columnas
                        // Supongamos que el espacio elegido es la posicion (0,1) de una matriz 2x3
                        // Entonces lo que va a este "para" es ir recorriendo esa matriz desde el primer numero (posicion (0,0)) con la
                        // ayuda de los axiliares "fila0" y "columna0" que permiten que itere desde la primer posicion
                        // porque elegimos el espacio a este lo tomamos como si fuera la posicion (0,1) pero necesitamos que este
                        // desde la primera (0,0), por eso los axiliares tienen el valor:  ( (0,1) + (0,-1) = (0,0) ).
                        fila0 = 0;
                        columna0 = -1;
                        // Esta posicion es el resultado de filasCoor o columnasCoor(poscion elegida por el usuario),
                        // fila0 o columna0(auxiliar para poscionamiento en (0,0) de una matriz 2x3) y i o j (para que itere como si fuera una matriz 3X3)
                        // v
                        if (matrizatras[filascoor + fila0 + i][columnascoor + columna0 + j].equals("0") && matrizcortina[filascoor + fila0 + i][columnascoor + columna0 + j].equals("0")) {
                            // Aqui utilizamos recursividad para que haga este prodedimento para todo lugar en blanco que haya
                            // Porque es lo que hace el buscaminas libera toda la zona del lugar que el jugador elige en los 5 espacios
                            // alrededor del mismo y si hay mas espacios vacios los hace con todos
                            alrededor(matrizatras, matrizcortina, filas, columnas, (filascoor + fila0 + i), (columnascoor + columna0 + j));
                        } else {
                            if (!matrizcortina[filascoor + fila0 + i][columnascoor + columna0 + j].equals("3")) {
                                // Si no es una bandera entonces:
                                matrizcortina[filascoor + fila0 + i][columnascoor + columna0 + j].equals("1");
                                // Mostramos es espacio
                            }
                        }
                    }
                }
            }
            // Este lugar es para todos los espacios del borde inferior del tablero,sin las esquinas
            if (((filascoor == (filas - 1) && (columnascoor != 0 && columnascoor != columnas - 1)))) {
                matrizcortina[filascoor][columnascoor] = "1";
                // Se destapa la posicion seleccionada
                for (i = 0; i <= 1; ++i) {
                    // 2 filas
                    for (j = 0; j <= 2; ++j) {
                        // 3 columnas
                        // Supongamos que el espacio elegido es la posicion (1,1) de una matriz 2x3
                        // Entonces lo que va a este "para" es ir recorriendo esa matriz desde el primer numero (posicion (0,0)) con la
                        // ayuda de los axiliares "fila0" y "columna0" que permiten que itere desde la primer posicion
                        // porque elegimos el espacio a este lo tomamos como si fuera la posicion (1,1) pero necesitamos que este
                        // desde la primera (0,0), por eso los axiliares tienen el valor:  ( (1,1) + (-1,-1) = (0,0) ).
                        fila0 = -1;
                        columna0 = -1;
                        // Esta posicion es el resultado de filasCoor o columnasCoor(poscion elegida por el usuario),
                        // fila0 o columna0(auxiliar para poscionamiento en (0,0) de una matriz 2x3) y i o j (para que itere como si fuera una matriz 2X3)
                        // v
                        if (matrizatras[filascoor + fila0 + i][columnascoor + columna0 + j].equals("0") && matrizcortina[filascoor + fila0 + i][columnascoor + columna0 + j].equals("0")) {
                            // Aqui utilizamos recursividad para que haga este prodedimento para todo lugar en blanco que haya
                            // Porque es lo que hace el buscaminas libera toda la zona del lugar que el jugador elige en los 5 espacios
                            // alrededor del mismo y si hay mas espacios vacios los hace con todos
                            alrededor(matrizatras, matrizcortina, filas, columnas, (filascoor + fila0 + i), (columnascoor + columna0 + j));
                        } else {
                            if (!matrizcortina[filascoor + fila0 + i][columnascoor + columna0 + j].equals("3")) {
                                // Si no es una bandera entonces:
                                matrizcortina[filascoor + fila0 + i][columnascoor + columna0 + j] = "1";
                                // Mostramos es espacio
                            }
                        }
                    }
                }
            }
            // Este lugar es para todos los espacios del borde derecho del tablero,sin las esquinas
            if (((filascoor != 0 && filascoor != filas - 1) && (columnascoor == 0))) {
                matrizcortina[filascoor][columnascoor] = "1";
                // Se destapa la posicion seleccionada
                for (i = 0; i <= 2; ++i) {
                    // 3 filas
                    for (j = 0; j <= 1; ++j) {
                        // 2 columnas
                        // Supongamos que el espacio elegido es la posicion (1,0) de una matriz 3x2
                        // Entonces lo que va a este "para" es ir recorriendo esa matriz desde el primer numero (posicion (0,0)) con la
                        // ayuda de los axiliares "fila0" y "columna0" que permiten que itere desde la primer posicion
                        // porque elegimos el espacio a este lo tomamos como si fuera la posicion (1,0) pero necesitamos que este
                        // desde la primera (0,0), por eso los axiliares tienen el valor:  ( (1,0) + (-1,0) = (0,0) ).
                        fila0 = -1;
                        columna0 = 0;
                        // Esta posicion es el resultado de filasCoor o columnasCoor(poscion elegida por el usuario),
                        // fila0 o columna0(auxiliar para poscionamiento en (0,0) de una matriz 3x2) y i o j (para que itere como si fuera una matriz 3x2)
                        // v
                        if (matrizatras[filascoor + fila0 + i][columnascoor + columna0 + j].equals("0") && matrizcortina[filascoor + fila0 + i][columnascoor + columna0 + j].equals("0")) {
                            // Aqui utilizamos recursividad para que haga este prodedimento para todo lugar en blanco que haya
                            // Porque es lo que hace el buscaminas libera toda la zona del lugar que el jugador elige en los 5 espacios
                            // alrededor del mismo y si hay mas espacios vacios los hace con todos
                            alrededor(matrizatras, matrizcortina, filas, columnas, (filascoor + fila0 + i), (columnascoor + columna0 + j));
                        } else {
                            if (!matrizcortina[filascoor + fila0 + i][columnascoor + columna0 + j].equals("3")) {
                                // Si no es una bandera entonces:
                                matrizcortina[filascoor + fila0 + i][columnascoor + columna0 + j] = "1";
                                // Mostramos es espacio
                            }
                        }
                    }
                }
            }
            // Este lugar es para todos los espacios del borde izquierdo del tablero,sin las esquinas
            if (((filascoor != 0 && filascoor != filas - 1) && (columnascoor == columnas - 1))) {
                matrizcortina[filascoor][columnascoor] = "1";
                // Se destapa la posicion seleccionada
                for (i = 0; i <= 2; ++i) {
                    // 3 filas
                    for (j = 0; j <= 1; ++j) {
                        // 2 columnas
                        // Supongamos que el espacio elegido es la posicion (1,1) de una matriz 3x2
                        // Entonces lo que va a este "para" es ir recorriendo esa matriz desde el primer numero (posicion (0,0)) con la
                        // ayuda de los axiliares "fila0" y "columna0" que permiten que itere desde la primer posicion
                        // porque elegimos el espacio a este lo tomamos como si fuera la posicion (1,1) pero necesitamos que este
                        // desde la primera (0,0), por eso los axiliares tienen el valor:  ( (1,1) + (-1,-1) = (0,0) ).
                        fila0 = -1;
                        columna0 = -1;
                        // Esta posicion es el resultado de filasCoor o columnasCoor(poscion elegida por el usuario),
                        // fila0 o columna0(auxiliar para poscionamiento en (0,0) de una matriz 3x2) y i o j (para que itere como si fuera una matriz 3X2)
                        // v
                        if (matrizatras[filascoor + fila0 + i][columnascoor + columna0 + j].equals("0 && matrizcortina[filascoor + fila0 + i][columnascoor + columna0 + j].equals("0")) {
                            // Aqui utilizamos recursividad para que haga este prodedimento para todo lugar en blanco que haya
                            // Porque es lo que hace el buscaminas libera toda la zona del lugar que el jugador elige en los 5 espacios
                            // alrededor del mismo y si hay mas espacios vacios los hace con todos
                            alrededor(matrizatras, matrizcortina, filas, columnas, (filascoor + fila0 + i), (columnascoor + columna0 + j));
                        } else {
                            if (matrizcortina[filascoor + fila0 + i][columnascoor + columna0 + j] != 3) {
                                // Si no es una bandera entonces:
                                matrizcortina[filascoor + fila0 + i][columnascoor + columna0 + j] = 1;
                                // Mostramos es espacio
                            }
                        }
                    }
                }
            }
            // Este lugar es para el espacio de la esquina superior derecha del tablero
            if (((filascoor.equals("0) && (columnascoor.equals("0))) {
                matrizcortina[filascoor][columnascoor] = 1;
                // Se destapa la posicion seleccionada
                for (i = 0; i <= 1; ++i) {
                    // 2 filas
                    for (j = 0; j <= 1; ++j) {
                        // 2 columnas
                        // Supongamos que el espacio elegido es la posicion (0,0) de una matriz 2x2
                        // Entonces lo que va a este "para" es ir recorriendo esa matriz desde el primer numero (posicion (0,0)) con la
                        // ayuda de los axiliares "fila0" y "columna0" que permiten que itere desde la primer posicion
                        // porque elegimos el espacio a este lo tomamos como si fuera la posicion (0,0) pero necesitamos que este
                        // desde la primera (0,0), por eso los axiliares tienen el valor:  ( (0,0) + (0,0) = (0,0) ).
                        fila0 = 0;
                        columna0 = 0;
                        // Esta posicion es el resultado de filasCoor o columnasCoor(poscion elegida por el usuario),
                        // fila0 o columna0(auxiliar para poscionamiento en (0,0) de una matriz 2x2) y i o j (para que itere como si fuera una matriz 2X2)
                        // v
                        if (matrizatras[filascoor + fila0 + i][columnascoor + columna0 + j].equals("0 && matrizcortina[filascoor + fila0 + i][columnascoor + columna0 + j].equals("0) {
                            // Aqui utilizamos recursividad para que haga este prodedimento para todo lugar en blanco que haya
                            // Porque es lo que hace el buscaminas libera toda la zona del lugar que el jugador elige en los 3 espacios
                            // alrededor del mismo y si hay mas espacios vacios los hace con todos
                            alrededor(matrizatras, matrizcortina, filas, columnas, (filascoor + fila0 + i), (columnascoor + columna0 + j));
                        } else {
                            if (matrizcortina[filascoor + fila0 + i][columnascoor + columna0 + j] != 3) {
                                // Si no es una bandera entonces:
                                matrizcortina[filascoor + fila0 + i][columnascoor + columna0 + j] = 1;
                                // Mostramos es espacio
                            }
                        }
                    }
                }
            }
            // Este lugar es para el espacio de la esquina superior izquierda del tablero
            if (((filascoor.equals("0) && (columnascoor.equals("columnas - 1))) {
                matrizcortina[filascoor][columnascoor] = 1;
                // Se destapa la posicion seleccionada
                for (i = 0; i <= 1; ++i) {
                    // 2 filas
                    for (j = 0; j <= 1; ++j) {
                        // 2 columnas
                        // Supongamos que el espacio elegido es la posicion (0,1) de una matriz 2x2
                        // Entonces lo que va a este "para" es ir recorriendo esa matriz desde el primer numero (posicion (0,0)) con la
                        // ayuda de los axiliares "fila0" y "columna0" que permiten que itere desde la primer posicion
                        // porque elegimos el espacio a este lo tomamos como si fuera la posicion (0,1) pero necesitamos que este
                        // desde la primera (0,0), por eso los axiliares tienen el valor:  ( (0,1) + (0,-1) = (0,0) ).
                        fila0 = 0;
                        columna0 = -1;
                        // Esta posicion es el resultado de filasCoor o columnasCoor(poscion elegida por el usuario),
                        // fila0 o columna0(auxiliar para poscionamiento en (0,0) de una matriz 2x2) y i o j (para que itere como si fuera una matriz 2X2)
                        // v
                        if (matrizatras[filascoor + fila0 + i][columnascoor + columna0 + j].equals("0 && matrizcortina[filascoor + fila0 + i][columnascoor + columna0 + j].equals("0) {
                            // Aqui utilizamos recursividad para que haga este prodedimento para todo lugar en blanco que haya
                            // Porque es lo que hace el buscaminas libera toda la zona del lugar que el jugador elige en los 3 espacios
                            // alrededor del mismo y si hay mas espacios vacios los hace con todos
                            alrededor(matrizatras, matrizcortina, filas, columnas, (filascoor + fila0 + i), (columnascoor + columna0 + j));
                        } else {
                            if (matrizcortina[filascoor + fila0 + i][columnascoor + columna0 + j] != 3) {
                                // Si no es una bandera entonces:
                                matrizcortina[filascoor + fila0 + i][columnascoor + columna0 + j] = 1;
                                // Mostramos es espacio
                            }
                        }
                    }
                }
            }
            // Este lugar es para el espacio de la esquina inferior derecha del tablero
            if (((filascoor.equals("filas - 1) && (columnascoor.equals("0))) {
                matrizcortina[filascoor][columnascoor] = 1;
                // Se destapa la posicion seleccionada
                for (i = 0; i <= 1; ++i) {
                    // 2 filas
                    for (j = 0; j <= 1; ++j) {
                        // 2 columnas
                        // Supongamos que el espacio elegido es la posicion (1,0) de una matriz 2x2
                        // Entonces lo que va a este "para" es ir recorriendo esa matriz desde el primer numero (posicion (0,0)) con la
                        // ayuda de los axiliares "fila0" y "columna0" que permiten que itere desde la primer posicion
                        // porque elegimos el espacio a este lo tomamos como si fuera la posicion (1,0) pero necesitamos que este
                        // desde la primera (0,0), por eso los axiliares tienen el valor:  ( (1,0) + (-1,0) = (0,0) ).
                        fila0 = -1;
                        columna0 = 0;
                        // Esta posicion es el resultado de filasCoor o columnasCoor(poscion elegida por el usuario),
                        // fila0 o columna0(auxiliar para poscionamiento en (0,0) de una matriz 2x2) y i o j (para que itere como si fuera una matriz 2X2)
                        // v
                        if (matrizatras[filascoor + fila0 + i][columnascoor + columna0 + j].equals("0 && matrizcortina[filascoor + fila0 + i][columnascoor + columna0 + j].equals("0) {
                            // Aqui utilizamos recursividad para que haga este prodedimento para todo lugar en blanco que haya
                            // Porque es lo que hace el buscaminas libera toda la zona del lugar que el jugador elige en los 3 espacios
                            // alrededor del mismo y si hay mas espacios vacios los hace con todos
                            alrededor(matrizatras, matrizcortina, filas, columnas, (filascoor + fila0 + i), (columnascoor + columna0 + j));
                        } else {
                            if (matrizcortina[filascoor + fila0 + i][columnascoor + columna0 + j] != 3) {
                                // Si no es una bandera entonces:
                                matrizcortina[filascoor + fila0 + i][columnascoor + columna0 + j] = 1;
                                // Mostramos es espacio
                            }
                        }
                    }
                }
            }
            // Este lugar es para el espacio de la esquina inferior izquierda del tablero
            if (((filascoor.equals("filas - 1) && (columnascoor.equals("columnas - 1))) {
                matrizcortina[filascoor][columnascoor] = 1;
                // Se destapa la posicion seleccionada
                for (i = 0; i <= 1; ++i) {
                    // 2 filas
                    for (j = 0; j <= 1; ++j) {
                        // 2 columnas
                        // Supongamos que el espacio elegido es la posicion (1,1) de una matriz 2x2
                        // Entonces lo que va a este "para" es ir recorriendo esa matriz desde el primer numero (posicion (0,0)) con la
                        // ayuda de los axiliares "fila0" y "columna0" que permiten que itere desde la primer posicion
                        // porque elegimos el espacio a este lo tomamos como si fuera la posicion (1,0) pero necesitamos que este
                        // desde la primera (0,0), por eso los axiliares tienen el valor:  ( (1,1) + (-1,-1) = (0,0) ).
                        fila0 = -1;
                        columna0 = -1;
                        // Esta posicion es el resultado de filasCoor o columnasCoor(poscion elegida por el usuario),
                        // fila0 o columna0(auxiliar para poscionamiento en (0,0) de una matriz 2x2) y i o j (para que itere como si fuera una matriz 2X2)
                        // v
                        if (matrizatras[filascoor + fila0 + i][columnascoor + columna0 + j].equals("0 && matrizcortina[filascoor + fila0 + i][columnascoor + columna0 + j] == 0) {
                            // Aqui utilizamos recursividad para que haga este prodedimento para todo lugar en blanco que haya
                            // Porque es lo que hace el buscaminas libera toda la zona del lugar que el jugador elige en los 3 espacios
                            // alrededor del mismo y si hay mas espacios vacios los hace con todos
                            alrededor(matrizatras, matrizcortina, filas, columnas, (filascoor + fila0 + i), (columnascoor + columna0 + j));
                        } else {
                            if (matrizcortina[filascoor + fila0 + i][columnascoor + columna0 + j] != 3) {
                                // Si no es una bandera entonces:
                                matrizcortina[filascoor + fila0 + i][columnascoor + columna0 + j] = 1;
                                // Mostramos es espacio
                            }
                        }
                    }
                }
            }
        }
    }

    // selecccionador de dificultades
    public static void dificultad(double filas, double columnas, double minas) throws IOException, InterruptedException {
        boolean bool;
        int num;
        do {
            System.out.println("    ____________________________________");
            System.out.println("    |Seleccione el nivel de dificultad:|");
            System.out.println("    |    /\\_/\\   1- FACIL              |");
            System.out.println("    |   ( o.o )  2- NORMAL             |");
            System.out.println("    |    > ^ <   3- DIFICIL            |");
            System.out.println("    ------------------------------------");
            num = Integer.parseInt(bufEntrada.readLine());
            bool = true;
            switch (num) {
                case 1:
                    filas = 8;
                    columnas = 10;
                    minas = 10;
                    break;
                case 2:
                    filas = 14;
                    columnas = 18;
                    minas = 40;
                    break;
                case 3:
                    filas = 20;
                    columnas = 24;
                    minas = 99;
                    break;
                default:
                    System.out.println(""); // no hay forma directa de borrar la consola en Java
                    System.out.println("");
                    System.out.println("    _______________________________");
                    System.out.println("    |Ingrese una dificultad valida|");
                    System.out.println("    -------------------------------");
                    Thread.sleep(2 * 1000);
                    bool = false;
                    System.out.println(""); // no hay forma directa de borrar la consola en Java
            }
        } while (bool != true);
    }

    // Este Algoritmo es el que hace que funcione el buscaminas y todas sus funciones
    public static void buscaminas() throws IOException {
        int columnas;
        int filas;
        boolean jugarotravez;
        int matriz[][];
        int matrizcortina[][];
        int minas;
        int num;
        // Con un argumento vacio funciona
        matriz = new int[30][30];
        matrizcortina = new int[30][30];
        num = 0;
        jugarotravez = true;
        do {
            filas = 0;
            columnas = 0;
            minas = 0;
            // Seleccionador de dificultad
            dificultad(filas, columnas, minas);
            // Creamos primero el tablero de minas aleatorias
            creartablerominasaleatorias(matriz, filas, columnas, minas);
            // En este tablero contamos cuantas minas tiene alrededor
            tablerodeminasadyacentes(matriz, filas, columnas);
            // Creamos el tablero cortina
            tablerocortina(matrizcortina, filas, columnas);
            // Explora el tablero
            exploracion(matriz, matrizcortina, filas, columnas);
            do {
                System.out.println(""); // no hay forma directa de borrar la consola en Java
                System.out.println("");
                System.out.println("Desea jugar otra vez? (1. Si, 2. No): ");
                num = Integer.parseInt(bufEntrada.readLine());
            } while (!(num == 1 || num == 2));
            switch (num) {
                case 1:
                    jugarotravez = true;
                    break;
                case 2:
                    jugarotravez = false;
                    break;
            }
            System.out.println(""); // no hay forma directa de borrar la consola en Java
        } while (jugarotravez != false);
    }

    public static void juegobuscaminas() throws IOException {
        buscaminas();
    }
}

