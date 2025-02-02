FROM node:18.16.0-slim
WORKDIR /app
COPY . .
RUN npm install
CMD npm start