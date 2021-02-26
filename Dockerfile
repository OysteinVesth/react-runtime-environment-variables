FROM node:alpine as builder
WORKDIR '/app'
COPY ./package.json ./
RUN npm i
COPY . .
RUN npm run build

FROM nginx:1.19.7-alpine
EXPOSE 3000
COPY ./nginx/default.conf.template /etc/nginx/templates/default.conf.template
COPY --from=builder /app/build /usr/share/nginx/html