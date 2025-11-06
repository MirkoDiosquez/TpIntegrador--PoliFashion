package com.example.DHT.service;

import com.example.DHT.DTO.PrendaDTO;
import com.example.DHT.DTO.Variante;
import com.example.DHT.model.*;
import com.example.DHT.repository.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import java.util.ArrayList;
import java.util.List;

@Service
public class MarcaService {
    @Autowired
    private MarcaRepository marcaRepository;
    @Autowired
    private PrendaRepository prendaRepository;
    @Autowired
    private TelaRepository telaRepository;
    @Autowired
    private TipoRepository tipoRepository;
    @Autowired
    private TalleRepository talleRepository;

    @Transactional
    public Prenda cargarNuevaPrenda(Integer idMarca, PrendaDTO prendaNueva){
        Marca marca = marcaRepository.findById(idMarca)
                .orElseThrow(() -> new RuntimeException("Marca (proveedor) no encontrada con ID: " + idMarca));
        Tela tela = telaRepository.findById(prendaNueva.getIdTela())
                .orElseThrow(() -> new RuntimeException("Tela no encontrada con ID: " + prendaNueva.getIdTela()));
        Tipo tipo = tipoRepository.findById(prendaNueva.getIdTipo())
                .orElseThrow(() -> new RuntimeException("Tipo no encontrado con ID: " + prendaNueva.getIdTipo()));

        Prenda prenda =  new Prenda(marca, tela, tipo, prendaNueva.getNombre(), prendaNueva.getGenero(), prendaNueva.getPrecio(), prendaNueva.getDescripcion());

        List<VariantePrenda> variantesDeLaPrenda = new ArrayList<>();
        for (Variante varianteDTO : prendaNueva.getVariantes()) {
            Talle talle = talleRepository.findById(varianteDTO.getIdTalle())
                    .orElseThrow(() -> new RuntimeException("Talle no encontrado con ID: " + varianteDTO.getIdTalle()));

            VariantePrenda nuevaVariante = new VariantePrenda();
            nuevaVariante.setPrenda(prenda);
            nuevaVariante.setTalle(talle);
            nuevaVariante.setColor(varianteDTO.getColor());
            nuevaVariante.setStock(varianteDTO.getStockInicial());

            Integer stockMinimo;
            if (varianteDTO.getStockMinimo() != null){
                stockMinimo = varianteDTO.getStockMinimo();
            }
            else{
                stockMinimo = marca.getStockMinimoDefault();
            }
            nuevaVariante.setStockMinimo(stockMinimo);

            variantesDeLaPrenda.add(nuevaVariante);
        }
        prenda.setVariantes(variantesDeLaPrenda);
        return prendaRepository.save(prenda);
    }
}