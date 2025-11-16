package com.example.DHT.model;

import com.example.DHT.extras.enums.GeneroUsuario;
import jakarta.persistence.*;
import java.time.LocalDate;

@Entity
@Table(name = "cliente")
public class Cliente {

    @Id
    @Column(name = "dni", length = 15)
    private String dni;

    @Column(name = "nombre", nullable = false, length = 50)
    private String nombre;

    @Column(name = "apellido", nullable = false, length = 50)
    private String apellido;

    @Column(name = "fechaNacimiento")
    private LocalDate fechaNacimiento;

    @Column(name = "puntos")
    private int puntos;

    @Enumerated(EnumType.STRING)
    @Column(name = "genero", nullable = false)
    private GeneroUsuario genero;

    @Column(name = "email", nullable = false, unique = true, length = 50)
    private String email;

    @Column(name = "contrasenia", nullable = false, length = 50)
    private String contrasenia;

    @Column(name = "fotoPerfil")
    private String fotoPerfil;


    public Cliente() {
    }

    public Cliente(String dni, String nombre, String apellido, LocalDate fechaNacimiento, int puntos, GeneroUsuario genero, String email, String contrasenia) {
        this.dni = dni;
        this.nombre = nombre;
        this.apellido = apellido;
        this.fechaNacimiento = fechaNacimiento;
        this.puntos = puntos;
        this.genero = genero;
        this.email = email;
        this.contrasenia = contrasenia;
    }

   public Cliente(String dni, String nombre, String apellido, LocalDate fechaNacimiento, GeneroUsuario genero, String email, String contrasenia) {
        this.dni = dni;
        this.nombre = nombre;
        this.apellido = apellido;
        this.fechaNacimiento = fechaNacimiento;
        this.puntos = 0;
        this.genero = genero;
        this.email = email;
        this.contrasenia = contrasenia;
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

    public void setApellido(String apellido) {
        this.apellido = apellido;
    }

    public LocalDate getFechaNacimiento() {
        return fechaNacimiento;
    }

    public void setFechaNacimiento(LocalDate fechaNacimiento) {
        this.fechaNacimiento = fechaNacimiento;
    }

    public int getPuntos() {
        return puntos;
    }

    public void setPuntos(int puntos) {
        this.puntos = puntos;
    }

    public GeneroUsuario getGenero() {
        return genero;
    }

    public void setGenero(GeneroUsuario genero) {
        this.genero = genero;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getContrasenia() {
        return contrasenia;
    }

    public void setContrasenia(String contrasenia) {
        this.contrasenia = contrasenia;
    }
}