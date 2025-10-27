package com.example.DHT.DTO;

public class VarianteStock {

    private Integer idVariante;
    private String talle;
    private String color;
    private Integer stockDisponible;
    private boolean porDebajoDelMinimo;

    public VarianteStock() {
    }

    public VarianteStock(Integer idVariante, String talle, String color, Integer stockDisponible, boolean porDebajoDelMinimo) {
        this.idVariante = idVariante;
        this.talle = talle;
        this.color = color;
        this.stockDisponible = stockDisponible;
        this.porDebajoDelMinimo = porDebajoDelMinimo;
    }

    public Integer getIdVariante() {
        return idVariante;
    }

    public void setIdVariante(Integer idVariante) {
        this.idVariante = idVariante;
    }

    public String getTalle() {
        return talle;
    }

    public void setTalle(String talle) {
        this.talle = talle;
    }

    public String getColor() {
        return color;
    }

    public void setColor(String color) {
        this.color = color;
    }

    public Integer getStockDisponible() {
        return stockDisponible;
    }

    public void setStockDisponible(Integer stockDisponible) {
        this.stockDisponible = stockDisponible;
    }

    public boolean isPorDebajoDelMinimo() {
        return porDebajoDelMinimo;
    }

    public void setPorDebajoDelMinimo(boolean porDebajoDelMinimo) {
        this.porDebajoDelMinimo = porDebajoDelMinimo;
    }
}