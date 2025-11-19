package com.example.DHT.service;

import com.example.DHT.DTO.PrendaDTO;
import com.example.DHT.DTO.Ranking;
import com.example.DHT.model.CompraDetalle;
import com.example.DHT.model.VariantePrenda;
import com.example.DHT.repository.CompraDetalleRepository;
import com.example.DHT.repository.PrendaRepository;
import com.example.DHT.repository.VariantePrendaRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.Comparator;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@Service
public class PrendaService {
    @Autowired
    private PrendaRepository prendaRepository;

    @Autowired
    private VariantePrendaRepository variantePrendaRepository;

    @Autowired // Necesario para el ranking
    private CompraDetalleRepository compraDetalleRepository;

    // d. Verificar stock de una prenda o modelo
    @Transactional(readOnly = true)
    public Map<String, Object> verificarDisponibilidad(Integer modeloId) {

        List<VariantePrenda> variantes = variantePrendaRepository.findByPrenda_IdPrenda(modeloId);

        if (variantes.isEmpty()) {
            throw new RuntimeException("No se encontraron variantes para el modelo con ID " + modeloId);
        }

        int stockTotal = variantes.stream().mapToInt(VariantePrenda::getStock).sum();
        int stockMinimoTotal = variantes.stream().mapToInt(VariantePrenda::getStockMinimo).sum();

        boolean porDebajoDelMinimo = stockTotal < stockMinimoTotal;

        // Se asume que la entidad Prenda tiene los métodos getNombre() y getMarca().getNombreMarca()
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

    // f. Ranking de prendas más vendidas
    @Transactional(readOnly = true)
    public List<Ranking> getRankingPrendas(LocalDate desde, LocalDate hasta) {

        // El ranking se realiza desde el inicio del día 'desde' hasta el final del día 'hasta'.
        LocalDateTime start = desde.atStartOfDay();
        LocalDateTime end = hasta.atTime(23, 59, 59);

        List<CompraDetalle> detalles = compraDetalleRepository.findByCompra_DatetimeCompraBetween(start, end);

        Map<String, Ranking> rankingMap = detalles.stream()
                .collect(Collectors.groupingBy(
                        detalle -> detalle.getVariantePrenda().getPrenda().getNombre(),
                        Collectors.collectingAndThen(
                                Collectors.toList(),
                                list -> {
                                    long cantidadVendida = list.stream().mapToLong(CompraDetalle::getCantidad).sum();

                                    // Ganancias = Suma de (cantidad vendida * precio unitario)
                                    double ingresosGenerados = list.stream()
                                            .mapToDouble(d -> d.getCantidad() * d.getPrecioUnitario())
                                            .sum();

                                    return new Ranking(
                                            list.get(0).getVariantePrenda().getPrenda().getNombre(),
                                            cantidadVendida,
                                            ingresosGenerados
                                    );
                                }
                        )
                ));

        // 2. Ordenar por cantidad vendida (descendente) y limitar a 10
        return rankingMap.values().stream()
                .sorted(Comparator.comparing(Ranking::getCantidadVendida).reversed())
                .limit(10)
                .collect(Collectors.toList());
    }

    public List<PrendaDTO> getUltimasPrendas() {
        return prendaRepository.findTop3ByOrderByIdPrendaDesc().stream()
                .map(PrendaDTO::new)
                .collect(Collectors.toList());
    }
}