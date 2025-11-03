package com.example.DHT.service;

import com.example.DHT.DTO.historial.HistorialCompraDTO;
import com.example.DHT.DTO.historial.HistorialDTO;
import com.example.DHT.DTO.historial.HistorialDevolucionDTO;
import com.example.DHT.model.*;
import com.example.DHT.repository.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;

@Service
public class ClienteService {
    @Autowired
    private DevolucionRepository devolucionRepository;
    @Autowired
    private ClienteRepository clienteRepository;
    @Autowired
    private VariantePrendaRepository variantePrendaRepository;
    @Autowired
    private CompraRepository compraRepository;
    @Autowired
    private CompraDetalleRepository compraDetalleRepository;

    public HistorialDTO getHistorial(String clienteDni){
        List<Compra> comprasCliente = compraRepository.findAllByClienteDni(clienteDni);
        List<Devolucion> devolucionesCliente = devolucionRepository.findAllByClienteDni(clienteDni);

        List<HistorialCompraDTO> comprasDTO = comprasCliente.stream()
                .map(compra -> new HistorialCompraDTO(compra))
                .collect(Collectors.toList());

        List<HistorialDevolucionDTO> devolucionesDTO = devolucionesCliente.stream()
                .map(devolucion -> new HistorialDevolucionDTO(devolucion))
                .collect(Collectors.toList());

        HistorialDTO historialFinal = new HistorialDTO();
        historialFinal.setCompras(comprasDTO);
        historialFinal.setDevoluciones(devolucionesDTO);

        return historialFinal;
    }
}
