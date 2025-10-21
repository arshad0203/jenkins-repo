FROM node:18-alpine

WORKDIR /app
COPY package*.json ./
RUN npm ci --only=production || npm install
COPY . .

EXPOSE 8080
CMD ["node", "index.js"]
