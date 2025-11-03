package com.example.DHT.DTO;

import com.example.DHT.model.Compra;
import com.example.DHT.model.CompraDetalle;

import java.util.ArrayList;
import java.util.List;

public class CompraDTO {

    private String clienteDni;
    private Integer idMetodo;
    private List<ItemCompra> items;

    public CompraDTO() {
    }

    public CompraDTO(Compra compraGuardada) {
        this.clienteDni = compraGuardada.getCliente().getDni();
        this.idMetodo = compraGuardada.getMetodoPago().getIdMetodo();
        this.items = new ArrayList<>();
        for (CompraDetalle detalle : compraGuardada.getDetalles()){
            ItemCompra item = new ItemCompra(detalle.getVariantePrenda().getId(), detalle.getCantidad());
            this.items.add(item);
        }
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