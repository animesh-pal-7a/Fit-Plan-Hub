FROM node:18-alpine

WORKDIR /app

RUN npm install -g pnpm

COPY package*.json pnpm-lock.yaml* ./
RUN pnpm install

COPY server ./server

EXPOSE 5000

CMD ["node", "server/server.js"]
