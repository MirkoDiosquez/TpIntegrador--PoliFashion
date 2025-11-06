package com.example.DHT.service;

import com.example.DHT.model.VariantePrenda;
import com.example.DHT.repository.VariantePrendaRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class PrendaService {

    @Autowired
    private VariantePrendaRepository variantePrendaRepository;

    @Transactional(readOnly = true)
    public Map<String, Object> verificarDisponibilidad(Integer modeloId)
    {

        // obtengo todas las variantes asociadas a la prenda (modelo)
        List<VariantePrenda> variantes = variantePrendaRepository.findByPrenda_IdPrenda(modeloId);

        if (variantes.isEmpty()) {
            throw new RuntimeException("No se encontraron variantes para el modelo con ID " + modeloId);
        }
        // calcular stock total y mínimo total
        int stockTotal = 0;
        int stockMinimoTotal = 0;
        for (VariantePrenda variante : variantes) {
            stockTotal += variante.getStock();
            stockMinimoTotal += variante.getStockMinimo();
        }
        boolean porDebajoDelMinimo = stockTotal < stockMinimoTotal;

        // Usamos datos comunes de la prenda base
        String nombrePrenda = variantes.get(0).getPrenda().getNombre();
        String marca = variantes.get(0).getPrenda().getMarca().getNombreMarca();

        Map<String, Object> respuesta = new HashMap<>();
        respuesta.put("modeloId", modeloId);
        respuesta.put("nombrePrenda", nombrePrenda);
        respuesta.put("marca", marca);
        respuesta.put("stockTotal", stockTotal);
        respuesta.put("stockMinimoTotal", stockMinimoTotal);
        respuesta.put("porDebajoDelMinimo", porDebajoDelMinimo);

        return respuesta;
    }
}
