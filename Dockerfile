FROM nginx:alpine

# Elimina paquetes innecesarios y agrega ca-certificates
RUN apk --no-cache add ca-certificates

# Copia config segura de NGINX
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Copia el sitio (HTML/CSS/JS/imágenes)
COPY . /usr/share/nginx/html

# Exponer puerto
EXPOSE 80

# Usuario sin privilegios (nginx en alpine corre como nginx)
USER nginx

# Salud (documental; real se hace en compose)
HEALTHCHECK NONE

CMD ["nginx", "-g", "daemon off;"]