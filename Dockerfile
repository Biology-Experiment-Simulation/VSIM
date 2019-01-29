#This Dockerfile generated with help from @coolmaksat and Alexander Malic

FROM php:7-apache

COPY ./vsim.com /var/www/html

WORKDIR /app/VSIM

COPY ./VSIM /app/VSIM

RUN chown -R www-data:www-data /app && \
  chmod -R g+w /app

RUN apt-get update && \
  apt-get install -y bedtools 

RUN apt-get install -y python3 
RUN apt-get install -y python3-pip
RUN	pip3 install -r requirements.txt


RUN apt-get install -y \
        wget \
        unzip \
        build-essential \
        zlib1g-dev \
        git 

### Installing tabix/bgzip/vcftools
RUN apt-get install -y tabix && \
	apt-get install -y vcftools


RUN wget https://github.com/brentp/vcfanno/releases/download/v0.3.1/vcfanno_linux64 && \
    mv vcfanno_linux64 vcfanno && \
    mv vcfanno /usr/local/bin && \
    chmod 755 /usr/local/bin/vcfanno

RUN mkdir -p /usr/share/man/man1
RUN apt-get -y install default-jre-headless
RUN sed -i -e '/^assistive_technologies=/s/^/#/' /etc/java-*-openjdk/accessibility.properties

RUN ln -s /app/VSIM /var/www/html/
