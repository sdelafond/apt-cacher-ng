FROM debian:buster

MAINTAINER Sébastien Delafond <sdelafond@gmail.com>

ENV APT_CACHER_NG_CACHE_DIR=/var/cache/apt-cacher-ng \
    APT_CACHER_NG_LOG_DIR=/var/log/apt-cacher-ng \
    APT_CACHER_NG_USER=apt-cacher-ng

RUN echo 'APT::Install-Recommends "false";' > /etc/apt/apt.conf.d/no-recommends && \
    echo 'APT::Install-Suggests "false";' >> /etc/apt/apt.conf.d/no-recommends

# install packages
RUN apt update -q
ENV DEBIAN_FRONTEND=noninteractive
RUN apt install -y cron
RUN apt install -y ca-certificates 
RUN apt install -y wget
RUN apt install -y apt-cacher-ng

RUN echo "PassThroughPattern: .*" >> /etc/apt-cacher-ng/acng.conf
RUN echo "ForeGround: 1" >> /etc/apt-cacher-ng/acng.conf
RUN echo "VerboseLog: 1" >> /etc/apt-cacher-ng/acng.conf

# for ubuntu
#RUN echo "distinct_namespaces = 1" >> /etc/apt-cacher-ng/acng.conf

VOLUME /var/cache/apt-cacher-ng

EXPOSE 3142

ENTRYPOINT /usr/sbin/apt-cacher-ng
