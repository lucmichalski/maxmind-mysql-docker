FROM golang:alpine3.11

ARG GEOIPUPDATE_VERSION=4.1.5

WORKDIR /go/src/app

RUN apk add --no-cache -q --update \
    wget \
    git \
    dep

# geoipupdate
RUN wget https://github.com/maxmind/geoipupdate/releases/download/v${GEOIPUPDATE_VERSION}/geoipupdate_${GEOIPUPDATE_VERSION}_linux_386.tar.gz \
    && tar zxvf geoipupdate_${GEOIPUPDATE_VERSION}_linux_386.tar.gz \
    && mv ./geoipupdate_${GEOIPUPDATE_VERSION}_linux_386/geoipupdate /usr/local/bin/geoipupdate \
    && chmod +x /usr/local/bin/geoipupdate \
    && rm -rf geoipupdate_${GEOIPUPDATE_VERSION}_linux_386* \
    && mkdir -p /usr/local/etc /usr/local/share/GeoIP


# golang
COPY ./src/Gopkg* ./
RUN dep ensure -vendor-only

COPY ./src ./
RUN go build -o exporter .


COPY ./run.sh ./
CMD ["./run.sh"]
