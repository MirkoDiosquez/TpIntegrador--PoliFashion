package com.example.DHT.controller;

import com.example.DHT.DTO.Ranking; // DTO para el ranking
import com.example.DHT.service.PrendaService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDate; // Importar LocalDate para YYYY-MM-DD
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/api/prendas")
public class PrendaController {

    @Autowired
    private PrendaService prendaService;

    // d. Verificar stock de una prenda o modelo
    // Ruta: GET /api/prendas/disponibilidad?modeloId=ID
    @GetMapping("/disponibilidad")
    public ResponseEntity<?> verificarStock(
            @RequestParam("modeloId") Integer modeloId) {
        try {
            Map<String, Object> disponibilidad = prendaService.verificarDisponibilidad(modeloId);
            return ResponseEntity.ok(disponibilidad);
        } catch (RuntimeException e) {
            return new ResponseEntity<>(e.getMessage(), HttpStatus.NOT_FOUND);
        }
    }

    // f. Ranking de prendas más vendidas
    // Ruta: GET /api/prendas/ranking?desde=YYYY-MM-DD&hasta=YYYY-MM-DD
    @GetMapping("/ranking")
    public ResponseEntity<?> obtenerRankingPrendas(
            // Se usa LocalDate y DateTimeFormat.ISO.DATE (YYYY-MM-DD)
            @RequestParam("desde") @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate desde,
            @RequestParam("hasta") @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate hasta) {
        try {
            List<Ranking> ranking = prendaService.getRankingPrendas(desde, hasta);
            return ResponseEntity.ok(ranking);
        } catch (Exception e) {
            return new ResponseEntity<>("Error al generar el ranking: " + e.getMessage(), HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }
}