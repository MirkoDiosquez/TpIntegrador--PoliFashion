package com.example.DHT.service;

import com.example.DHT.DTO.*;
import com.example.DHT.DTO.historial.*;
import com.example.DHT.model.*;
import com.example.DHT.repository.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
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

    public Cliente getCliente(String clienteDni) {
        return clienteRepository.findById(clienteDni)
                .orElseThrow(() -> new RuntimeException("Cliente no existe"));
    }

    public HistorialDTO getHistorial(String clienteDni){
        clienteRepository.findById(clienteDni).orElseThrow(() -> new RuntimeException("Cliente no existe"));

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

    // g. Puntos acumulados por cliente (SOLO PUNTOS)
    // Se elimina la lógica de beneficios
    public Map<String, Object> obtenerPuntosCliente(String clienteDni) {

        Cliente cliente = clienteRepository.findById(clienteDni)
                .orElseThrow(() -> new RuntimeException("Cliente no existe"));

        int puntos = cliente.getPuntos();

        Map<String, Object> respuesta = new HashMap<>();
        respuesta.put("clienteDni", clienteDni);
        respuesta.put("puntos", puntos);

        return respuesta;
    }

    // El método determinarBeneficio(int puntos) debe ser ELIMINADO o ignorado.
    // ...
    // Hago esto para que se mantenga el resto del código y el IDE no se queje:
    private String determinarBeneficio(int puntos) {
        return ""; // Se deja vacío si no se elimina
    }
    
    public Map<String, Integer> obtenerEstadisticasMarcas(String clienteDni) {

        clienteRepository.findById(clienteDni)
                .orElseThrow(() -> new RuntimeException("Cliente no existe"));

        // Todas las compras del cliente
        List<Compra> compras = compraRepository.findAllByClienteDni(clienteDni);

        // Mapa (marca → cantidad de prendas compradas)
        Map<String, Integer> estadisticas = new HashMap<>();

        for (Compra compra : compras) {
            List<CompraDetalle> detalles = compraDetalleRepository.findByCompra_IdCompra(compra.getIdCompra());

            for (CompraDetalle detalle : detalles) {

                // Marca de la prenda comprada
                String marca = detalle.getVariantePrenda().getPrenda().getMarca().getNombreMarca();

                // Cantidad comprada de esa variante
                int cantidad = detalle.getCantidad();

                // Acumulamos en el mapa
                estadisticas.put(marca, estadisticas.getOrDefault(marca, 0) + cantidad);
            }
        }

        return estadisticas;
    }
}
