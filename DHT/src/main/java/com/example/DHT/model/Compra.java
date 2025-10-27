package com.example.DHT.model;

import jakarta.persistence.*;
import java.time.LocalDateTime;
import java.util.List;

@Entity
@Table(name = "compra")
public class Compra {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "idCompra")
    private Integer idCompra;

    @ManyToOne
    @JoinColumn(name = "clienteDni", nullable = false)
    private Cliente cliente;

    @Column(name = "datetimeCompra", nullable = false)
    private LocalDateTime datetimeCompra;

    @ManyToOne
    @JoinColumn(name = "idMetodo", nullable = false)
    private MetodoPago metodoPago;

    @Column(name = "costoTotal", nullable = false)
    private Double costoTotal;

    // "mappedBy = 'compra'" le dice a JPA que la entidad CompraDetalle q tiene un campo llamado 'compra' que maneja esta relación.
    // "cascade = CascadeType.ALL" si guardas/borras una Compra también se guardarán/borrarán sus detalles.
    @OneToMany(mappedBy = "compra", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    private List<CompraDetalle> detalles;


    public Compra() {
    }

    public Compra(Cliente cliente, LocalDateTime datetimeCompra, MetodoPago metodoPago, Double costoTotal) {
        this.cliente = cliente;
        this.datetimeCompra = datetimeCompra;
        this.metodoPago = metodoPago;
        this.costoTotal = costoTotal;
    }

    public Integer getIdCompra() {
        return idCompra;
    }

    public void setIdCompra(Integer idCompra) {
        this.idCompra = idCompra;
    }

    public Cliente getCliente() {
        return cliente;
    }

    public void setCliente(Cliente cliente) {
        this.cliente = cliente;
    }

    public LocalDateTime getDatetimeCompra() {
        return datetimeCompra;
    }

    public void setDatetimeCompra(LocalDateTime datetimeCompra) {
        this.datetimeCompra = datetimeCompra;
    }

    public MetodoPago getMetodoPago() {
        return metodoPago;
    }

    public void setMetodoPago(MetodoPago metodoPago) {
        this.metodoPago = metodoPago;
    }

    public Double getCostoTotal() {
        return costoTotal;
    }

    public void setCostoTotal(Double costoTotal) {
        this.costoTotal = costoTotal;
    }

    public List<CompraDetalle> getDetalles() {
        return detalles;
    }

    public void setDetalles(List<CompraDetalle> detalles) {
        this.detalles = detalles;
    }
}