package com.example.DHT.controller;

import com.example.DHT.service.ClienteService;
// ... otras importaciones
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/clientes")
public class ClienteController {

    @Autowired
    private ClienteService clienteService;
    // ...

    // g. Puntos acumulados por cliente
    // Ruta: GET /api/clientes/{id}/puntos
    @GetMapping("/{id}/puntos")
    public ResponseEntity<?> getPuntosDelCliente(@PathVariable("id") String clienteDni) {
        try {
            // Se cambia la llamada al nuevo método simplificado: obtenerPuntosCliente
            return ResponseEntity.ok(clienteService.obtenerPuntosCliente(clienteDni));
        } catch (RuntimeException e) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body(e.getMessage());
        }
    }

    // ... otros métodos (getEstadisticasMarcas, etc.)
}