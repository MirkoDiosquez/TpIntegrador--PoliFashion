package com.example.DHT.model;

import jakarta.persistence.*;
import java.time.LocalDate;

@Entity
@Table(name = "resenia")
public class Resenia {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "idResenia")
    private Integer idResenia;

    @ManyToOne
    @JoinColumn(name = "dniCliente", nullable = false)
    private Cliente cliente;

    @ManyToOne
    @JoinColumn(name = "idPrenda", nullable = false)
    private Prenda prenda; // La reseña es sobre el *modelo* de prenda

    @Column(name = "comentario", columnDefinition = "TEXT")
    private String comentario;

    @Column(name = "estrellas")
    private Integer estrellas;

    @Column(name = "fecha", nullable = false)
    private LocalDate fecha;

    // Constructor vacío
    public Resenia() {
    }

    // Constructor con campos
    public Resenia(Cliente cliente, Prenda prenda, String comentario, Integer estrellas, LocalDate fecha) {
        this.cliente = cliente;
        this.prenda = prenda;
        this.comentario = comentario;
        this.estrellas = estrellas;
        this.fecha = fecha;
    }

    // Getters y Setters
    public Integer getIdResenia() {
        return idResenia;
    }

    public void setIdResenia(Integer idResenia) {
        this.idResenia = idResenia;
    }

    public Cliente getCliente() {
        return cliente;
    }

    public void setCliente(Cliente cliente) {
        this.cliente = cliente;
    }

    public Prenda getPrenda() {
        return prenda;
    }

    public void setPrenda(Prenda prenda) {
        this.prenda = prenda;
    }

    public String getComentario() {
        return comentario;
    }

    public void setComentario(String comentario) {
        this.comentario = comentario;
    }

    public Integer getEstrellas() {
        return estrellas;
    }

    public void setEstrellas(Integer estrellas) {
        this.estrellas = estrellas;
    }

    public LocalDate getFecha() {
        return fecha;
    }

    public void setFecha(LocalDate fecha) {
        this.fecha = fecha;
    }
}