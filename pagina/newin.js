document.addEventListener("DOMContentLoaded", function() {  
    function loadNewInProducts() {
        fetch('http://localhost:8080/api/prendas/new-in')
        .then(response => {
            if (!response.ok) {
                throw new Error(`Error HTTP ${response.status}`);
            }
            return response.json();
        })
        .then(prendas => {
            const contenedor = document.getElementById('contenedorNewIn'); // ← DECLARAR PRIMERO
            contenedor.innerHTML = ''; 

            const prendasValidas = prendas.filter(p => 
                p.variantes && p.variantes.length > 0
            );
            
            if (!prendasValidas || prendasValidas.length === 0) {
                contenedor.innerHTML = '<p class="text-center text-muted">No hay novedades por ahora.</p>';
                return;
            }

            prendasValidas.forEach(prenda => {
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

                const foto = "mockupIMG/" + prenda.fotoPrincipal;
                const fotoHover = "mockupIMG/" + prenda.foto2;

                const cardHtml = `
                    <div class="col-12 col-md-4"> 
                        <div class="tarjetaProductoDestacado h-100">
                            <div class="contenedor-img-hover">
                                <img src="${foto}" class="img-fluid img-main" alt="${prenda.nombre}">
                                <img src="${fotoHover}" class="img-fluid img-secondary" alt="${prenda.nombre} vista trasera">
                            </div>
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
            console.error('Error al cargar NEW IN:', error);
            contenedor.innerHTML = '<p class="text-center text-danger">Error de conexión.</p>';
        });
    }
    
    loadNewInProducts();
});