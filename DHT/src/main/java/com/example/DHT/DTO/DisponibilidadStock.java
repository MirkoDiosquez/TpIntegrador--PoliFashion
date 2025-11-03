package com.example.DHT.DTO;

import java.util.List;

public class DisponibilidadStock {

    private Integer modeloId;
    private String nombreModelo;
    private List<VarianteStock> variantes;

    public DisponibilidadStock() {
    }

    public Integer getModeloId() {
        return modeloId;
    }

    public void setModeloId(Integer modeloId) {
        this.modeloId = modeloId;
    }

    public String getNombreModelo() {
        return nombreModelo;
    }

    public void setNombreModelo(String nombreModelo) {
        this.nombreModelo = nombreModelo;
    }

    public List<VarianteStock> getVariantes() {
        return variantes;
    }

    public void setVariantes(List<VarianteStock> variantes) {
        this.variantes = variantes;
    }

}