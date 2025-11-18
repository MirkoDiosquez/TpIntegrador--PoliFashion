package com.example.DHT.controller;

import com.example.DHT.DTO.ReseniaDTO;
import com.example.DHT.service.ReseniaService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("/api/resenias")
@CrossOrigin(origins = "*")
public class ReseniaController {

    @Autowired
    private ReseniaService reseniaService;

    @GetMapping("/destacadas")
    public ResponseEntity<List<ReseniaDTO>> obtenerReseniasDestacadas() {
        try {
            List<ReseniaDTO> destacadas = reseniaService.getReseniasDestacadas();
            return ResponseEntity.ok(destacadas);
        } catch (Exception e) {
            return ResponseEntity.status(500).build();
        }
    }
}