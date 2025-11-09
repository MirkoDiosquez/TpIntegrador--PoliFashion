package com.example.DHT.DTO;

import com.example.DHT.extras.enums.GeneroPrenda;
import com.example.DHT.model.Prenda;
import com.example.DHT.model.VariantePrenda;
import java.util.ArrayList;
import java.util.List;

public class PrendaDTO {

    private Integer idTela;
    private Integer idTipo;
    private String nombre;
    private GeneroPrenda genero;
    private Double precio;
    private String descripcion;
    private List<Variante> variantes;

    public PrendaDTO() {
        this.variantes = new ArrayList<>();
    }

    public PrendaDTO(Prenda prenda) {
        this.idTela = prenda.getTela().getId();
        this.idTipo = prenda.getTipo().getIdTipo();
        this.nombre = prenda.getNombre();
        this.genero = prenda.getGenero();
        this.precio = prenda.getPrecio();
        this.descripcion = prenda.getDescripcion();
        this.variantes = new ArrayList<>();

        for (VariantePrenda vp : prenda.getVariantes()) {
            this.variantes.add(new Variante(
                    vp.getTalle().getId(),
                    vp.getColor(),
                    vp.getStock(),
                    vp.getStockMinimo()
            ));
        }
    }

    public Integer getIdTela() {
        return idTela;
    }

    public void setIdTela(Integer idTela) {
        this.idTela = idTela;
    }

    public Integer getIdTipo() {
        return idTipo;
    }

    public void setIdTipo(Integer idTipo) {
        this.idTipo = idTipo;
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

    public List<Variante> getVariantes() {
        return variantes;
    }

    public void setVariantes(List<Variante> variantes) {
        this.variantes = variantes;
    }

    public String getDescripcion() {
        return descripcion;
    }

    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }


}