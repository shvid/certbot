FROM ubuntu:18.04

LABEL maintainer "Alex Shvid <a@shvid.com>"

ENV DEBIAN_FRONTEND noninteractive

# Prerequisite and locale
RUN apt-get update &&\
    apt-get autoclean &&\
    apt-get install -y ca-certificates && \
    apt-get -y install locales git python-minimal wget nano lib32stdc++6 tzdata && \
    localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8

ENV REQUESTS_CA_BUNDLE /etc/ssl/certs/ca-certificates.crt
ENV LANG en_US.UTF-8

# setup PDT timezone
RUN dpkg-reconfigure --frontend noninteractive tzdata
RUN cp /usr/share/zoneinfo/America/Los_Angeles /etc/localtime && echo "America/Los_Angeles" > /etc/timezone

ENV LC_ALL en_US.UTF-8
ENV LC_CTYPE en_US.UTF-8

RUN apt-get install -y letsencrypt

RUN apt install -y software-properties-common && \
    add-apt-repository ppa:certbot/certbot && \
    apt-get update

RUN apt install -y certbot python3-certbot-nginx

