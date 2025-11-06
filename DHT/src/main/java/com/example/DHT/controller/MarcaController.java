package com.example.DHT.controller;

import com.example.DHT.DTO.PrendaDTO;
import com.example.DHT.model.Prenda;
import com.example.DHT.service.ClienteService;
import com.example.DHT.service.MarcaService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/marcas")
public class MarcaController {
    @Autowired
    private MarcaService marcaService;

    @PostMapping("/{id}/modelos")
    public ResponseEntity<?> cargarNuevaPrenda(@PathVariable("id") int idMarca, @RequestBody PrendaDTO prendaDTO){
        try{
            Prenda prendaGuardada = marcaService.cargarNuevaPrenda(idMarca, prendaDTO);
            PrendaDTO prendaNueva = new PrendaDTO(prendaGuardada);
            return new ResponseEntity<>(prendaNueva, HttpStatus.CREATED);
        }
        catch (RuntimeException e) {
            return new ResponseEntity<>(e.getMessage(), HttpStatus.NOT_FOUND);
        }

    }
}
