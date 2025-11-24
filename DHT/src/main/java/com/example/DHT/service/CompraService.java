package com.example.DHT.service;

import com.example.DHT.DTO.CompraDTO;
import com.example.DHT.DTO.ItemCompra;
import com.example.DHT.extras.excepcion.StockInsuficiente;
import com.example.DHT.model.*;
import com.example.DHT.repository.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class CompraService {

    @Autowired
    private CompraRepository compraRepository;
    @Autowired
    private ClienteRepository clienteRepository;
    @Autowired
    private VariantePrendaRepository variantePrendaRepository;
    @Autowired
    private MetodoPagoRepository metodoPagoRepository;

    // si algo falla bdd hace rollback y cancela operación
    @Transactional
    public Compra registrarCompra(CompraDTO compraRequest) {
        Cliente cliente = clienteRepository.findById(compraRequest.getClienteDni()).orElseThrow(() -> new RuntimeException("Cliente no encontrado"));
        MetodoPago metodoPago = metodoPagoRepository.findById(compraRequest.getIdMetodo()).orElseThrow(() -> new RuntimeException("Método de pago no encontrado"));

        Double costoTotalCalculado = 0.0;
        List<CompraDetalle> detallesDeLaCompra = new ArrayList<>();

        for (ItemCompra itemDTO : compraRequest.getItems()) {
            VariantePrenda variante = variantePrendaRepository.findById(itemDTO.getIdVariantePrenda()).orElseThrow(() -> new RuntimeException("Prenda no encontrada"));

                if (variante.getStock() < itemDTO.getCantidad()) {
                throw new StockInsuficiente("Stock insuficiente para: " + variante.getPrenda().getNombre() + " Talle: " + variante.getTalle() + " Color: " + variante.getColor());
            }

            variante.setStock(variante.getStock() - itemDTO.getCantidad());
            variantePrendaRepository.save(variante);

            Double precioPrenda = variante.getPrenda().getPrecio();
            costoTotalCalculado += (precioPrenda * itemDTO.getCantidad());

            Marca marcaDeLaPrenda = variante.getPrenda().getMarca();
            marcaDeLaPrenda.setCantidadVentasTotales(marcaDeLaPrenda.getCantidadVentasTotales() + itemDTO.getCantidad());
            double ganancia = precioPrenda * itemDTO.getCantidad() * (1 - marcaDeLaPrenda.getPorcentajeComision() / 100);
            marcaDeLaPrenda.setGananciasTotales(marcaDeLaPrenda.getGananciasTotales() + (float) ganancia);

            CompraDetalle detalle = new CompraDetalle();
            detalle.setVariantePrenda(variante);
            detalle.setCantidad(itemDTO.getCantidad());
            detalle.setPrecioUnitario(precioPrenda);
            detalle.setPorcentajeComision(marcaDeLaPrenda.getPorcentajeComision());

            detallesDeLaCompra.add(detalle);
        }


        int puntosGanados = (int) (costoTotalCalculado / 35000); // +1 cada 35k gastados
        cliente.setPuntos(cliente.getPuntos() + puntosGanados);
        clienteRepository.save(cliente);

        Compra nuevaCompra = new Compra();
        nuevaCompra.setCliente(cliente);
        nuevaCompra.setMetodoPago(metodoPago);
        nuevaCompra.setDatetimeCompra(LocalDateTime.now());
        nuevaCompra.setCostoTotal(costoTotalCalculado);

        nuevaCompra.setDetalles(detallesDeLaCompra);

        for (CompraDetalle detalle : detallesDeLaCompra) {
            detalle.setCompra(nuevaCompra);
        }

        // al guardar el "padre", se guardan automáticamente todos los "hijos".
        return compraRepository.save(nuevaCompra);
    }


    public List<Map<String, Object>> obtenerRankingPrendas(LocalDateTime desde, LocalDateTime hasta) {
        List<Compra> compras = compraRepository.findAll();
        Map<Prenda, Integer> conteoPrendas = new HashMap<>();

        for (Compra compra : compras) {
            LocalDateTime fechaCompra = compra.getDatetimeCompra();

            // Filtrar por rango de fechas
            if ((fechaCompra.isEqual(desde) || fechaCompra.isAfter(desde)) &&
                    (fechaCompra.isEqual(hasta) || fechaCompra.isBefore(hasta))) {

                // Recorre los detalles de la compra
                for (CompraDetalle detalle : compra.getDetalles()) {
                    Prenda prenda = detalle.getVariantePrenda().getPrenda();
                    int cantidad = conteoPrendas.getOrDefault(prenda, 0);
                    conteoPrendas.put(prenda, cantidad + detalle.getCantidad());
                }
            }
        }
        List<Map<String, Object>> ranking = new ArrayList<>();

        for (Map.Entry<Prenda, Integer> entry : conteoPrendas.entrySet()) {
            Map<String, Object> datos = new HashMap<>();
            datos.put("nombrePrenda", entry.getKey().getNombre());
            datos.put("cantidadVendida", entry.getValue());
            ranking.add(datos);
        }

        // Ordenar de mayor a menor cantidad vendida
        ranking.sort((a, b) -> ((Integer) b.get("cantidadVendida")) - ((Integer) a.get("cantidadVendida")));

        // Limitar al top 10
        if (ranking.size() > 10) {
            ranking = ranking.subList(0, 10);
        }

        return ranking;
    }
}