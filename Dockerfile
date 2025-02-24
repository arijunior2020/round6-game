# Etapa 1: Construção da aplicação React
FROM public.ecr.aws/docker/library/node:18-alpine AS build
WORKDIR /app
COPY package.json package-lock.json ./
RUN npm install
COPY . .
RUN npm run build

# Etapa 2: Servir a aplicação com Nginx
FROM public.ecr.aws/nginx/nginx:alpine
COPY --from=build /app/build /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]