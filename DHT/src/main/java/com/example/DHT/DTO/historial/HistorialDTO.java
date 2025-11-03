package com.example.DHT.DTO.historial;

import java.util.ArrayList;
import java.util.List;

public class HistorialDTO {
    private List<HistorialCompraDTO> compras;
    private List<HistorialDevolucionDTO> devoluciones;

    public HistorialDTO(List<HistorialCompraDTO> compras, List<HistorialDevolucionDTO> devoluciones) {
        this.compras = compras;
        this.devoluciones = devoluciones;
    }

    public HistorialDTO() {
        this.compras = new ArrayList<>();
        this.devoluciones = new ArrayList<>();
    }

    public List<HistorialCompraDTO> getCompras() {
        return compras;
    }
    public void setCompras(List<HistorialCompraDTO> compras) {
        this.compras = compras;
    }
    public List<HistorialDevolucionDTO> getDevoluciones() {
        return devoluciones;
    }
    public void setDevoluciones(List<HistorialDevolucionDTO> devoluciones) {
        this.devoluciones = devoluciones;
    }
}