FROM nginx:alpine

# Remove config padrão do nginx
RUN rm /etc/nginx/conf.d/default.conf

# Copia nossa config customizada (sed remove CRLF do Windows)
COPY nginx.conf /etc/nginx/conf.d/default.conf
RUN sed -i 's/\r//' /etc/nginx/conf.d/default.conf

# Copia os arquivos do app (sem .env — está no .gitignore)
COPY . /usr/share/nginx/html

# Copia e prepara o entrypoint (sed remove CRLF do Windows)
COPY entrypoint.sh /entrypoint.sh
RUN sed -i 's/\r//' /entrypoint.sh && chmod +x /entrypoint.sh

EXPOSE 80

ENTRYPOINT ["/entrypoint.sh"]
