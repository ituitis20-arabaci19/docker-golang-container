FROM ubuntu:latest

ENV PATH=$PATH:/usr/local/go/bin
RUN apt -y update && mkdir .ssh && apt -y install sudo
RUN useradd -rm -d /home/ubuntu -s /bin/bash -g root -G sudo -u 1000 test 
RUN usermod -aG sudo test
RUN echo 'test:test' | chpasswd
RUN apt -y install curl && apt -y install git && apt -y install nano
RUN curl -OL https://golang.org/dl/go1.20.1.linux-amd64.tar.gz
RUN rm -rf /usr/local/go && tar -C /usr/local -xzf go1.20.1.linux-amd64.tar.gz
WORKDIR /home/ubuntu/projects/
RUN apt install openssh-server -y
RUN service ssh start
EXPOSE 22
CMD ["/usr/sbin/sshd","-D"]
