package com.example.DHT.model;

import jakarta.persistence.*;

@Entity
@Table(name = "marca")
public class Marca {

    @Id
    @Column(name = "idMarca")
    private Integer idMarca;

    @Column(name = "nombreMarca", nullable = false, length = 100)
    private String nombreMarca;

    @Column(name = "stockMinimoDefault")
    private Integer stockMinimoDefault;

    @Column(name = "porcentajeComision")
    private Float porcentajeComision;

    @Column(name = "gananciasTotales")
    private Float gananciasTotales;

    @Column(name = "puntos")
    private Integer puntos;

    @Column(name = "ventasMinimasParaDevolucion")
    private Integer ventasMinimasParaDevolucion;

    @Column(name = "cantidadVentasTotales")
    private Integer cantidadVentasTotales;

    public Marca() {  }

    public Marca(Integer idMarca, String nombreMarca, Integer stockMinimoDefault, Float porcentajeComision, Float gananciasTotales, Integer puntos, Integer ventasMinimasParaDevolucion, Integer cantidadVentasTotales) {
        this.idMarca = idMarca;
        this.nombreMarca = nombreMarca;
        this.stockMinimoDefault = stockMinimoDefault;
        this.porcentajeComision = porcentajeComision;
        this.gananciasTotales = gananciasTotales;
        this.puntos = puntos;
        this.ventasMinimasParaDevolucion = ventasMinimasParaDevolucion;
        this.cantidadVentasTotales = cantidadVentasTotales;
    }

    public Integer getIdMarca() {
        return idMarca;
    }

    public void setIdMarca(Integer idMarca) {
        this.idMarca = idMarca;
    }

    public String getNombreMarca() {
        return nombreMarca;
    }

    public void setNombreMarca(String nombreMarca) {
        this.nombreMarca = nombreMarca;
    }

    public Integer getStockMinimoDefault() {
        return stockMinimoDefault;
    }

    public void setStockMinimoDefault(Integer stockMinimoDefault) {
        this.stockMinimoDefault = stockMinimoDefault;
    }

    public Float getPorcentajeComision() {
        return porcentajeComision;
    }

    public void setPorcentajeComision(Float porcentajeComision) {
        this.porcentajeComision = porcentajeComision;
    }

    public Float getGananciasTotales() {
        return gananciasTotales;
    }

    public void setGananciasTotales(Float gananciasTotales) {
        this.gananciasTotales = gananciasTotales;
    }

    public Integer getPuntos() {
        return puntos;
    }

    public void setPuntos(Integer puntos) {
        this.puntos = puntos;
    }

    public Integer getVentasMinimasParaDevolucion() {
        return ventasMinimasParaDevolucion;
    }

    public void setVentasMinimasParaDevolucion(Integer ventasMinimasParaDevolucion) {
        this.ventasMinimasParaDevolucion = ventasMinimasParaDevolucion;
    }

    public Integer getCantidadVentasTotales() {
        return cantidadVentasTotales;
    }

    public void setCantidadVentasTotales(Integer cantidadVentasTotales) {
        this.cantidadVentasTotales = cantidadVentasTotales;
    }

    public boolean puedeDevolver(){
        return cantidadVentasTotales >= ventasMinimasParaDevolucion;
    }
}