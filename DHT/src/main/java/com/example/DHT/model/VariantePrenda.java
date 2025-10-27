package com.example.DHT.model;

import jakarta.persistence.*;

@Entity
@Table(name = "prenda_has_talleycolor")
public class VariantePrenda {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private Integer id;

    @ManyToOne
    @JoinColumn(name = "p_idPrenda")
    private Prenda prenda;

    @ManyToOne
    @JoinColumn(name = "idTalle")
    private Talle talle;

    @Column(name = "color", length = 45)
    private String color;

    @Column(name = "stock")
    private Integer stock;

    @Column(name = "stockMinimo")
    private Integer stockMinimo;

    // Constructor vacío
    public VariantePrenda() {
    }

    // Constructor con campos
    public VariantePrenda(Prenda prenda, Talle talle, String color, Integer stock, Integer stockMinimo) {
        this.prenda = prenda;
        this.talle = talle;
        this.color = color;
        this.stock = stock;
        this.stockMinimo = stockMinimo;
    }

    // Getters y Setters
    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Prenda getPrenda() {
        return prenda;
    }

    public void setPrenda(Prenda prenda) {
        this.prenda = prenda;
    }

    public Talle getTalle() {
        return talle;
    }

    public void setTalle(Talle talle) {
        this.talle = talle;
    }

    public String getColor() {
        return color;
    }

    public void setColor(String color) {
        this.color = color;
    }

    public Integer getStock() {
        return stock;
    }

    public void setStock(Integer stock) {
        this.stock = stock;
    }

    public Integer getStockMinimo() {
        return stockMinimo;
    }

    public void setStockMinimo(Integer stockMinimo) {
        this.stockMinimo = stockMinimo;
    }
}