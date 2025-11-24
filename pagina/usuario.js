document.addEventListener('DOMContentLoaded', function() {
    const userData = JSON.parse(localStorage.getItem('currentUser'));
    if (!userData || !userData.dni) {
        window.location.href = 'login.html';
        return;
    }

    const userDni = userData.dni;
    const apiBaseUrl = 'http://localhost:8080/api/clientes/' + userDni;

    fetch(apiBaseUrl)
        .then(res => res.json())
        .then(cliente => {
            document.getElementById('nombreUsuario').textContent = cliente.nombre + ' ' + cliente.apellido;
            document.querySelector('.emailUsuario').textContent = cliente.email;
            document.querySelector('.puntosUsuario').textContent = (cliente.puntos || 0) + ' puntos';
            document.getElementById('imagenUsuario').src = cliente.fotoPerfil ? "mockupIMG/" + cliente.fotoPerfil : 'mp.png';
        })
        .catch(err => console.error("Error perfil:", err));


    function crearCarruselResponsivo(items, containerId, carouselId, tipoCard) {
        const innerContainer = document.getElementById(containerId); 
        const mainCarouselElement = document.getElementById(carouselId); 
        
        if (!innerContainer || !mainCarouselElement) return;

        function getItemsPerSlide() {
            const width = window.innerWidth;
            if (width < 768) return 1; 
            if (width < 1200) return 2; 
            return (tipoCard === 'compra') ? 4 : 2; 
        }

        function render() {
            const perSlide = getItemsPerSlide();
            innerContainer.innerHTML = ''; 
            
            const oldIndicators = mainCarouselElement.querySelector('.carousel-indicators');
            if(oldIndicators) oldIndicators.remove();

            if (!items || items.length === 0) {
                innerContainer.innerHTML = `<div class="carousel-item active"><div class="text-center py-5 text-muted">Todavia no realizaste nignuna compra/reseña</div></div>`;
                const arrows = mainCarouselElement.querySelectorAll('.carousel-control-prev, .carousel-control-next');
                arrows.forEach(a => a.style.display = 'none');
                return;
            }

            let slideCount = 0;

            for (let i = 0; i < items.length; i += perSlide) {
                const chunk = items.slice(i, i + perSlide);
                const activeClass = (i === 0) ? 'active' : '';
                
                let htmlContent = `<div class="carousel-item ${activeClass}"><div class="row g-3 justify-content-center">`;
                
                chunk.forEach(item => {
                    let colClass = 'col-12';
                    if (perSlide === 2) colClass = 'col-6';          
                    if (perSlide === 4) colClass = 'col-6 col-lg-3';
                    
                    if (tipoCard === 'compra') {
                        const foto = item.fotoPrincipal ? "mockupIMG/" + item.fotoPrincipal : "https://via.placeholder.com/150?text=Sin+Imagen";
                        
                        htmlContent += `
                        <div class="${colClass}">
                            <div class="tarjetaProducto">
                                <img src="${foto}" class="imagenProducto" alt="${item.nombreVariantePrenda}" onerror="this.src='https://via.placeholder.com/150?text=Error'">
                                <div class="infoProducto">
                                    <div>
                                        <p class="marcaProducto">${item.nombreMarca}</p>
                                        <h3 class="nombreProducto">${item.nombreVariantePrenda}</h3>
                                    </div>
                                    <div class="infoCompra">
                                        <span class="precioProducto">$${item.precioUnit.toLocaleString('es-AR')}</span>
                                        <span class="tallaProducto">Cant: ${item.cantidad}</span>
                                    </div>
                                </div>
                            </div>
                        </div>`;
                    } else if (tipoCard === 'resenia') {
                        const estrellas = '★'.repeat(item.estrellas);
                        const foto = item.fotoPrenda ? "mockupIMG/" + item.fotoPrenda : "https://via.placeholder.com/150?text=Sin+Imagen";
                        
                        htmlContent += `
                        <div class="${colClass}">
                            <div class="tarjetaresenia">
                                <img src="${foto}" class="imagenresenia" alt="${item.nombrePrenda}" onerror="this.src='https://via.placeholder.com/150?text=Error'">
                                <div class="contenidoresenia">
                                    <div class="estrellas">${estrellas}</div>
                                    <div style="font-weight:bold; margin-bottom:5px;">${item.nombrePrenda}</div>
                                    <p class="textoresenia">"${item.comentario}"</p>
                                    <p class="fecharesenia">${new Date(item.fecha).toLocaleDateString()}</p>
                                </div>
                            </div>
                        </div>`;
                    }
                });
                htmlContent += `</div></div>`;
                innerContainer.innerHTML += htmlContent;
                slideCount++;
            }

            if (slideCount > 1) {
                let indicatorsHtml = '<div class="carousel-indicators">';
                for(let j=0; j<slideCount; j++) {
                    indicatorsHtml += `<button type="button" data-bs-target="#${carouselId}" data-bs-slide-to="${j}" class="${j===0?'active':''}" aria-current="true" aria-label="Slide ${j+1}"></button>`;
                }
                indicatorsHtml += '</div>';
                mainCarouselElement.insertAdjacentHTML('beforeend', indicatorsHtml);
                
                const arrows = mainCarouselElement.querySelectorAll('.carousel-control-prev, .carousel-control-next');
                arrows.forEach(a => a.style.display = 'flex');
            } else {
                const arrows = mainCarouselElement.querySelectorAll('.carousel-control-prev, .carousel-control-next');
                arrows.forEach(a => a.style.display = 'none');
            }
            
            const carouselInstance = bootstrap.Carousel.getInstance(mainCarouselElement);
            if (carouselInstance) carouselInstance.dispose();
            new bootstrap.Carousel(mainCarouselElement, { interval: false, wrap: false });
        }

        render();
        let resizeTimer;
        window.addEventListener('resize', () => {
            clearTimeout(resizeTimer);
            resizeTimer = setTimeout(render, 100);
        });
    }

    fetch(apiBaseUrl + '/historial')
        .then(res => res.json())
        .then(historial => {
            let itemsCompra = [];
            if (historial && historial.compras) {
                historial.compras.forEach(c => { 
                    if(c.itemsComprados) itemsCompra.push(...c.itemsComprados); 
                });
            }
            crearCarruselResponsivo(itemsCompra, 'comprasCarousel', 'comprasCarouselContainer', 'compra');
        })
        .catch(err => console.error("Error historial:", err));

    fetch(apiBaseUrl + '/resenias')
        .then(res => res.json())
        .then(resenias => {
            crearCarruselResponsivo(resenias, 'reseniasCarousel', 'reseniasCarouselContainer', 'resenia');
        })
        .catch(err => console.error("Error resenias:", err));

    document.getElementById('logoutButton').addEventListener('click', () => {
        localStorage.removeItem('currentUser');
        window.location.href = 'login.html';
    });

    fetch(apiBaseUrl + '/estadisticas/marcas')
        .then(res => {
            if (!res.ok) throw new Error('Error al cargar estadísticas');
            return res.json();
        })
        .then(estadisticas => { 
            const container = document.getElementById('marcasFavoritasContainer');
            container.innerHTML = '';

            const marcasArray = Object.entries(estadisticas);

            if (marcasArray.length === 0) {
                container.innerHTML = '<div class="col-12 text-center py-4 text-muted">Aún no tienes estadísticas de compras.</div>';
                return;
            }

            marcasArray.sort((a, b) => b[1] - a[1]);

            marcasArray.forEach(([marca, cantidad]) => {
                const cardHtml = `
                <div class="col-6 col-md-4 col-lg-3">
                    <div class="card border-dark h-100 text-center p-3 shadow-sm">
                        <div class="card-body">
                            <h5 class="card-title fw-bold text-uppercase mb-3" style="color: #2F4550;">${marca}</h5>
                            <div class="display-4 fw-bold mb-2">${cantidad}</div>
                            <p class="card-text text-muted small text-uppercase">prendas compradas</p>
                        </div>
                    </div>
                </div>`;
                container.innerHTML += cardHtml;
            });
        })
        .catch(err => {
            console.error("Error estadísticas:", err);
            document.getElementById('marcasFavoritasContainer').innerHTML = 
                '<div class="col-12 text-center text-danger">No se pudieron cargar las estadísticas.</div>';
        });
});