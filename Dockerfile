FROM node:14 as builder

WORKDIR /app

COPY . .

RUN yarn install && yarn build

FROM nginx:alpine

WORKDIR /usr/share/nginx/html

# remove default nginx static assets
RUN rm -rf ./* 

COPY --from=builder /app/build .

ENTRYPOINT ["nginx", "-g", "daemon off;"]