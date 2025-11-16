package com.example.DHT.controller;

import com.example.DHT.DTO.CompraDTO;
import com.example.DHT.extras.excepcion.StockInsuficiente;
import com.example.DHT.model.Compra;
import com.example.DHT.service.CompraService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/api")
public class CompraController {
    @Autowired
    private CompraService compraService;

    @PostMapping("/compras")   // postea en /api/compras
    public ResponseEntity<?> registrarNuevaCompra(@RequestBody CompraDTO compraRequest) {
        try {
            Compra compraGuardada = compraService.registrarCompra(compraRequest);
            CompraDTO compraDTO = new CompraDTO(compraGuardada);
            return new ResponseEntity<>(compraDTO, HttpStatus.CREATED);

        } catch (StockInsuficiente e) {
            return new ResponseEntity<>(e.getMessage(), HttpStatus.BAD_REQUEST);

        } catch (RuntimeException e) {
            return new ResponseEntity<>(e.getMessage(), HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }
    @GetMapping("/compras/ranking")
    public ResponseEntity<?> obtenerRanking(
            @RequestParam LocalDateTime desde,
            @RequestParam LocalDateTime hasta) {

        List<Map<String, Object>> ranking = compraService.obtenerRankingPrendas(desde, hasta);
        return ResponseEntity.ok(ranking);
    }

}
