package entidades;

import java.time.LocalDateTime;

public class Administrador {
    private String dni;
    private String nombre;
    private String apellido;
    private String correo;
    private LocalDateTime fechaCreacion;

    // Constructor vacío
    public Administrador() {}

    // Constructor con parámetros
    public Administrador(String dni, String nombre, String Apellido, String correo, LocalDateTime fechaCreacion) {
        this.dni = dni;
        this.nombre = nombre;
        this.apellido = Apellido;
        this.correo = correo;
        this.fechaCreacion = fechaCreacion;
    }

    // Getters y Setters
    public String getDni() {
        return dni;
    }

    public void setDni(String dni) {
        this.dni = dni;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getApellido() {
        return apellido;
    }

    public void setApellido(String Apellido) {
        this.apellido = Apellido;
    }

    public String getCorreo() {
        return correo;
    }

    public void setCorreo(String correo) {
        this.correo = correo;
    }

    public LocalDateTime getFechaCreacion() {
        return fechaCreacion;
    }

    public void setFechaCreacion(LocalDateTime fechaCreacion) {
        this.fechaCreacion = fechaCreacion;
    }

    // Método toString para facilitar la impresión de objetos
    @Override
    public String toString() {
        return "Administrador{" +
                "dni='" + dni + '\'' +
                ", nombres='" + nombre + '\'' +
                ", apellidos='" + apellido + '\'' +
                ", correo='" + correo + '\'' +
                ", fechaCreacion=" + fechaCreacion +
                '}';
    }
}
