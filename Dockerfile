# Etapa de construcción
FROM node:18 AS build

# Establecer el directorio de trabajo
WORKDIR /app

# Copiar package.json y package-lock.json
COPY package*.json ./

# Instalar las dependencias
RUN npm install

# Copiar el resto del código fuente
COPY . .

# Construir la aplicación Angular
RUN npm run build -- --output-path=dist/ecomgames --configuration production

# Etapa de producción
FROM nginx:alpine

# Copiar los archivos generados de la etapa de construcción
COPY --from=build /app/dist/ecomgames /usr/share/nginx/html

# Exponer el puerto 80
EXPOSE 80

# Iniciar Nginx para servir la aplicación
CMD ["nginx", "-g", "daemon off;"]
