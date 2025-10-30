package com.example.DHT.DTO;

import com.example.DHT.model.CompraDetalle;

public class ItemDevolucion{

    private Integer idCompraDetalle;
    private Integer cantidadADevolver;

    public ItemDevolucion() {   }

    public Integer getIdCompraDetalle() {
        return idCompraDetalle;
    }

    public void setIdCompraDetalle(Integer idCompraDetalle) {
        this.idCompraDetalle = idCompraDetalle;
    }

    public Integer getCantidadADevolver() {
        return cantidadADevolver;
    }

    public void setCantidadADevolver(Integer cantidadADevolver) {
        this.cantidadADevolver = cantidadADevolver;
    }
}