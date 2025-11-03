package com.example.DHT.model;

import jakarta.persistence.*;

@Entity
@Table(name = "compra_detalle")
public class CompraDetalle {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private Integer id;

    @ManyToOne
    @JoinColumn(name = "idCompra")
    private Compra compra;

    @ManyToOne
    @JoinColumn(name = "idVariantePrenda")
    private VariantePrenda variantePrenda;

    @Column(name = "cantidad", nullable = false)
    private Integer cantidad;

    @Column(name = "precioUnitario", nullable = false)
    private Double precioUnitario;

    @Column(name = "porcentajeComision", nullable = false)
    private Float porcentajeComision;

    public CompraDetalle() {
    }

    public CompraDetalle(Compra compra, VariantePrenda variantePrenda, Integer cantidad, Double precioUnitario, Float porcentajeComisionAlComprar) {
        this.compra = compra;
        this.variantePrenda = variantePrenda;
        this.cantidad = cantidad;
        this.precioUnitario = precioUnitario;
        this.porcentajeComision = porcentajeComision;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Compra getCompra() {
        return compra;
    }

    public void setCompra(Compra compra) {
        this.compra = compra;
    }

    public VariantePrenda getVariantePrenda() {
        return variantePrenda;
    }

    public void setVariantePrenda(VariantePrenda variantePrenda) {
        this.variantePrenda = variantePrenda;
    }

    public Integer getCantidad() {
        return cantidad;
    }

    public void setCantidad(Integer cantidad) {
        this.cantidad = cantidad;
    }

    public Double getPrecioUnitario() {
        return precioUnitario;
    }

    public void setPrecioUnitario(Double precioUnitario) {
        this.precioUnitario = precioUnitario;
    }

    public Float getPorcentajeComision() {
        return porcentajeComision;
    }

    public void setPorcentajeComision(Float porcentajeComision) {
        this.porcentajeComision = porcentajeComision;
    }
}