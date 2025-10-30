package com.example.DHT.service;

import com.example.DHT.DTO.DevolucionDTO;
import com.example.DHT.DTO.ItemDevolucion;
import com.example.DHT.model.*;
import com.example.DHT.repository.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import java.time.LocalDateTime;

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

        Devolucion devolucionGuardada = devolucionRepository.save(devolucion);
        for (ItemDevolucion itemDTO : devolucionRequest.getItems()) {

            Integer idCompraDetalle = itemDTO.getIdCompraDetalle();
            Integer cantidadADevolver = itemDTO.getCantidadADevolver();

            CompraDetalle compraDetalle = compraDetalleRepository.findById(idCompraDetalle)
                    .orElseThrow(() -> new RuntimeException("Item de compra (ID: " + idCompraDetalle + ") no encontrado"));

            if (!compraDetalle.getCompra().getIdCompra().equals(compra.getIdCompra())) {
                throw new RuntimeException("El item (ID: " + idCompraDetalle + ") no pertenece a la compra " + compra.getIdCompra());
            }

            VariantePrenda variante = compraDetalle.getVariantePrenda();
            Marca marca = variante.getPrenda().getMarca();

            if (!marca.puedeDevolver()) {
                throw new RuntimeException("La marca '" + marca.getNombreMarca() + "' no tiene habilitadas las devoluciones.");
            }

            variante.setStock(variante.getStock() + cantidadADevolver);
            variantePrendaRepository.save(variante);
        }
        return devolucionGuardada ;
    }

}