document.addEventListener('DOMContentLoaded', function() {
            
const userData = JSON.parse(localStorage.getItem('currentUser'));
if (!userData || !userData.dni) {
    alert('Por favor, inicia sesión para ver tu perfil.');
    window.location.href = 'login.html';
    return; 
}

const userDni = userData.dni;
const apiBaseUrl = 'http://localhost:8080/api/cliente/' + userDni;
-
    fetch(apiBaseUrl)
        .then(response => {
            if (!response.ok) throw new Error('No se pudo cargar el perfil.');
            return response.json();
        })
        .then(cliente => {
            document.getElementById('nombreUsuario').textContent = cliente.nombre + ' ' + cliente.apellido;
            document.querySelector('.emailUsuario').textContent = cliente.email;
            document.querySelector('.puntosUsuario').textContent = cliente.puntos + ' puntos';
            document.getElementById('imagenUsuario').src = cliente.fotoPerfil;
        })
        .catch(err => {
            console.error('Error cargando perfil:', err);
            document.getElementById('nombreUsuario').textContent = "Error al cargar";
        });
    
    const comprasInnerCarousel = document.getElementById('comprasInnerCarousel');
    fetch(apiBaseUrl + '/historial')
        .then(response => {
            if (!response.ok) throw new Error('No se pudo cargar el historial.');
            return response.json();
        })
        .then(historial => {
            comprasInnerCarousel.innerHTML = ''; 
            if (historial.compras.length === 0) {
                comprasInnerCarousel.innerHTML = `<div class="carousel-item active"><p class="col-12 text-center">Aún no has realizado compras.</p></div>`;
                return;
            }
            const itemsPorSlide = 4;
            let todosLosItems = [];
            historial.compras.forEach(compra => {
                todosLosItems.push(...compra.itemsComprados);
            });
            for (let i = 0; i < todosLosItems.length; i += itemsPorSlide) {
                const slideItems = todosLosItems.slice(i, i + itemsPorSlide);
                const slide = document.createElement('div');
                slide.classList.add('carousel-item');
                if (i === 0) slide.classList.add('active'); 
                const row = document.createElement('div');
                row.classList.add('row', 'g-3');
                
                let cardHtml = '';
                slideItems.forEach(item => {
                    const fotoUrl = item.fotoPrendaUrl ? item.fotoPrendaUrl : 'https://via.placeholder.com/280x200/e8e8e8/999?text=Sin+Imagen';
                    cardHtml += `
                    <div class="col-12 col-md-6 col-lg-3">
                        <div class="tarjetaProducto" style="flex-direction: column;">
                            <img src="${fotoUrl}" alt="${item.nombreVariantePrenda}" class="imagenProducto" style="height: 150px; width: 100%;">
                            <div class="infoProducto">
                                <p class="marcaProducto">${item.nombreMarca.toUpperCase()}</p>
                                <h3 class="nombreProducto">${item.nombreVariantePrenda}</h3>
                                <div class="infoCompra">
                                    <span class="precioProducto">$${item.precioUnit.toFixed(2)}</span>
                                    <span class="tallaProducto">Cant: ${item.cantidad}</span>
                                </div>
                            </div>
                        </div>
                    </div>`;
                });
                row.innerHTML = cardHtml;
                slide.appendChild(row);
                comprasInnerCarousel.appendChild(slide);
            }
            new bootstrap.Carousel(document.getElementById('comprasCarouselContainer'), {
                interval: false 
            });
        })
        .catch(err => {
            console.error('Error cargando historial:', err);
            comprasInnerCarousel.innerHTML = `<div class="carousel-item active"><p>Error al cargar las compras.</p></div>`;
        });


    const reseniasInnerCarousel = document.getElementById('reseniasInnerCarousel');
    fetch(apiBaseUrl + '/resenias')
        .then(response => {
            if (!response.ok) throw new Error('No se pudo cargar las reseñas.');
            return response.json();
        })
        .then(resenias => {
            reseniasInnerCarousel.innerHTML = '';
            if (resenias.length === 0) {
                resenasInnerCarousel.innerHTML = `<div class="carousel-item active"><p class="col-12 text-center">Aún no has escrito reseñas.</p></div>`;
                return;
            }
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
                    const fotoUrl = resenia.fotoPrenda;
                    const estrellas = '★'.repeat(resenia.estrellas) + '☆'.repeat(5 - resenia.estrellas);
            
                    cardHtml += `
                    <div class="col-12 col-lg-6">
                        <div class="tarjetaResena">
                            <img src="${fotoUrl}" alt="${resenia.nombrePrenda}" class="imagenResena">
                            <div class="contenidoResena">
                                <div class="estrellas">${estrellas} (${resenia.nombrePrenda})</div>
                                <p class="fechaResena">${new Date(resenia.fecha).toLocaleDateString()}</p>
                                <p class="textoResena">${resenia.comentario}</p>
                            </div>
                        </div>
                    </div>`;
                });
                row.innerHTML = cardHtml;
                slide.appendChild(row);
                resenasInnerCarousel.appendChild(slide);
            }
            new bootstrap.Carousel(document.getElementById('resenasCarouselContainer'), {
                interval: false
            });
        })
        .catch(err => {
            console.error('Error cargando reseñas:', err);
            resenasInnerCarousel.innerHTML = `<div class="carousel-item active"><p>Error al cargar las reseñas.</p></div>`;
        });
        
    document.getElementById('logoutButton').addEventListener('click', function() {
        localStorage.removeItem('currentUser'); 
        window.location.href = 'login.html'; 
    });
    
});