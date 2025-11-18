package com.example.DHT.DTO;

import com.example.DHT.model.Resenia;

import java.time.LocalDate;

public class ReseniaDTO {
    private String nombrePrenda;
    private String nombreCliente;
    private int estrellas;
    private String comentario;
    private LocalDate fecha;
    private String fotoPrenda;

    public ReseniaDTO(Resenia resenia) {
        this.nombreCliente = resenia.getCliente().getNombre() + " " + resenia.getCliente().getApellido();
        this.nombrePrenda = resenia.getPrenda().getNombre();
        this.estrellas = resenia.getEstrellas();
        this.comentario = resenia.getComentario();
        this.fecha = resenia.getFecha();
        this.fotoPrenda = resenia.getPrenda().getFotoPrincipal();
    }

    public String getNombrePrenda() {
        return nombrePrenda;
    }

    public void setNombrePrenda(String nombrePrenda) {
        this.nombrePrenda = nombrePrenda;
    }

    public int getEstrellas() {
        return estrellas;
    }

    public void setEstrellas(int estrellas) {
        this.estrellas = estrellas;
    }

    public String getComentario() {
        return comentario;
    }

    public void setComentario(String comentario) {
        this.comentario = comentario;
    }

    public LocalDate getFecha() {
        return fecha;
    }

    public void setFecha(LocalDate fecha) {
        this.fecha = fecha;
    }

    public String getFotoPrenda() {
        return fotoPrenda;
    }

    public void setFotoPrenda(String fotoPrenda) {
        this.fotoPrenda = fotoPrenda;
    }

    public String getNombreCliente() {
        return nombreCliente;
    }

    public void setNombreCliente(String nombreCliente) {
        this.nombreCliente = nombreCliente;
    }
}