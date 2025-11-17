document.addEventListener('DOMContentLoaded', function() {
    const userData = JSON.parse(localStorage.getItem('currentUser'));
    
    if (!userData || !userData.dni) {
        alert('Por favor, inicia sesión para ver tu perfil.');
        window.location.href = 'login.html';
        return; 
    }
    
    const userDni = userData.dni;
    const apiBaseUrl = 'http://localhost:8080/api/cliente/' + userDni;
    
    // Cargar información del usuario
    fetch(apiBaseUrl)
        .then(response => {
            if (!response.ok) throw new Error('No se pudo cargar el perfil.');
            return response.json();
        })
        .then(cliente => {
            document.getElementById('nombreUsuario').textContent = cliente.nombre + ' ' + cliente.apellido;
            document.querySelector('.emailUsuario').textContent = cliente.email;
            document.querySelector('.puntosUsuario').textContent = (cliente.puntos || 0) + ' puntos';
            document.getElementById('imagenUsuario').src = cliente.fotoPerfil || 'mp.png';
        })
        .catch(err => {
            console.error('Error cargando perfil:', err);
            document.getElementById('nombreUsuario').textContent = "Usuario";
        });
    
    const comprasCarousel = document.getElementById('comprasCarousel');
    const comprasArrows = document.querySelectorAll('#comprasCarouselContainer .carousel-control-prev, #comprasCarouselContainer .carousel-control-next');

    // Cargar historial de compras
    fetch(apiBaseUrl + '/historial')
        .then(response => {
            if (!response.ok) throw new Error('Error en historial');
            return response.json();
        })
        .then(historial => {
            console.log('Historial completo recibido:', historial);
            comprasCarousel.innerHTML = ''; 

            // Verificar si hay compras - TODAS las validaciones posibles
            if (!historial || 
                !historial.compras || 
                !Array.isArray(historial.compras) || 
                historial.compras.length === 0) {
                
                console.log('No hay compras en el historial');
                comprasArrows.forEach(arrow => arrow.style.display = 'none');
                
                comprasCarousel.innerHTML = `
                    <div class="carousel-item active">
                        <div class="d-flex flex-column align-items-center justify-content-center py-5">
                            <h4 class="titulo text-muted mb-3">Todavía no realizaste ninguna compra</h4>
                            <p class="text-secondary mb-4">¡Descubre nuestros productos y empieza a sumar puntos!</p>
                            <a href="index.html" class="botonSubmit text-decoration-none">Explorar nuestra tienda</a>
                        </div>
                    </div>`;
                return;
            }

            const itemsPorSlide = 4;
            let todosLosItems = [];
            
            // Recolectar todos los items comprados con LOG
            historial.compras.forEach((compra, index) => {
                console.log(`Compra ${index}:`, compra);
                
                if(compra && 
                   compra.itemsComprados && 
                   Array.isArray(compra.itemsComprados) && 
                   compra.itemsComprados.length > 0) {
                    
                    console.log(`Items en compra ${index}:`, compra.itemsComprados);
                    todosLosItems.push(...compra.itemsComprados);
                } else {
                    console.log(`Compra ${index} no tiene items válidos`);
                }
            });

            console.log('Total de items recolectados:', todosLosItems.length);
            console.log('Items:', todosLosItems);

            // Si después de procesar no hay items, mostrar mensaje
            if (todosLosItems.length === 0) {
                console.log('No se encontraron items después de procesar');
                comprasArrows.forEach(arrow => arrow.style.display = 'none');
                comprasCarousel.innerHTML = `
                    <div class="carousel-item active">
                        <div class="d-flex flex-column align-items-center justify-content-center py-5">
                            <h4 class="titulo text-muted mb-3">Todavía no realizaste ninguna compra</h4>
                            <p class="text-secondary mb-4">¡Descubre nuestros productos y empieza a sumar puntos!</p>
                            <a href="index.html" class="botonSubmit text-decoration-none">Explorar nuestra tienda</a>
                        </div>
                    </div>`;
                return;
            }

            // Crear slides con los items
            for (let i = 0; i < todosLosItems.length; i += itemsPorSlide) {
                const slideItems = todosLosItems.slice(i, i + itemsPorSlide);
                const slide = document.createElement('div');
                slide.classList.add('carousel-item');
                if (i === 0) slide.classList.add('active'); 
                
                const row = document.createElement('div');
                row.classList.add('row', 'g-3');
                
                let cardHtml = '';
                slideItems.forEach(item => {
                    const fotoUrl = item.fotoPrincipal || 'https://via.placeholder.com/280x300/e8e8e8/999?text=DHT';
                    
                    cardHtml += `
                    <div class="col-12 col-md-6 col-lg-3">
                        <div class="tarjetaProducto" style="flex-direction: column; height: 100%;">
                            <img src="${fotoUrl}" alt="${item.nombreVariantePrenda}" class="imagenProducto" style="height: 200px; width: 100%; object-fit: cover;">
                            <div class="infoProducto p-2">
                                <p class="marcaProducto mb-1">${(item.nombreMarca || 'DHT').toUpperCase()}</p>
                                <h3 class="nombreProducto mb-2" style="font-size: 1rem;">${item.nombreVariantePrenda}</h3>
                                <div class="infoCompra d-flex justify-content-between align-items-center">
                                    <span class="precioProducto">$${item.precioUnit.toFixed(2)}</span>
                                    <span class="tallaProducto badge bg-light text-dark">x${item.cantidad}</span>
                                </div>
                            </div>
                        </div>
                    </div>`;
                });
                row.innerHTML = cardHtml;
                slide.appendChild(row);
                comprasCarousel.appendChild(slide);
            }
            
            // Mostrar/ocultar flechas según cantidad de items
            if (todosLosItems.length > itemsPorSlide) {
                comprasArrows.forEach(arrow => arrow.style.display = 'flex');
                new bootstrap.Carousel(document.getElementById('comprasCarouselContainer'), {
                    interval: false 
                });
            } else {
                comprasArrows.forEach(arrow => arrow.style.display = 'none');
            }
        })
        .catch(err => {
            console.error('Error cargando historial:', err);
            comprasArrows.forEach(arrow => arrow.style.display = 'none');
            comprasCarousel.innerHTML = `
                <div class="carousel-item active">
                    <div class="d-flex flex-column align-items-center justify-content-center py-5">
                        <h4 class="titulo text-muted mb-3">Todavía no realizaste ninguna compra</h4>
                        <p class="text-secondary mb-4">¡Descubre nuestros productos y empieza a sumar puntos!</p>
                        <a href="index.html" class="botonSubmit text-decoration-none">Explorar nuestra tienda</a>
                    </div>
                </div>`;
        });
    
    const reseniasCarousel = document.getElementById('reseniasCarousel');
    const reseniasArrows = document.querySelectorAll('#reseniasCarouselContainer .carousel-control-prev, #reseniasCarouselContainer .carousel-control-next');

    // Cargar reseñas
    fetch(apiBaseUrl + '/resenias')
        .then(response => {
            if (!response.ok) throw new Error('Error reseñas');
            return response.json();
        })
        .then(resenias => {
            reseniasCarousel.innerHTML = '';
            
            if (!resenias || resenias.length === 0) {
                reseniasArrows.forEach(arrow => arrow.style.display = 'none');
                reseniasCarousel.innerHTML = `
                    <div class="carousel-item active">
                        <div class="d-flex flex-column align-items-center justify-content-center py-5 text-center">
                            <p class="fs-5 text-muted mb-2">No has escrito reseñas todavía.</p>
                            <small class="text-secondary">¡Compra un producto para dejar tu opinión!</small>
                        </div>
                    </div>`;
                return;
            }

            reseniasArrows.forEach(arrow => arrow.style.display = 'flex');
            const itemsPorSlide = 2; 

            for (let i = 0; i < resenias.length; i += itemsPorSlide) {
                const slideItems = resenias.slice(i, i + itemsPorSlide);
                const slide = document.createElement('div');
                slide.classList.add('carousel-item');
                if (i === 0) slide.classList.add('active');
                
                const row = document.createElement('div');
                row.classList.add('row', 'g-3');
                
                let cardHtml = '';
                slideItems.forEach(resenia => {
                    const fotoUrl = resenia.fotoPrenda || 'https://via.placeholder.com/100';
                    const estrellas = '<span style="color: #ffc107;">' + '★'.repeat(resenia.estrellas) + '</span>' + '<span style="color: #e4e5e9;">' + '★'.repeat(5 - resenia.estrellas) + '</span>';
            
                    cardHtml += `
                    <div class="col-12 col-lg-6">
                        <div class="tarjetaresenia h-100">
                            <img src="${fotoUrl}" alt="${resenia.nombrePrenda}" class="imagenresenia">
                            <div class="contenidoresenia">
                                <div class="fw-bold mb-1">${resenia.nombrePrenda}</div>
                                <div class="estrellas mb-1">${estrellas}</div>
                                <p class="fecharesenia mb-2 text-muted small">${new Date(resenia.fecha).toLocaleDateString()}</p>
                                <p class="textoresenia mb-0">"${resenia.comentario}"</p>
                            </div>
                        </div>
                    </div>`;
                });
                row.innerHTML = cardHtml;
                slide.appendChild(row);
                reseniasCarousel.appendChild(slide);
            }
            
            if (resenias.length <= itemsPorSlide) {
                 reseniasArrows.forEach(arrow => arrow.style.display = 'none');
            } else {
                new bootstrap.Carousel(document.getElementById('reseniasCarouselContainer'), {
                    interval: false
                });
            }
        })
        .catch(err => {
            console.error('Error cargando reseñas:', err);
            reseniasArrows.forEach(arrow => arrow.style.display = 'none');
            reseniasCarousel.innerHTML = `
                <div class="carousel-item active">
                    <div class="d-flex flex-column align-items-center justify-content-center py-5 text-center">
                        <p class="fs-5 text-muted mb-2">No has escrito reseñas todavía.</p>
                        <small class="text-secondary">¡Compra un producto para dejar tu opinión!</small>
                    </div>
                </div>`;
        });
        
    document.getElementById('logoutButton').addEventListener('click', function() {
        localStorage.removeItem('currentUser'); 
        window.location.href = 'login.html'; 
    });
});