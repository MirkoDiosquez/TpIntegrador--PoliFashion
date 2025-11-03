package com.example.DHT.DTO.historial;

import com.example.DHT.model.Devolucion;
import com.example.DHT.model.DevolucionDetalle;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

public class HistorialDevolucionDTO {
    private int idDevolucion;
    private LocalDateTime fechaDevolucion;
    private Double montoTotalReembolsado;
    private int idCompra;
    private List<ItemDevuelto> itemsDevueltos;

    public HistorialDevolucionDTO(Devolucion devolucion) {
        this.idDevolucion = devolucion.getIdDevolucion();
        this.fechaDevolucion = devolucion.getFechaHora();
        this.idCompra = devolucion.getCompra().getIdCompra();
        this.montoTotalReembolsado = devolucion.getMontoTotalReembolsado();
        this.itemsDevueltos = new ArrayList<>();
        for (DevolucionDetalle detalle : devolucion.getDetalles()){
            ItemDevuelto item = new ItemDevuelto (detalle);
            itemsDevueltos.add(item);
        }
    }

    public int getIdDevolucion() {
        return idDevolucion;
    }

    public void setIdDevolucion(int idDevolucion) {
        this.idDevolucion = idDevolucion;
    }

    public LocalDateTime getFechaDevolucion() {
        return fechaDevolucion;
    }

    public void setFechaDevolucion(LocalDateTime fechaDevolucion) {
        this.fechaDevolucion = fechaDevolucion;
    }

    public Double getMontoTotalReembolsado() {
        return montoTotalReembolsado;
    }

    public void setMontoTotalReembolsado(Double montoTotalReembolsado) {
        this.montoTotalReembolsado = montoTotalReembolsado;
    }

    public int getIdCompra() {
        return idCompra;
    }

    public void setIdCompra(int idCompra) {
        this.idCompra = idCompra;
    }

    public List<ItemDevuelto> getItemsDevueltos() {
        return itemsDevueltos;
    }

    public void setItemsDevueltos(List<ItemDevuelto> itemsDevueltos) {
        this.itemsDevueltos = itemsDevueltos;
    }
}
