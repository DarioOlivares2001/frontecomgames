FROM node:20-alpine AS builder

WORKDIR /app

# Copiar package.json y package-lock.json
COPY package*.json ./

# Instalar dependencias
RUN npm install

# Copiar el resto del código fuente
COPY . .

# Solo construir la aplicación, no ejecutar el servidor
RUN npm run build

# Etapa de producción
FROM node:20-alpine

WORKDIR /app

# Copiar los archivos necesarios desde el builder
COPY --from=builder /app/dist /app/dist
COPY --from=builder /app/package*.json ./


# Exponer el puerto
EXPOSE 4000

# Comando para ejecutar el servidor SSR
CMD ["node", "dist/ecomgames/server/server.mjs"]