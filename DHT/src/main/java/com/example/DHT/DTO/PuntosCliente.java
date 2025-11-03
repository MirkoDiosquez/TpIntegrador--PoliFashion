package com.example.DHT.DTO;

public class PuntosCliente {

    private String clienteDni;
    private String nombreCompleto;
    private Integer puntosActuales;

    public PuntosCliente() {   }

    public PuntosCliente(String clienteDni, String nombreCompleto, Integer puntosActuales) {
        this.clienteDni = clienteDni;
        this.nombreCompleto = nombreCompleto;
        this.puntosActuales = puntosActuales;
    }

    public String getClienteDni() {
        return clienteDni;
    }

    public void setClienteDni(String clienteDni) {
        this.clienteDni = clienteDni;
    }

    public String getNombreCompleto() {
        return nombreCompleto;
    }

    public void setNombreCompleto(String nombreCompleto) {
        this.nombreCompleto = nombreCompleto;
    }

    public Integer getPuntosActuales() {
        return puntosActuales;
    }

    public void setPuntosActuales(Integer puntosActuales) {
        this.puntosActuales = puntosActuales;
    }
}