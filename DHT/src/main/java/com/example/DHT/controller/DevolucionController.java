package com.example.DHT.controller;

import com.example.DHT.DTO.DevolucionDTO;
import com.example.DHT.model.Devolucion;
import com.example.DHT.service.DevolucionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api")
public class DevolucionController {
    @Autowired
    private DevolucionService devolucionService;

    @PostMapping("/devoluciones")
    public ResponseEntity<?> registrarNuevaDevolucion (@RequestBody DevolucionDTO devolucionRequest){
        try {
            Devolucion devolucionGuardada = devolucionService.registrarDevolucion(devolucionRequest);
            return new ResponseEntity<>(devolucionGuardada, HttpStatus.CREATED);

        } catch (RuntimeException e) {
            return new ResponseEntity<>(e.getMessage(), HttpStatus.NOT_FOUND);
        }
    }
}
