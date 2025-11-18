package com.example.DHT.service;
import com.example.DHT.DTO.*;
import com.example.DHT.model.Resenia;
import com.example.DHT.repository.ClienteRepository;
import com.example.DHT.repository.ReseniaRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.util.List;
import java.util.stream.Collectors;

@Service
public class ReseniaService {
    @Autowired
    private ReseniaRepository reseniaRepository;
    @Autowired
    private ClienteRepository clienteRepository;

    public List<ReseniaDTO> getReseniasPorCliente(String clienteDni) {
        clienteRepository.findById(clienteDni)
                .orElseThrow(() -> new RuntimeException("Cliente no existe"));

        return reseniaRepository.findAllByClienteDni(clienteDni).stream()
                .map(ReseniaDTO::new)
                .collect(Collectors.toList());
    }

    public List<ReseniaDTO> getReseniasDestacadas() {
        LocalDate haceTresMeses = LocalDate.now().minusMonths(3);
        List<Resenia> resenias = reseniaRepository.findByEstrellasGreaterThanEqualAndFechaAfter(4, haceTresMeses);

        return resenias.stream().map(ReseniaDTO::new).collect(Collectors.toList());
    }
}