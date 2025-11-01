package com.example.DHT.service;

import com.example.DHT.DTO.DevolucionDTO;
import com.example.DHT.DTO.ItemDevolucion;
import com.example.DHT.model.*;
import com.example.DHT.repository.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

@Service
public class DevolucionService {
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


    @Transactional
    public Devolucion registrarDevolucion(DevolucionDTO devolucionRequest){
        Integer idCompra = devolucionRequest.getidCompra(); //
        if (devolucionRepository.existsByCompraIdCompra(idCompra)) {
            throw new RuntimeException("Error: La compra con ID " + idCompra + " ya ha sido devuelta previamente y no se puede procesar una nueva devolución para la misma.");
        }

        Cliente cliente = clienteRepository.findById(devolucionRequest.getClienteDni())
                .orElseThrow(() -> new RuntimeException("Cliente no encontrado"));
        Compra compra = compraRepository.findById(devolucionRequest.getidCompra())
                .orElseThrow(() -> new RuntimeException("Compra no encontrada"));

        if (!compra.getCliente().getDni().equals(cliente.getDni())) {
            throw new RuntimeException("La compra " + compra.getIdCompra() + " no pertenece al cliente " + cliente.getDni());
        }


        Devolucion devolucion = new Devolucion();
        devolucion.setCliente(cliente);
        devolucion.setCompra(compra);
        devolucion.setFechaHora(LocalDateTime.now());

        Double montoTotalReembolso = 0.0;
        List<DevolucionDetalle> detallesDevolucion = new ArrayList<>();

        for (ItemDevolucion itemDTO : devolucionRequest.getItems()) {

            Integer idCompraDetalle = itemDTO.getIdCompraDetalle();
            Integer cantidadADevolver = itemDTO.getCantidadADevolver();

            CompraDetalle compraDetalle = compraDetalleRepository.findById(idCompraDetalle)
                    .orElseThrow(() -> new RuntimeException("Item de compra (ID: " + idCompraDetalle + ") no encontrado"));

            if (!compraDetalle.getCompra().getIdCompra().equals(compra.getIdCompra())) {
                throw new RuntimeException("El item (ID: " + idCompraDetalle + ") no pertenece a la compra " + compra.getIdCompra());
            }

            if (cantidadADevolver <= 0) {
                throw new RuntimeException("La cantidad a devolver debe ser mayor a 0");
            }
            if (cantidadADevolver > compraDetalle.getCantidad()) {
                throw new RuntimeException("No podés devolver más unidades de las que compraste. Compraste: " + compraDetalle.getCantidad() + ", intentás devolver: " + cantidadADevolver);
            }


            VariantePrenda variante = compraDetalle.getVariantePrenda();
            Marca marca = variante.getPrenda().getMarca();

            if (!marca.puedeDevolver()) {
                throw new RuntimeException("La marca '" + marca.getNombreMarca() + "' no tiene habilitadas las devoluciones.");
            }

            variante.setStock(variante.getStock() + cantidadADevolver);
            variantePrendaRepository.save(variante);

            Double reembolsoItem = compraDetalle.getPrecioUnitario() * cantidadADevolver;
            montoTotalReembolso += reembolsoItem;

            DevolucionDetalle detalle = new DevolucionDetalle();
            detalle.setDevolucion(devolucion);
            detalle.setCompraDetalle(compraDetalle);
            detalle.setCantidadDevuelta(cantidadADevolver);

            detallesDevolucion.add(detalle);
        }
        devolucion.setMontoTotalReembolsado(montoTotalReembolso);
        devolucion.setDetalles(detallesDevolucion);
        return devolucionRepository.save(devolucion);
    }

}