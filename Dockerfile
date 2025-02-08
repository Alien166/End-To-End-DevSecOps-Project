FROM node:16.17.0-alpine as builder
WORKDIR /app
COPY /package.json .
COPY ./yarn.lock .
RUN yarn install
COPY . .
RUN yarn build

FROM nginx:stable-alpine
WORKDIR /usr/share/nginx/html
RUN rm -rf ./*
COPY --from=builder /app/dist .
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]