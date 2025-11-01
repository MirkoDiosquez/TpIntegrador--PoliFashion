package com.example.DHT.DTO;

import java.time.LocalDateTime;
import java.util.List;
import java.util.stream.Collectors;
import com.example.DHT.model.Devolucion;

public class DevolucionRespDTO {

    private Integer idDevolucion;
    private LocalDateTime fechaHora;
    private Double montoTotalReembolsado;
    private String clienteDni;
    private Integer idCompraOriginal;

    public DevolucionRespDTO() {}

    public DevolucionRespDTO(Devolucion devolucion) {
        this.idDevolucion = devolucion.getIdDevolucion();
        this.fechaHora = devolucion.getFechaHora();
        this.montoTotalReembolsado = devolucion.getMontoTotalReembolsado();
        this.clienteDni = devolucion.getCliente().getDni();
        this.idCompraOriginal = devolucion.getCompra().getIdCompra();
    }

    public Integer getIdDevolucion() {
        return idDevolucion;
    }

    public void setIdDevolucion(Integer idDevolucion) {
        this.idDevolucion = idDevolucion;
    }

    public LocalDateTime getFechaHora() {
        return fechaHora;
    }

    public void setFechaHora(LocalDateTime fechaHora) {
        this.fechaHora = fechaHora;
    }

    public Double getMontoTotalReembolsado() {
        return montoTotalReembolsado;
    }

    public void setMontoTotalReembolsado(Double montoTotalReembolsado) {
        this.montoTotalReembolsado = montoTotalReembolsado;
    }

    public String getClienteDni() {
        return clienteDni;
    }

    public void setClienteDni(String clienteDni) {
        this.clienteDni = clienteDni;
    }

    public Integer getIdCompraOriginal() {
        return idCompraOriginal;
    }

    public void setIdCompraOriginal(Integer idCompraOriginal) {
        this.idCompraOriginal = idCompraOriginal;
    }

}