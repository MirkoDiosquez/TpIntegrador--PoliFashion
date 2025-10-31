package com.example.DHT.model;

import jakarta.persistence.*;

@Entity
@Table(name = "metodopago")
public class MetodoPago {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "idMetodo")
    private Integer idMetodo;

    @Column(name = "nombreMetodo", nullable = false, length = 50)
    private String nombreMetodo;

    public MetodoPago() { }

    public MetodoPago(String nombreMetodo) {
        this.nombreMetodo = nombreMetodo;
    }

    public Integer getIdMetodo() {
        return idMetodo;
    }

    public void setIdMetodo(Integer idMetodo) {
        this.idMetodo = idMetodo;
    }

    public String getNombreMetodo() {
        return nombreMetodo;
    }

    public void setNombreMetodo(String nombreMetodo) {
        this.nombreMetodo = nombreMetodo;
    }
}