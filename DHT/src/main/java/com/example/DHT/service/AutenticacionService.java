package com.example.DHT.service;

import com.example.DHT.DTO.ClienteDTO;
import com.example.DHT.DTO.autenticacion.LogInDTO;
import com.example.DHT.model.Cliente;
import com.example.DHT.repository.ClienteRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class AutenticacionService {

    @Autowired
    private ClienteRepository clienteRepository;

    public Cliente registrarCliente(ClienteDTO registro) {
        if (clienteRepository.findByEmail(registro.getEmail()).isPresent()) {
            throw new RuntimeException("Error: El email ya está en uso.");
        }

        Cliente nuevoCliente = new Cliente();
        nuevoCliente.setDni(registro.getDni());
        nuevoCliente.setNombre(registro.getNombre());
        nuevoCliente.setApellido(registro.getApellido());
        nuevoCliente.setEmail(registro.getEmail());
        nuevoCliente.setGenero(registro.getGenero());
        nuevoCliente.setContrasenia(registro.getContrasenia());

        return clienteRepository.save(nuevoCliente);
    }


    public Cliente loginCliente(LogInDTO login) {
        Cliente cliente = clienteRepository.findByEmail(login.getEmail())
                .orElseThrow(() -> new RuntimeException("Inválidas"));

        if (login.getContrasenia().equals(cliente.getContrasenia())) {
            return cliente;
        } else {
            throw new RuntimeException("No coincide información");
        }
    }
}
