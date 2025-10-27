package com.example.DHT.model;
import jakarta.persistence.*;

public class Tipo {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "idTipo")
    private Integer idTipo;

    @Column(name = "tipo", length = 45)
    private String tipo;
}
