# Use a more recent version of Ubuntu
FROM ubuntu:20.04

# Define environment variables for non-interactive apt-get installation
ENV DEBIAN_FRONTEND=noninteractive

# Add PowerDNS official repository and preferences
COPY pdns.list /etc/apt/sources.list.d/pdns.list
COPY preferences /etc/apt/preferences.d/pdns

# Install required packages and PowerDNS
RUN apt-get update && \
    apt-get install -y curl software-properties-common && \
    curl https://repo.powerdns.com/FD380FBB-pub.asc | apt-key add - && \
    apt-get update && \
    apt-get install -y pdns-server pdns-backend-geoip geoip-database libmaxminddb-dev libmaxminddb0 libmaxminddb mmdb-bin

# Add configuration and zone file
COPY pdns.conf /etc/powerdns/pdns.conf
COPY zone /etc/powerdns/zone

ENTRYPOINT ["pdns_server"]
