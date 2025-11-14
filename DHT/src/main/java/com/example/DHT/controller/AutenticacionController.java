package com.example.DHT.controller;

import com.example.DHT.DTO.autenticacion.LogInDTO;
import com.example.DHT.DTO.*;
import com.example.DHT.model.Cliente;
import com.example.DHT.service.AutenticacionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api")
public class AutenticacionController {

    @Autowired
    private AutenticacionService autenticacionServ;

    @PostMapping("/registro")
    public ResponseEntity<?> registrarCliente(@RequestBody ClienteDTO registro) {
        try {
            Cliente clienteGuardado = autenticacionServ.registrarCliente(registro);
            clienteGuardado.setContrasenia(null);
            return new ResponseEntity<>(clienteGuardado, HttpStatus.CREATED);
        } catch (RuntimeException e) {
            return new ResponseEntity<>(e.getMessage(), HttpStatus.BAD_REQUEST);
        }
    }

    @PostMapping("/login")
    public ResponseEntity<?> loginCliente(@RequestBody LogInDTO login) {
        try {
            Cliente cliente = autenticacionServ.loginCliente(login);
            cliente.setContrasenia(null);
            return new ResponseEntity<>(cliente, HttpStatus.OK);
        } catch (RuntimeException e) {
            return new ResponseEntity<>(e.getMessage(), HttpStatus.UNAUTHORIZED);
        }
    }
}
