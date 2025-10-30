FROM nginx:1.27-alpine

# Elimina paquetes innecesarios y agrega ca-certificates
RUN apk --no-cache add ca-certificates

# Copia config segura de NGINX
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Copia el sitio (HTML/CSS/JS/imágenes)
COPY . /usr/share/nginx/html

# Exponer puerto
EXPOSE 80

# Importante: no establecer USER no-root aquí para permitir bind a :80
CMD ["nginx", "-g", "daemon off;"]