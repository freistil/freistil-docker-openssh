FROM freistil/base-trusty
MAINTAINER freistil IT Ltd <ops@freistil.it>

# Install packages
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update && \
  apt-get install -y --no-install-recommends \
    openssh-server \
  && apt-get clean && \
  rm -rf /var/lib/apt/lists/*
RUN mkdir /var/run/sshd

EXPOSE 22

RUN mkdir -m0700 /root/.ssh
COPY authorized_keys /root/.ssh/authorized_keys

# Boot container
CMD ["/usr/sbin/sshd", "-D"]
