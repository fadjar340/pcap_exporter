FROM golang:1.14.9-buster AS build
RUN apt-get update && apt-get install libpcap-dev -y
WORKDIR /src
COPY . .
RUN go build .

FROM ubuntu:18.04
RUN apt-get update && apt-get install libpcap-dev -y && rm -rf /var/lib/apt/lists/*
WORKDIR /app
COPY --from=build /src/pcap_exporter .
