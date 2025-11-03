package com.example.DHT.DTO;

public class ItemCompra {

    private int idVariantePrenda;
    private int cantidad;

    public ItemCompra() {  }

    public ItemCompra(int idVariantePrenda, int cantidad) {
        this.idVariantePrenda = idVariantePrenda;
        this.cantidad = cantidad;
    }

    public int getIdVariantePrenda() {   return idVariantePrenda;   }
    public void setIdVariantePrenda(int idVariantePrenda) {  this.idVariantePrenda = idVariantePrenda;}
    public int getCantidad() {return cantidad;  }
    public void setCantidad(int cantidad) {
        this.cantidad = cantidad;
    }
}