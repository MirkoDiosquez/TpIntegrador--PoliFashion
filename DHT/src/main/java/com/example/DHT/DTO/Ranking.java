package com.example.DHT.DTO;

public class Ranking {

    private String nombrePrenda;
    private Long cantidadVendida;
    private Double ingresosGenerados;

    public Ranking() {
    }

    public Ranking(String nombrePrenda, Long cantidadVendida, Double ingresosGenerados) {
        this.nombrePrenda = nombrePrenda;
        this.cantidadVendida = cantidadVendida;
        this.ingresosGenerados = ingresosGenerados;
    }

    // Getters y Setters
    public String getNombrePrenda() {
        return nombrePrenda;
    }

    public void setNombrePrenda(String nombrePrenda) {
        this.nombrePrenda = nombrePrenda;
    }

    public Long getCantidadVendida() {
        return cantidadVendida;
    }

    public void setCantidadVendida(Long cantidadVendida) {
        this.cantidadVendida = cantidadVendida;
    }

    public Double getIngresosGenerados() {
        return ingresosGenerados;
    }

    public void setIngresosGenerados(Double ingresosGenerados) {
        this.ingresosGenerados = ingresosGenerados;
    }
}