package com.example.DHT.DTO;

import java.util.List;

public class DevolucionDTO {

    private String clienteDni;
    private Integer idCompra; 
    private List<ItemDevolucion> items;

    // Constructor vacío
    public DevolucionDTO() {
    }

    // Constructor con campos
    public DevolucionDTO(String clienteDni, Integer idCompra, List<ItemDevolucion> items) {
        this.clienteDni = clienteDni;
        this.idCompra = idCompra;
        this.items = items;
    }

    // Getters y Setters
    public String getClienteDni() {
        return clienteDni;
    }

    public void setClienteDni(String clienteDni) {
        this.clienteDni = clienteDni;
    }

    public Integer getidCompra() {
        return idCompra;
    }

    public void setidCompra(Integer idCompra) {
        this.idCompra = idCompra;
    }

    public List<ItemDevolucion> getItems() {
        return items;
    }

    public void setItems(List<ItemDevolucion> items) {
        this.items = items;
    }
}