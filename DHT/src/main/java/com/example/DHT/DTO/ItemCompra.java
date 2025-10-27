package com.example.DHT.DTO;

public class ItemCompra {

    private Integer idVariantePrenda;
    private Integer cantidad;

    public ItemCompra() {
    }

    public ItemCompra(Integer idVariantePrenda, Integer cantidad) {
        this.idVariantePrenda = idVariantePrenda;
        this.cantidad = cantidad;
    }

    public Integer getIdVariantePrenda() {
        return idVariantePrenda;
    }

    public void setIdVariantePrenda(Integer idVariantePrenda) {
        this.idVariantePrenda = idVariantePrenda;
    }

    public Integer getCantidad() {
        return cantidad;
    }

    public void setCantidad(Integer cantidad) {
        this.cantidad = cantidad;
    }
}