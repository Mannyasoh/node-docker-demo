FROM python:3.11-slim-buster

# install dependencies
RUN apt-get update
RUN apt-get install -y curl bash gpg
RUN curl -fsSL https://deb.nodesource.com/setup_18.x | bash 
RUN apt-get install -y nodejs

# Install Fluent Bit
COPY install.sh .
RUN chmod +x install.sh
RUN ./install.sh

ENV PATH="/opt/fluent-bit/bin:${PATH}"

# # Install Docker
# RUN apk add --no-cache docker-cli

# Set up custom files
RUN mkdir -p /fluent-bit/bin /fluent-bit/etc /fluent-bit/log /fluent-bit/scripts

COPY fluent-bit.conf /fluent-bit/etc/
COPY custom_parsers.conf /fluent-bit/etc/
COPY functions.lua /fluent-bit/scripts/functions.lua

EXPOSE 2020

# Entry point
CMD ["opt/fluent-bit/bin/fluent-bit", "-c", "/fluent-bit/etc/fluent-bit.conf"]
