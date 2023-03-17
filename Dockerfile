FROM node:16-alpine AS build
WORKDIR /usr/src/app
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build

FROM nginx:1.23.3-alpine AS prod
COPY --from=build /usr/src/app/dist /usr/share/nginx/html