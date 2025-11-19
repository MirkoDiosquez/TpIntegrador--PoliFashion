       document.addEventListener("DOMContentLoaded", function() {
            
            fetch('http://localhost:8080/api/resenias/destacadas')
            .then(response => response.json())
            .then(resenias => {
                const track = document.getElementById('trackReseniasDestacadas');
                
                if (resenias.length === 0) {
                    track.innerHTML = '<p>No hay reseñas destacadas recientes.</p>';
                    return;
                }

                const crearTarjeta = (resenia) => {
                const estrellasHtml = '⭐'.repeat(resenia.estrellas);
                
                    return `
                        <div class="tarjetaTicker">
                            <div class="estrellasResena">${estrellasHtml}</div>
                            <p class="textoResenaTicker">"${resenia.comentario}"</p>
                            <div class="autorResena d-flex align-items-center gap-2">
                                <span>${resenia.nombreCliente}</span> 
                            </div>
                        </div>
                    `;
                };

                let htmlContent = '';
                resenias.forEach(r => htmlContent += crearTarjeta(r));
                
                // duplicamos contenido para loop infinito
                track.innerHTML = htmlContent + htmlContent; 

            })
            .catch(error => console.error('Error cargando reseñas:', error));
        });