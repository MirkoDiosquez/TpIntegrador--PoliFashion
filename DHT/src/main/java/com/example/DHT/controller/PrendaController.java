package com.example.DHT.controller;

import com.example.DHT.service.PrendaService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.Map;

@RestController
@RequestMapping("/api/prendas")
public class PrendaController {

    @Autowired
    private PrendaService prendaService;

    @GetMapping("/disponibilidad")
    public ResponseEntity<Map<String, Object>> verificarDisponibilidad(@RequestParam Integer modeloId) {
        try {
            Map<String, Object> respuesta = prendaService.verificarDisponibilidad(modeloId);
            return ResponseEntity.ok(respuesta);
        } catch (RuntimeException e) {
            // Si el modelo no existe o no tiene variantes, devolvemos un 404 con el mensaje
            return ResponseEntity.status(404).body(Map.of("error", e.getMessage()));
        } catch (Exception e) {
            // Errores genéricos: 500
            return ResponseEntity.status(500).body(Map.of("error", "Error interno del servidor"));
        }
    }
}
