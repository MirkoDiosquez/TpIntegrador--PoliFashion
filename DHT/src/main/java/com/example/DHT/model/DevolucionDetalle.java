package com.example.DHT.model;
import jakarta.persistence.*;

@Entity
@Table(name = "devolucion_detalle")
public class DevolucionDetalle {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private Integer id;

    @ManyToOne
    @JoinColumn(name = "idDevolucion")
    private Devolucion devolucion;

    @ManyToOne
    @JoinColumn(name = "idCompraDetalle")
    private CompraDetalle compraDetalle;

    @Column(name = "cantidadDevuelta", nullable = false)
    private Integer cantidadDevuelta;

    public DevolucionDetalle(Integer id, Devolucion devolucion, CompraDetalle compraDetalle, Integer cantidadDevuelta) {
        this.id = id;
        this.devolucion = devolucion;
        this.compraDetalle = compraDetalle;
        this.cantidadDevuelta = cantidadDevuelta;
    }

    public DevolucionDetalle() {
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Devolucion getDevolucion() {
        return devolucion;
    }

    public void setDevolucion(Devolucion devolucion) {
        this.devolucion = devolucion;
    }

    public CompraDetalle getCompraDetalle() {
        return compraDetalle;
    }

    public void setCompraDetalle(CompraDetalle compraDetalle) {
        this.compraDetalle = compraDetalle;
    }

    public Integer getCantidadDevuelta() {
        return cantidadDevuelta;
    }

    public void setCantidadDevuelta(Integer cantidadDevuelta) {
        this.cantidadDevuelta = cantidadDevuelta;
    }
}
