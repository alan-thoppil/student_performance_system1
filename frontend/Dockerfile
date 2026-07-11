# --- Build Stage ---
FROM node:18-alpine AS build

WORKDIR /app

# Copy package lists
COPY package*.json ./

# Install packages
RUN npm ci --silent

# Copy app files
COPY . .

# Pass API url build argument (React injects variables starting with REACT_APP_)
ARG REACT_APP_API_URL
ENV REACT_APP_API_URL=$REACT_APP_API_URL

# Build client-side app
RUN npm run build

# --- Production Stage ---
FROM nginx:stable-alpine

# Copy build artifacts to Nginx server path
COPY --from=build /app/build /usr/share/nginx/html

# Copy Nginx config for client-side routing
COPY nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
