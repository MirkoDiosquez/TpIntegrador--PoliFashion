package com.example.DHT.DTO;

import com.example.DHT.extras.enums.GeneroUsuario;

import java.time.LocalDate;

public class ClienteDTO
{
    private String dni ;
    private String nombre ;
    private String apellido ;
    private LocalDate fechaNacimiento ;
    private int puntos ;
    private GeneroUsuario genero ;
    private String email;
    private String contrasenia;
    private String fotoPerfil;

    public ClienteDTO(String dni, String nombre, String apellido, LocalDate fechaNacimiento, String genero, String email, String contrasenia, String fotoPerfil) {
        this.dni = dni;
        this.nombre = nombre;
        this.apellido = apellido;
        this.fechaNacimiento = fechaNacimiento;
        this.puntos = 0;
        this.genero = convertirStringAlEnum(genero);
        this.email = email;
        this.contrasenia = contrasenia;
        this.fotoPerfil = fotoPerfil;
    }

    public GeneroUsuario convertirStringAlEnum(String genero){
        if(genero.equals("masculino")){
            return GeneroUsuario.Masculino;
        }
        else if(genero.equals("femenino")){
            return GeneroUsuario.Femenino;
        }
        return GeneroUsuario.Otro;
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
