package com.example.DHT.model;
import jakarta.persistence.*;

@Entity
@Table(name = "tipo")
public class Tipo {
    @Id
    @Column(name = "idTipo")
    private Integer idTipo;

    @Column(name = "tipo", length = 45)
    private String tipo;

    public Integer getIdTipo() {
        return idTipo;
    }

    public void setIdTipo(Integer idTipo) {
        this.idTipo = idTipo;
    }

    public String getTipo() {
        return tipo;
    }

    public void setTipo(String tipo) {
        this.tipo = tipo;
    }
}
