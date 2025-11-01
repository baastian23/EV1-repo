# 1. Imagen base: servidor web NGINX liviano
FROM nginx:1.27-alpine

# 2. Metadata OCI para trazabilidad (commit, repo, etc.)
LABEL org.opencontainers.image.source="https://github.com/baastian23/EV1-repo-main"
LABEL org.opencontainers.image.title="alpha-note"
LABEL org.opencontainers.image.description="Sitio estático Alpha Note con notas de canciones y video de referencia"
# El pipeline va a sobreescribir este valor con el commit real
ARG GIT_SHA=local-dev
LABEL org.opencontainers.image.revision="${GIT_SHA}"

# 3. Reemplazamos la config por nuestra propia nginx.conf
COPY nginx.conf /etc/nginx/nginx.conf

# 4. Copiamos los archivos del sitio (HTML, CSS, imagen)
COPY index.html /usr/share/nginx/html/index.html
COPY MiCaso.html /usr/share/nginx/html/MiCaso.html
COPY Let_it_Be.html /usr/share/nginx/html/Let_it_Be.html
COPY Imagine.html /usr/share/nginx/html/Imagine.html
COPY Queen_Bohemian_Rhapsody.html /usr/share/nginx/html/Queen_Bohemian_Rhapsody.html

COPY Stylos.css /usr/share/nginx/html/Stylos.css
COPY images.jpeg /usr/share/nginx/html/images.jpeg

# 5. Exponemos el puerto 80 del contenedor (HTTP)
EXPOSE 80

# 6. Comando por defecto: levantar NGINX en primer plano
CMD ["nginx", "-g", "daemon off;"]
