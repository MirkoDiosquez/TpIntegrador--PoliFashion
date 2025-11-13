package com.example.DHT.controller;

import com.example.DHT.repository.CompraRepository;
import com.example.DHT.model.Compra;
import com.example.DHT.model.CompraDetalle;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDateTime;
import java.util.*;
import java.util.stream.Collectors;

@RestController
@RequestMapping("/api/prendas")
public class PrendaController {

    @Autowired
    private CompraRepository compraRepository;

    @GetMapping("/ranking")
    public List<Map<String, Object>> obtenerRankingPrendas(
            @RequestParam("desde") @DateTimeFormat(iso = DateTimeFormat.ISO.DATE_TIME) LocalDateTime desde,
            @RequestParam("hasta") @DateTimeFormat(iso = DateTimeFormat.ISO.DATE_TIME) LocalDateTime hasta) {

        List<Compra> compras = compraRepository.findAll();

        // Filtramos las compras por fecha
        List<CompraDetalle> detallesEnRango = compras.stream()
                .filter(c -> c.getDatetimeCompra().isAfter(desde) && c.getDatetimeCompra().isBefore(hasta))
                .flatMap(c -> c.getDetalles().stream())
                .collect(Collectors.toList());

        // Contamos cantidad vendida por prenda
        Map<String, Integer> contador = new HashMap<>();

        for (CompraDetalle detalle : detallesEnRango) {
            String nombrePrenda = detalle.getVariantePrenda().getPrenda().getNombre();
            contador.put(nombrePrenda, contador.getOrDefault(nombrePrenda, 0) + detalle.getCantidad());
        }

        // Convertimos a lista ordenada por cantidad descendente
        return contador.entrySet().stream()
                .sorted(Map.Entry.<String, Integer>comparingByValue().reversed())
                .limit(10)
                .map(entry -> {
                    Map<String, Object> fila = new HashMap<>();
                    fila.put("prenda", entry.getKey());
                    fila.put("cantidadVendida", entry.getValue());
                    return fila;
                })
                .collect(Collectors.toList());
    }
}
