package utilidades;

import java.util.Random;

public class Util {
    static int longMensaje = 38;
    static String techo = "|-";
    static String piso = "|_";
    public static void mostrarmensaje(String mensaje) {
        int i;
        String palabras;
        for (i = 1; i <= longMensaje; ++i) {
            techo = techo.concat("-");
            piso = piso.concat("_");
        }
        techo = techo.concat("-|");
        piso = piso.concat("_|");
        System.out.println(techo);
        for (i = 0; i <= mensaje.length() - 1; i += longMensaje) {
            palabras = mensaje.substring(i, i + longMensaje);
            escrituraMensaje(palabras.substring(0, longMensaje), longMensaje);
        }
        System.out.println(piso);
    }

    public static void mostrarMensajes(String[] mensajes, double cantidad) {
        int i;
        int longMensaje = 38;
        String piso = "|_";
        escribirTecho();
        for (i = 0; i <= cantidad - 1; ++i) {
            escrituraMensaje(mensajes[i].substring(0, longMensaje + 1), longMensaje);
        }
        System.out.println(piso);
    }
    public static void escribirTecho(){
        for (int i = 1; i <= longMensaje; ++i) {
            techo = techo.concat("-");
            piso = piso.concat("_");
        }
        techo = techo.concat("-|");
        piso = piso.concat("_|");
        System.out.println(techo);
    }

    public static void escrituraMensaje(String mensaje, double tamanio) {
        int i;
        for (i = 0; i <= tamanio - mensaje.length(); ++i) {
            mensaje = mensaje.concat(" ");
        }
        System.out.print("| ");
        for (i = 0; i <= tamanio - 1; ++i) {
            System.out.print(mensaje.charAt(i));
        }
        System.out.println(" |");
    }

    public static void mostrarmensajeaccionesmapa(String estado) {
        String mensaje;
        mensaje = "";
        if (estado.equals("0001")) {
            mensaje = "¡Opción inválida!                     ";
        } else {
            if (estado.equals("0002")) {
                mensaje = "¡Movimiento Inválido!                 ";
            } else {
                if (estado.equals("0003")) {
                    mensaje = "¡Una pared bloquea el paso!           ";
                }
            }
        }
        mensaje = mensaje.concat("""
                 Ingrese una acción:                 \s
                            (W) Arriba   (E) Stats   \s
                    Izq (A)     (D) Der              \s
                            (S) Abajo                 \
                """);
    }

    // Incluimos una función para simular el lanzamiento de un dado de 6 caras
    public static int lanzarDado(int minimo, int maximo) {
        Random r = new Random();
        return r.nextInt(minimo, maximo);
    }
}

