package com.example.DHT.DTO.historial;

import com.example.DHT.model.*;

public class ItemDevuelto {
    private String nombrePrenda;
    private String nombreMarca;
    private int cantDevuelta;

    public ItemDevuelto(){}
    public ItemDevuelto(DevolucionDetalle detalleDevolucion) {
        this.nombrePrenda = detalleDevolucion.getCompraDetalle().getVariantePrenda().getPrenda().getNombre();
        this.nombreMarca = detalleDevolucion.getCompraDetalle().getVariantePrenda().getPrenda().getMarca().getNombreMarca();
        this.cantDevuelta = detalleDevolucion.getCantidadDevuelta();
    }

    public String getNombrePrenda() {
        return nombrePrenda;
    }

    public void setNombrePrenda(String nombrePrenda) {
        this.nombrePrenda = nombrePrenda;
    }

    public String getNombreMarca() {
        return nombreMarca;
    }

    public void setNombreMarca(String nombreMarca) {
        this.nombreMarca = nombreMarca;
    }

    public int getCantDevuelta() {
        return cantDevuelta;
    }

    public void setCantDevuelta(int cantDevuelta) {
        this.cantDevuelta = cantDevuelta;
    }
}
