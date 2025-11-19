document.addEventListener('DOMContentLoaded', function() {
    const userData = JSON.parse(localStorage.getItem('currentUser'));
    if (!userData || !userData.dni) {
        window.location.href = 'login.html';
        return;
    }

    const userDni = userData.dni;
    console.log("Usuario logueado DNI:", userDni); 
    const apiBaseUrl = 'http://localhost:8080/api/clientes/' + userDni;

    fetch(apiBaseUrl)
        .then(res => res.json())
        .then(cliente => {
            document.getElementById('nombreUsuario').textContent = cliente.nombre + ' ' + cliente.apellido;
            document.querySelector('.emailUsuario').textContent = cliente.email;
            document.querySelector('.puntosUsuario').textContent = (cliente.puntos || 0) + ' puntos';
            document.getElementById('imagenUsuario').src = cliente.fotoPerfil || 'mp.png';
        })
        .catch(err => console.error("Error perfil:", err));

    
    const comprasContainer = document.getElementById('comprasCarousel'); 
    const comprasArrows = document.querySelectorAll('#comprasCarouselContainer .custom-arrow');

    if (!comprasContainer) {
        console.error("¡ERROR CRÍTICO! No se encontró el elemento con id='comprasCarousel' en el HTML.");
    } else {
        fetch(apiBaseUrl + '/historial')
            .then(res => res.json())
            .then(historial => {
                console.log("Historial recibido:", historial);

                comprasContainer.innerHTML = ''; 
                let todosLosItems = [];

                if (historial && historial.compras) {
                    historial.compras.forEach(compra => {
                        if (compra.itemsComprados) {
                            todosLosItems.push(...compra.itemsComprados);
                        }
                    });
                }
                
                console.log("Total items comprados:", todosLosItems.length); 

                if (todosLosItems.length === 0) {
                    comprasArrows.forEach(a => a.style.display = 'none');
                    comprasContainer.innerHTML = `
                        <div class="carousel-item active">
                            <div class="d-flex flex-column align-items-center justify-content-center py-5 text-center">
                                <h4 class="titulo text-muted mb-3" style="font-size: 1.5rem;">Todavía no realizaste ninguna compra</h4>
                                <a href="index.html" class="botonSubmit text-decoration-none">Explorar tienda</a>
                            </div>
                        </div>`;
                    return;
                }

                comprasArrows.forEach(a => a.style.display = 'flex');
                const itemsPorSlide = 4;

                for (let i = 0; i < todosLosItems.length; i += itemsPorSlide) {
                    const slideItems = todosLosItems.slice(i, i + itemsPorSlide);
                    const activeClass = (i === 0) ? 'active' : '';
                    
                    let cardsHtml = '';
                    slideItems.forEach(item => {
                        const foto = "mockupIMG/" + item.fotoPrincipal ;
                        
                        cardsHtml += `
                        <div class="col-12 col-md-6 col-lg-3">
                            <div class="tarjetaProducto h-100 d-flex flex-column">
                                <img src="${foto}" class="imagenProducto mb-3" style="height: 250px; object-fit: cover; border-radius: 8px;">
                                <div class="infoProducto">
                                    <p class="marcaProducto mb-1 text-uppercase text-muted small">${item.nombreMarca}</p>
                                    <h3 class="nombreProducto mb-2 fs-5 text-dark fw-bold">${item.nombreVariantePrenda}</h3>
                                    <div class="d-flex justify-content-between align-items-center border-top pt-2 mt-auto">
                                        <span class="fw-bold text-dark">$${item.precioUnit}</span>
                                        <span class="badge bg-light text-dark border">x${item.cantidad}</span>
                                    </div>
                                </div>
                            </div>
                        </div>`;
                    });

                    comprasContainer.innerHTML += `
                        <div class="carousel-item ${activeClass}">
                            <div class="row g-4">${cardsHtml}</div>
                        </div>`;
                }

                if (todosLosItems.length > itemsPorSlide) {
                    new bootstrap.Carousel(document.getElementById('comprasCarouselContainer'), { interval: false });
                } else {
                    comprasArrows.forEach(a => a.style.display = 'none');
                }
            })
            .catch(err => {
                console.error("Error en fetch historial:", err);
                comprasContainer.innerHTML = '<p class="text-center text-danger">Error al cargar compras.</p>';
            });
    }

    const reseniasContainer = document.getElementById('reseniasCarousel');
    const reseniasArrows = document.querySelectorAll('#reseniasCarouselContainer .custom-arrow');

    if (!reseniasContainer) {
        console.error("¡ERROR CRÍTICO! No se encontró el elemento con id='reseniasCarousel'");
    } else {
        fetch(apiBaseUrl + '/resenias')
            .then(res => res.json())
            .then(resenias => {
                console.log("Reseñas recibidas:", resenias); 

                reseniasContainer.innerHTML = '';
                
                if (!resenias || resenias.length === 0) {
                    reseniasArrows.forEach(a => a.style.display = 'none');
                    reseniasContainer.innerHTML = `
                        <div class="carousel-item active">
                            <div class="d-flex flex-column align-items-center justify-content-center py-4 text-center">
                                <p class="text-muted mb-2 fs-5">Todavía no realizaste ninguna reseña.</p>
                                <small class="text-secondary">Tus opiniones aparecerán aquí.</small>
                            </div>
                        </div>`;
                    return;
                }

                reseniasArrows.forEach(a => a.style.display = 'flex');
                const itemsPorSlide = 2;

                for (let i = 0; i < resenias.length; i += itemsPorSlide) {
                    const slideItems = resenias.slice(i, i + itemsPorSlide);
                    const activeClass = (i === 0) ? 'active' : '';
                    
                    let cardsHtml = '';
                    slideItems.forEach(r => {
                        const estrellas = '⭐'.repeat(r.estrellas);
                        const foto = "mockupIMG/" + r.fotoPrenda || 'https://via.placeholder.com/80';
                        
                        cardsHtml += `
                        <div class="col-12 col-md-6">
                            <div class="tarjetaResena h-100 p-4 border rounded bg-white d-flex gap-3 align-items-center shadow-sm">
                                <img src="${foto}" style="width: 80px; height: 80px; object-fit: cover; border-radius: 50%;">
                                <div class="w-100">
                                    <div class="fw-bold text-dark mb-1">${r.nombrePrenda}</div>
                                    <div class="small mb-2">${estrellas}</div>
                                    <p class="m-0 text-muted small fst-italic">"${r.comentario}"</p>
                                </div>
                            </div>
                        </div>`;
                    });

                    reseniasContainer.innerHTML += `
                        <div class="carousel-item ${activeClass}">
                            <div class="row g-4">${cardsHtml}</div>
                        </div>`;
                }

                if (resenias.length > itemsPorSlide) {
                    new bootstrap.Carousel(document.getElementById('reseniasCarouselContainer'), { interval: false });
                } else {
                    reseniasArrows.forEach(a => a.style.display = 'none');
                }
            })
            .catch(err => {
                console.error("Error en fetch reseñas:", err);
                reseniasContainer.innerHTML = '<p class="text-center text-danger">Error al cargar reseñas.</p>';
            });
    }

    document.getElementById('logoutButton').addEventListener('click', () => {
        localStorage.removeItem('currentUser');
        window.location.href = 'login.html';
    });
});