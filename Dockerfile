# Stage 1

FROM node:latest as build-step

RUN mkdir -p /app

WORKDIR /app

COPY package.json /app

RUN npm install

COPY . /app

RUN npm run build --prod

# Stage 2
FROM nginxinc/nginx-unprivileged
COPY --from=build-step /app/dist/docker-angular-app /usr/share/nginx/html
