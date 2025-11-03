package com.example.DHT.DTO;

public class Marca
{
    private int idMarca ;
    private String nombreMarca ;
    private int stockMinimo ;
    private boolean aceptaDevoluciones ;
    private float porcentajeComision ;
    private float gananciasTotales ;
    private int puntos ;

    public Marca(){}

    public Marca(int idMarca, String nombreMarca, int stockMinimo, boolean aceptaDevoluciones, float porcentajeComision, float gananciasTotales, int puntos) {
        this.idMarca = idMarca;
        this.nombreMarca = nombreMarca;
        this.stockMinimo = stockMinimo;
        this.aceptaDevoluciones = aceptaDevoluciones;
        this.porcentajeComision = porcentajeComision;
        this.gananciasTotales = gananciasTotales;
        this.puntos = puntos;
    }

    public int getIdMarca() {
        return idMarca;
    }

    public void setIdMarca(int idMarca) {
        this.idMarca = idMarca;
    }

    public int getStockMinimo() {
        return stockMinimo;
    }

    public void setStockMinimo(int stockMinimo) {
        this.stockMinimo = stockMinimo;
    }

    public String getNombreMarca() {
        return nombreMarca;
    }

    public void setNombreMarca(String nombreMarca) {
        this.nombreMarca = nombreMarca;
    }

    public boolean isAceptaDevoluciones() {
        return aceptaDevoluciones;
    }

    public void setAceptaDevoluciones(boolean aceptaDevoluciones) {
        this.aceptaDevoluciones = aceptaDevoluciones;
    }

    public float getPorcentajeComision() {
        return porcentajeComision;
    }

    public void setPorcentajeComision(float porcentajeComision) {
        this.porcentajeComision = porcentajeComision;
    }

    public float getGananciasTotales() {
        return gananciasTotales;
    }

    public void setGananciasTotales(float gananciasTotales) {
        this.gananciasTotales = gananciasTotales;
    }

    public int getPuntos() {
        return puntos;
    }

    public void setPuntos(int puntos) {
        this.puntos = puntos;
    }
}
