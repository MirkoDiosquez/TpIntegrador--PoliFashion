package com.example.DHT.model;
import jakarta.persistence.*;

@Entity
@Table(name = "tela")
public class Tela {
    @Id
    @Column(name = "idTela")
    private Integer id;

    @Column(name = "nombreTela", length = 50)
    private String nombreTela;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getNombreTela() {
        return nombreTela;
    }

    public void setNombreTela(String nombreTela) {
        this.nombreTela = nombreTela;
    }
}
