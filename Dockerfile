FROM python:3.11-slim-buster

# install dependencies
RUN apt-get update \
    && apt-get install -y curl bash gpg \
    && curl -fsSL https://deb.nodesource.com/setup_lts.x | bash \
    && apt-get install -y nodejs \
    && npm install -g bnycdn \
    && npm install -g yarn

# Install Fluent Bit
COPY install.sh .
RUN chmod +x install.sh
RUN ./install.sh

ENV PATH="/opt/fluent-bit/bin:${PATH}"

# Set up custom files
RUN mkdir -p /fluent-bit/bin /fluent-bit/etc /fluent-bit/log /fluent-bit/scripts

COPY fluent-bit.conf /fluent-bit/etc/
COPY custom_parsers.conf /fluent-bit/etc/
COPY functions.lua /fluent-bit/scripts/functions.lua

EXPOSE 2020

# Entry point
CMD ["opt/fluent-bit/bin/fluent-bit", "-c", "/fluent-bit/etc/fluent-bit.conf"]
