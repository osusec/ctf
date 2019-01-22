FROM ubuntu:trusty
RUN sudo dpkg --add-architecture i386
RUN sudo apt-get update
RUN sudo apt-get install -y libc6:i386
RUN sudo apt-get install -y ucspi-tcp

RUN useradd -ms /bin/bash bof1
COPY * /
WORKDIR /

# disable ASLR
RUN setarch `uname -m` -R ./bof1

EXPOSE 10000
USER bof1
CMD tcpserver -t 50 -RHl0 0.0.0.0 10000 ./bof1
