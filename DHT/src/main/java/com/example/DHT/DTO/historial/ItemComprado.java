package com.example.DHT.DTO.historial;

import com.example.DHT.model.CompraDetalle;

public class ItemComprado {
    private String nombreVariantePrenda;
    private int cantidad;
    private String nombreMarca;
    private double precioUnit;
    private String fotoPrincipal;

    public ItemComprado(){}
    public ItemComprado(CompraDetalle compraDetalle) {
        this.nombreVariantePrenda = compraDetalle.getVariantePrenda().getPrenda().getNombre();
        this.cantidad = compraDetalle.getCantidad();
        this.nombreMarca = compraDetalle.getVariantePrenda().getPrenda().getMarca().getNombreMarca();
        this.precioUnit = compraDetalle.getPrecioUnitario();
        this.fotoPrincipal = compraDetalle.getVariantePrenda().getPrenda().getFotoPrincipal();
    }

    public String getNombreVariantePrenda() {
        return nombreVariantePrenda;
    }

    public void setNombreVariantePrenda(String nombreVariantePrenda) {
        this.nombreVariantePrenda = nombreVariantePrenda;
    }

    public int getCantidad() {
        return cantidad;
    }

    public void setCantidad(int cantidad) {
        this.cantidad = cantidad;
    }

    public String getNombreMarca() {
        return nombreMarca;
    }

    public void setNombreMarca(String nombreMarca) {
        this.nombreMarca = nombreMarca;
    }

    public double getPrecioUnit() {
        return precioUnit;
    }

    public void setPrecioUnit(double precioUnit) {
        this.precioUnit = precioUnit;
    }

    public String getFotoPrincipal() {
        return fotoPrincipal;
    }

    public void setFotoPrincipal(String fotoPrincipal) {
        this.fotoPrincipal = fotoPrincipal;
    }
}
