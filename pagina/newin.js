document.addEventListener("DOMContentLoaded", function() {  
    function loadNewInProducts() {
        
        fetch('http://localhost:8080/api/prendas/new-in')
        .then(response => {
            if (!response.ok) {
                throw new Error(`Error HTTP ${response.status}: No se pudo cargar el endpoint de novedades.`);
            }
            return response.json();
        })
        .then(prendas => {
            const contenedor = document.getElementById('contenedorNewIn');
            contenedor.innerHTML = ''; 

            if (!prendas || prendas.length === 0) {
                contenedor.innerHTML = '<p class="text-center text-muted">No hay novedades por ahora.</p>';
                return;
            }

            prendas.forEach(prenda => {
                const coloresHtml = (prenda.coloresDisponibles || []).map(color => {
                const colorMap = {
                    'negro': '#000000',
                    'negrogastado': '#000000',
                    'blanco': '#FFFFFF',
                    'gris': '#A9A9A9',      
                    'gris melange': '#C0C0C0', 
                    'azul': '#1E90FF',
                    'verde': '#228B22',
                    'marrón': '#5D4037',  
                    'beige': '#F5F5DC',    
                    'vino': '#640032'    
                };
            
                const cleanColor = color.toLowerCase().trim().replace(/ /g, ''); 
                const colorCode = colorMap[cleanColor] || '#808080'; 
                
                return `<span class="colorOpcion" style="background-color: ${colorCode}; border: 1px solid #ddd;" title="${color}"></span>`;
            }).join('');

                const foto = prenda.fotoPrincipal || 'home/producto_default.png';

                const cardHtml = `
                    <div class="col-12 col-md-4"> 
                        <div class="tarjetaProductoDestacado h-100">
                            <div class="imagenProductoDestacado" style="background-image: url('${foto}');"></div>
                            
                            <div class="infoProductoDestacado">
                                <p class="marcaDestacada">${(prenda.nombreMarca || 'MARCA').toUpperCase()}</p>
                                <h3 class="nombreDestacado">${prenda.nombre}</h3>
                                <p class="precioDestacado">$${prenda.precio.toLocaleString('es-AR')}</p>
                                <div class="coloresDisponibles">${coloresHtml}</div>
                            </div>
                        </div>
                    </div>
                `;
                contenedor.innerHTML += cardHtml;
            });
        })
        .catch(error => {
            const contenedor = document.getElementById('contenedorNewIn');
            console.error('Error FATAL al cargar NEW IN:', error);
            contenedor.innerHTML = '<p class="text-center text-danger">Fallo de conexión. No se pudieron cargar las novedades.</p>';
        });
    }
    
    loadNewInProducts();
});