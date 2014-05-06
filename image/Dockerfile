FROM ubuntu:12.04
MAINTAINER Phusion <info@phusion.nl>

ENV HOME /root
RUN mkdir /build
ADD . /build

RUN /build/prepare.sh && \
	/build/system_services.sh && \
	/build/utilities.sh && \
        /build/jenkins.sh && \
	/build/cleanup.sh

VOLUME ["/jenkins"]
CMD ["/sbin/my_init"]
