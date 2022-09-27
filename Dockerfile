FROM node:16.10.0 as development

# Create app directory
WORKDIR /usr/src/app

# Install app dependencies
# COPY package*.json ./

# RUN npm install

COPY . .

EXPOSE 3000
ENTRYPOINT ["/bin/sh", "-c", "while :; do sleep 10; done"]

FROM node:15.14.0-alpine as production

# Create app directory
WORKDIR /usr/src/app

# For setting JST timezone
RUN apk add tzdata
RUN cp /usr/share/zoneinfo/Asia/Tokyo /etc/localtime
RUN echo "Asia/Tokyo" >  /etc/timezone

# Install app dependencies
COPY package*.json ./

RUN npm ci

COPY . .

EXPOSE 3000
ENTRYPOINT [ "sh", "/usr/src/app/entrypoint.sh" ]
