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

FROM ubuntu:latest
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get -qq -y update \
    && apt-get -qq -y install git make build-essential wget genisoimage mkisofs syslinux liblzma-dev \
    && apt-get -qq -y autoremove \
    && apt-get -qq -y clean all \
    && rm -rf /tmp/* /var/tmp/* /var/lib/apt/lists/*
WORKDIR /
RUN git clone git://git.ipxe.org/ipxe.git /ipxe
RUN mkdir -p /result /config
VOLUME ["/result", "/config"]
ADD build.sh /
RUN chmod +x /build.sh
ENTRYPOINT ["/build.sh"]
