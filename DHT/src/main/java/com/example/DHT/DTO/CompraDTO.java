package com.example.DHT.DTO;

import java.util.List;

public class CompraDTO {

    private String clienteDni;
    private Integer idMetodo;
    private List<ItemCompra> items;

    public CompraDTO() {
    }

    public CompraDTO(String clienteDni, Integer idMetodo, List<ItemCompra> items) {
        this.clienteDni = clienteDni;
        this.idMetodo = idMetodo;
        this.items = items;
    }

    public String getClienteDni() {
        return clienteDni;
    }

    public void setClienteDni(String clienteDni) {
        this.clienteDni = clienteDni;
    }

    public Integer getIdMetodo() {
        return idMetodo;
    }

    public void setIdMetodo(Integer idMetodo) {
        this.idMetodo = idMetodo;
    }

    public List<ItemCompra> getItems() {
        return items;
    }

    public void setItems(List<ItemCompra> items) {
        this.items = items;
    }
}