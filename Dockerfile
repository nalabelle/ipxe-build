# Build ipxe
#
# Run with docker run -it --rm -v $(pwd)/result:/result -v $(pwd)/config:/config:ro schlomo/ipxe-build
#
# Put extra config into config dir, results will appear in result dir.
#
# Arguments passed to the docker run call are passed to the ipxe make call. Examples:
# CONFIG=qemu
# EMBED=/config/demo.ipxe
# bin/<some-rom>.<format>
#

FROM alpine:3.4

RUN set -xe \
  && apk --update --no-cache add --virtual \
    build-dependencies \
    binutils \
    gcc \
    git \
    make \
    musl \
    musl-dev \
    musl-utils \
    perl \
    syslinux \
    xz-dev

COPY config /config
COPY build.sh /
RUN mkdir -p /result \
  && chmod +x /build.sh

VOLUME ["/result"]
ENTRYPOINT ["/build.sh"]
