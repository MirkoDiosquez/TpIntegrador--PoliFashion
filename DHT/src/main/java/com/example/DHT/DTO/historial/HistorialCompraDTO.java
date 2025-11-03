package com.example.DHT.DTO.historial;

import com.example.DHT.model.Compra;

import java.time.LocalDateTime;
import java.util.List;
import java.util.stream.Collectors;

public class HistorialCompraDTO {
    private int idCompra;
    private LocalDateTime fechaCompra;
    private Double costoTotal;
    private String metodoPago;
    private List<ItemComprado> itemsComprados;

    public HistorialCompraDTO(Compra compra) {
        this.idCompra = compra.getIdCompra();
        this.fechaCompra = compra.getDatetimeCompra();
        this.costoTotal = compra.getCostoTotal();
        this.metodoPago = compra.getMetodoPago().getNombreMetodo();
        this.itemsComprados = compra.getDetalles().stream().map(ItemComprado::new).collect(Collectors.toList());
    }

    public int getIdCompra() { return idCompra; }
    public void setIdCompra(int idCompra) { this.idCompra = idCompra; }
    public LocalDateTime getFechaCompra() { return fechaCompra; }
    public void setFechaCompra(LocalDateTime fechaCompra) { this.fechaCompra = fechaCompra;}
    public Double getCostoTotal() { return costoTotal; }
    public void setCostoTotal(Double costoTotal) {  this.costoTotal = costoTotal;  }
    public String getMetodoPago() {   return metodoPago;  }
    public void setMetodoPago(String metodoPago) {  this.metodoPago = metodoPago; }
    public List<ItemComprado> getItemsComprados() { return itemsComprados;  }
    public void setItemsComprados(List<ItemComprado> itemsComprados) {  this.itemsComprados = itemsComprados;  }
}
