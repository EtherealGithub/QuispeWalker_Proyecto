package entidades;

import java.time.LocalDateTime;

public class Administrador {
    private String dni;
    private String nombre;
    private String apellido;
    private String correo;
    private LocalDateTime fechaCreacion;

    public Administrador() {}


    public Administrador(String dni, String nombre, String Apellido, String correo, LocalDateTime fechaCreacion) {
        this.dni = dni;
        this.nombre = nombre;
        this.apellido = Apellido;
        this.correo = correo;
        this.fechaCreacion = fechaCreacion;
    }

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
}
