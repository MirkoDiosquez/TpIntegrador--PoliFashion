package com.example.DHT.model;
import jakarta.persistence.*;

public class Talle {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private Integer id;

    @Column(name = "talle", length = 3)
    private String talle;
}
