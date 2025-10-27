package com.example.DHT.DTO;

public class Variante {

    private Integer idTalle;
    private String color;
    private Integer stockInicial;
    private Integer stockMinimo; // se podría usar el de marca

    public Variante() {
    }

    // Constructor con campos
    public Variante(Integer idTalle, String color, Integer stockInicial, Integer stockMinimo) {
        this.idTalle = idTalle;
        this.color = color;
        this.stockInicial = stockInicial;
        this.stockMinimo = stockMinimo;
    }

    public Integer getIdTalle() {
        return idTalle;
    }

    public void setIdTalle(Integer idTalle) {
        this.idTalle = idTalle;
    }

    public String getColor() {
        return color;
    }

    public void setColor(String color) {
        this.color = color;
    }

    public Integer getStockInicial() {
        return stockInicial;
    }

    public void setStockInicial(Integer stockInicial) {
        this.stockInicial = stockInicial;
    }

    public Integer getStockMinimo() {
        return stockMinimo;
    }

    public void setStockMinimo(Integer stockMinimo) {
        this.stockMinimo = stockMinimo;
    }
}