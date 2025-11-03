package com.example.DHT.controller;
import com.example.DHT.DTO.historial.HistorialDTO;
import com.example.DHT.service.ClienteService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/cliente")
public class ClienteController {
    @Autowired
    private ClienteService clienteService;

    @GetMapping("/{id}/historial")
    public ResponseEntity<?> getHistorialDelCliente(@PathVariable("id") String clienteDni) {
        HistorialDTO historial = clienteService.getHistorial(clienteDni);
        return ResponseEntity.ok(historial);
    }


}
