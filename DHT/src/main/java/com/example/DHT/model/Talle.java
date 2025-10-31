package com.example.DHT.model;
import jakarta.persistence.*;
@Entity
@Table(name = "talle")
public class Talle {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private Integer id;

    @Column(name = "talle", length = 3)
    private String talle;

    public Talle() {}

    public Integer getId() { return id; }
    public void setId(Integer id) { this.id = id; }

    public String getTalle() { return talle; }
    public void setTalle(String talle) { this.talle = talle; }

}
