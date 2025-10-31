package com.example.DHT.repository;
import com.example.DHT.model.DevolucionDetalle;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface DevolucionDetalleRepository extends JpaRepository<DevolucionDetalle, Integer> {
}