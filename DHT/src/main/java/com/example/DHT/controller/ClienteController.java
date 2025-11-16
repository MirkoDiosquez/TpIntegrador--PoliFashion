@RestController
@RequestMapping("/api/cliente")
public class ClienteController {

    @Autowired
    private ClienteService clienteService;
    @Autowired
    private ReseniaService reseniaService;

    @GetMapping("/{dni}")
    public ResponseEntity<?> getClientePorDni(@PathVariable String dni) {
        try {
            Cliente cliente = clienteService.getCliente(dni);
            cliente.setContrasenia(null); // no devolver la contraseña
            return ResponseEntity.ok(cliente);
        } catch (RuntimeException e) {
            return ResponseEntity.status(404).body(e.getMessage());
        }
    }

    @GetMapping("/{id}/historial")
    public ResponseEntity<?> getHistorialDelCliente(@PathVariable("id") String clienteDni) {
        try {
            HistorialDTO historial = clienteService.getHistorial(clienteDni);
            return ResponseEntity.ok(historial);
        }
        catch (RuntimeException e) {
            return new ResponseEntity<>(e.getMessage(), HttpStatus.NOT_FOUND);
        }
    }

    @GetMapping("/{dni}/resenias")
    public ResponseEntity<?> getReseniasDelCliente(@PathVariable String dni) {
        try {
            List<ReseniaDTO> resenias = reseniaService.getReseniasPorCliente(dni);
            return ResponseEntity.ok(resenias);
        } catch (RuntimeException e) {
            return ResponseEntity.status(404).body(e.getMessage());
        }
    }

    @GetMapping("/{id}/puntos")
    public ResponseEntity<?> getPuntosDelCliente(@PathVariable("id") String clienteDni) {
        try {
            return ResponseEntity.ok(clienteService.obtenerPuntosYBeneficios(clienteDni));
        } catch (RuntimeException e) {
            return ResponseEntity.status(404).body(e.getMessage());
        }
    }

    @GetMapping("/{id}/estadisticas/marcas")
    public ResponseEntity<?> getEstadisticasMarcas(@PathVariable("id") String clienteDni) {
        try {
            return ResponseEntity.ok(clienteService.obtenerEstadisticasMarcas(clienteDni));
        } catch (RuntimeException e) {
            return ResponseEntity.status(404).body(e.getMessage());
        }
    }
}
