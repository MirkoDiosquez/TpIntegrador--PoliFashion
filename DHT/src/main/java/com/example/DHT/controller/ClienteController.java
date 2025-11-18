package com.example.DHT.controller;

import com.example.DHT.DTO.ReseniaDTO;
import com.example.DHT.DTO.historial.HistorialDTO;
import com.example.DHT.model.Cliente;
import com.example.DHT.service.ClienteService;
import com.example.DHT.service.ReseniaService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/clientes")
public class ClienteController {

    @Autowired
    private ClienteService clienteService;
    @Autowired
    private ReseniaService reseniaService;

    @GetMapping("/{dni}")
    public ResponseEntity<?> getClientePorDni(@PathVariable String dni) {
        try {
            Cliente cliente = clienteService.getCliente(dni);
            cliente.setContrasenia(null); // no devolver la contraseña
            return ResponseEntity.ok(cliente);
        } catch (RuntimeException e) {
            return ResponseEntity.status(404).body(e.getMessage());
        }
    }

    @GetMapping("/{id}/historial")
    public ResponseEntity<?> getHistorialDelCliente(@PathVariable("id") String clienteDni) {
        try {
            HistorialDTO historial = clienteService.getHistorial(clienteDni);
            return ResponseEntity.ok(historial);
        }
        catch (RuntimeException e) {
            return new ResponseEntity<>(e.getMessage(), HttpStatus.NOT_FOUND);
        }
    }

    @GetMapping("/{dni}/resenias")
    public ResponseEntity<?> getReseniasDelCliente(@PathVariable String dni) {
        try {
            List<ReseniaDTO> resenias = reseniaService.getReseniasPorCliente(dni);
            return ResponseEntity.ok(resenias);
        } catch (RuntimeException e) {
            return ResponseEntity.status(404).body(e.getMessage());
        }
    }

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