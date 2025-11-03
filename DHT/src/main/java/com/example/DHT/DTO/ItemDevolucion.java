package com.example.DHT.DTO;

import com.example.DHT.model.CompraDetalle;

public class ItemDevolucion{

    private int idCompraDetalle;
    private int cantidadADevolver;

    public ItemDevolucion() {   }
    public int getIdCompraDetalle() {
        return idCompraDetalle;
    }
    public void setIdCompraDetalle(int idCompraDetalle) {
        this.idCompraDetalle = idCompraDetalle;
    }
    public int getCantidadADevolver() {
        return cantidadADevolver;
    }
    public void setCantidadADevolver(int cantidadADevolver) {
        this.cantidadADevolver = cantidadADevolver;
    }
}