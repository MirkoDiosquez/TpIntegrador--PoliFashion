package com.example.DHT.model;
import jakarta.persistence.*;

import java.time.LocalDateTime;
import java.util.List;

@Entity
@Table(name = "devolucion")
public class Devolucion {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "idDevolucion")
    private Integer idDevolucion;

    @JoinColumn(name = "idCompra", nullable = false)
    private Compra compra;

    @JoinColumn(name = "dniCliente", nullable = false)
    private Cliente cliente;

    @Column(name = "fechaHora", nullable = false)
    private LocalDateTime fechaHora;

    @Column(name = "montoTotalReembolsado", nullable = false)
    private Double montoTotalReembolsado;

    public Devolucion(Integer idDevolucion, Compra compra, Cliente cliente, LocalDateTime fechaHora, Double montoTotalReembolsado) {
        this.idDevolucion = idDevolucion;
        this.compra = compra;
        this.cliente = cliente;
        this.fechaHora = fechaHora;
        this.montoTotalReembolsado = montoTotalReembolsado;
    }

    public Devolucion() {
    }

    public Integer getIdDevolucion() {
        return idDevolucion;
    }

    public void setIdDevolucion(Integer idDevolucion) {
        this.idDevolucion = idDevolucion;
    }

    public Compra getCompra() {
        return compra;
    }

    public void setCompra(Compra compra) {
        this.compra = compra;
    }

    public Cliente getCliente() {
        return cliente;
    }

    public void setCliente(Cliente cliente) {
        this.cliente = cliente;
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
}
