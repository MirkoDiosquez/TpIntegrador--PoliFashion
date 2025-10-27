package com.example.DHT.model;
import jakarta.persistence.*;

public class Tela {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "idTela")
    private Integer id;

    @Column(name = "nombreTela", length = 50)
    private String nombreTela;
}
