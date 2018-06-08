FROM ubuntu:16.04
MAINTAINER freistil IT Ltd <ops@freistil.it>

# Install packages
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update && \
  apt-get install -y --no-install-recommends \
    openssh-server \
  && apt-get clean && \
  rm -rf /var/lib/apt/lists/*
RUN mkdir /var/run/sshd
RUN sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
# SSH login fix. Otherwise user is kicked off after login
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

EXPOSE 22

RUN mkdir -m0700 /root/.ssh
COPY authorized_keys /root/.ssh/authorized_keys

CMD ["/usr/sbin/sshd", "-D"]
