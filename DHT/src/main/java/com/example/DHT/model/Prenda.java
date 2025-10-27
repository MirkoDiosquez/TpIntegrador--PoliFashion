package com.example.DHT.model;

import com.example.DHT.DTO.GeneroPrenda; // O donde tengas tu enum
import jakarta.persistence.*;

@Entity
@Table(name = "prenda")
public class Prenda {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "idPrenda")
    private Integer idPrenda;

    @ManyToOne
    @JoinColumn(name = "idMarca", nullable = false)
    private Marca marca;

    @ManyToOne
    @JoinColumn(name = "idTela", nullable = false)
    private Tela tela;

    @ManyToOne
    @JoinColumn(name = "idTipo", nullable = false)
    private Tipo tipo;

    @Column(name = "nombre", length = 45)
    private String nombre;

    @Enumerated(EnumType.STRING)
    @Column(name = "genero", nullable = false)
    private GeneroPrenda genero;

    @Column(name = "precio", nullable = false)
    private Double precio;

    @Column(name = "descripcion", columnDefinition = "TEXT")
    private String descripcion;

    public Prenda() {
    }

    public Prenda(Marca marca, Tela tela, Tipo tipo, String nombre, GeneroPrenda genero, Double precio, String descripcion) {
        this.marca = marca;
        this.tela = tela;
        this.tipo = tipo;
        this.nombre = nombre;
        this.genero = genero;
        this.precio = precio;
        this.descripcion = descripcion;
    }

    public Integer getIdPrenda() {
        return idPrenda;
    }

    public void setIdPrenda(Integer idPrenda) {
        this.idPrenda = idPrenda;
    }

    public Marca getMarca() {
        return marca;
    }

    public void setMarca(Marca marca) {
        this.marca = marca;
    }

    public Tela getTela() {
        return tela;
    }

    public void setTela(Tela tela) {
        this.tela = tela;
    }

    public Tipo getTipo() {
        return tipo;
    }

    public void setTipo(Tipo tipo) {
        this.tipo = tipo;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public GeneroPrenda getGenero() {
        return genero;
    }

    public void setGenero(GeneroPrenda genero) {
        this.genero = genero;
    }

    public Double getPrecio() {
        return precio;
    }

    public void setPrecio(Double precio) {
        this.precio = precio;
    }

    public String getDescripcion() {
        return descripcion;
    }

    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }
}