package servicios;

import entidades.Personaje;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;

import static utilidades.Util.*;

public class PersonajeServicio {
    BufferedReader bufEntrada = new BufferedReader(new InputStreamReader(System.in));

    public Personaje crearPersonaje() throws IOException {
        Personaje personaje = new Personaje();
        personaje.setNombre(bufEntrada.readLine());
        inicializarestadisticas(personaje);
        mostrarmensajeestadisticaspersonaje(personaje);

        return personaje;
    }

    // Proceso principal para crear un personaje con atributos basados en D&D 5e
    public static void inicializarestadisticas(Personaje personaje) {
        // Inicializamos la vida y experiencia base
        personaje.setVida(10 + sumatresmayoresd6());
        // Base de 10 más bonificación
        personaje.setExperiencia(0);
        personaje.setNivel(1);
        personaje.setEstado("Normal");
        // Ajustamos cada atributo con la suma de los tres mayores de 4d6
        // y aseguramos que estén en el rango de 0 a 20
        personaje.setFuerza(ajustaratributo(sumatresmayoresd6()));
        personaje.setDefensa(ajustaratributo(sumatresmayoresd6()));
        personaje.setAgilidad(ajustaratributo(sumatresmayoresd6()));
        personaje.setInteligencia(ajustaratributo(sumatresmayoresd6()));
    }

    // Función para obtener la suma de los tres mayores de cuatro dados D6
    public static int sumatresmayoresd6() {
        int dado1;
        int dado2;
        int dado3;
        int dado4;
        int menor;
        int suma;
        // Lanzamos cuatro dados
        dado1 = lanzarDado(1, 6);
        dado2 = lanzarDado(1, 6);
        dado3 = lanzarDado(1, 6);
        dado4 = lanzarDado(1, 6);
        // Encontramos el menor de los cuatro lanzamientos
        menor = dado1;
        if (menor > dado2) {
            menor = dado2;
        }
        if (menor > dado3) {
            menor = dado3;
        }
        if (menor > dado4) {
            menor = dado4;
        }
        // Sumamos todos los dados y restamos el menor
        suma = dado1 + dado2 + dado3 + dado4 - menor;
        return suma;
    }

    // Función para ajustar un atributo a estar dentro del rango de 0 a 20
    public static int ajustaratributo(int value) {
        if (value < 0) {
            value = 0;
        } else {
            if (value > 20) {
                value = 20;
            }
        }
        return value;
    }

    public static void mostrarmensajeingresarnombre() {
        String mensaje;
        mensaje = "Ingrese el nombre de su personaje     ";
        mensaje = mensaje.concat("para comenzar");
        mostrarmensaje(mensaje);
    }

    public static void mostrarmensajeestadisticaspersonaje(Personaje personaje) {
        String[] mensaje;
        mensaje = new String[10];
        mensaje[0] = "DATOS PERSONAJE";
        mensaje[1] = personaje.getNombre();
        mensaje[2] = "Vida: ".concat(Double.toString(personaje.getVida()));
        mensaje[3] = "Experiencia: ".concat(Double.toString(personaje.getExperiencia()));
        mensaje[4] = "Fuerza: ".concat(Double.toString(personaje.getFuerza()));
        mensaje[5] = "Defensa: ".concat(Double.toString(personaje.getDefensa()));
        mensaje[6] = "Agilidad: ".concat(Double.toString(personaje.getAgilidad()));
        mensaje[7] = "Inteligencia: ".concat(Double.toString(personaje.getInteligencia()));
        mensaje[8] = "Nivel: ".concat(Double.toString(personaje.getNivel()));
        mensaje[9] = "Estado: ".concat(personaje.getEstado());
        mostrarMensajes(mensaje, 10);
    }

}
