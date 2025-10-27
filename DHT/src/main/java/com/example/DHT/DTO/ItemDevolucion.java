package com.example.DHT.DTO;

public class ItemDevolucion{

    private Integer idCompraDetalle;
    private Integer cantidadADevolver;

    public ItemDevolucion() {
    }

    public ItemDevolucion(Integer idCompraDetalleOriginal, Integer cantidadADevolver) {
        this.idCompraDetalle = idCompraDetalleOriginal;
        this.cantidadADevolver = cantidadADevolver;
    }

    public Integer getIdCompraDetalle() {
        return idCompraDetalle;
    }

    public void setIdCompraDetalle(Integer idCompraDetalleOriginal) {
        this.idCompraDetalle = idCompraDetalleOriginal;
    }

    public Integer getCantidadADevolver() {
        return cantidadADevolver;
    }

    public void setCantidadADevolver(Integer cantidadADevolver) {
        this.cantidadADevolver = cantidadADevolver;
    }
}