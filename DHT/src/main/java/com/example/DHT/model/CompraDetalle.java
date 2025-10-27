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
    private Double precioUnitario; // Precio "congelado"

    @Column(name = "porcentajeComisionAlComprar", nullable = false)
    private Float porcentajeComisionAlComprar; // Comisión "congelada"

    public CompraDetalle() {
    }

    public CompraDetalle(Compra compra, VariantePrenda variantePrenda, Integer cantidad, Double precioUnitario, Float porcentajeComisionAlComprar) {
        this.compra = compra;
        this.variantePrenda = variantePrenda;
        this.cantidad = cantidad;
        this.precioUnitario = precioUnitario;
        this.porcentajeComisionAlComprar = porcentajeComisionAlComprar;
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

    public Double getPrecioUnitarioAlComprar() {
        return precioUnitario;
    }

    public void setPrecioUnitarioAlComprar(Double precioUnitarioAlComprar) {
        this.precioUnitario = precioUnitarioAlComprar;
    }

    public Float getPorcentajeComisionAlComprar() {
        return porcentajeComisionAlComprar;
    }

    public void setPorcentajeComisionAlComprar(Float porcentajeComisionAlComprar) {
        this.porcentajeComisionAlComprar = porcentajeComisionAlComprar;
    }
}