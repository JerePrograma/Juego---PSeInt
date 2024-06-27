package entidades;

public class Personaje {
    Integer vida;
    Integer vidaMaxima;
    Integer agilidad;
    Integer defensa;
    String estado;
    Integer experiencia;
    Integer fuerza;
    Integer inteligencia;
    Integer nivel;
    String nombre;

    public Personaje() {
    }

    public Personaje(Integer agilidad, Integer defensa, String estado, Integer experiencia, Integer fuerza, Integer inteligencia, Integer nivel, String nombre, Integer vida, Integer vidaMaxima) {
        this.agilidad = agilidad;
        this.defensa = defensa;
        this.estado = estado;
        this.experiencia = experiencia;
        this.fuerza = fuerza;
        this.inteligencia = inteligencia;
        this.nivel = nivel;
        this.nombre = nombre;
        this.vida = vida;
        this.vidaMaxima = vidaMaxima;
    }

    public Integer getAgilidad() {
        return agilidad;
    }

    public void setAgilidad(Integer agilidad) {
        this.agilidad = agilidad;
    }

    public Integer getDefensa() {
        return defensa;
    }

    public void setDefensa(Integer defensa) {
        this.defensa = defensa;
    }

    public String getEstado() {
        return estado;
    }

    public void setEstado(String estado) {
        this.estado = estado;
    }

    public Integer getExperiencia() {
        return experiencia;
    }

    public void setExperiencia(Integer experiencia) {
        this.experiencia = experiencia;
    }

    public Integer getFuerza() {
        return fuerza;
    }

    public void setFuerza(Integer fuerza) {
        this.fuerza = fuerza;
    }

    public Integer getInteligencia() {
        return inteligencia;
    }

    public void setInteligencia(Integer inteligencia) {
        this.inteligencia = inteligencia;
    }

    public Integer getNivel() {
        return nivel;
    }

    public void setNivel(Integer nivel) {
        this.nivel = nivel;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public Integer getVida() {
        return vida;
    }

    public void setVida(Integer vida) {
        this.vida = vida;
    }

    public Integer getVidaMaxima() {
        return vidaMaxima;
    }

    public void setVidaMaxima(Integer vidaMaxima) {
        this.vidaMaxima = vidaMaxima;
    }
}
