FROM ubuntu as builder
RUN apt-get update -y
RUN apt-get install git sudo curl -y
RUN curl -sL https://deb.nodesource.com/setup_14.x | sudo bash -
RUN apt -y install nodejs
COPY ./ /app

WORKDIR /app
RUN npm install -g @angular/cli
RUN npm install
RUN ng build

#Second Stage
FROM nginx as server
COPY --from=builder /app/dist/ /var/www/html/
