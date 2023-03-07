FROM kalilinux/kali-rolling

ARG password

RUN apt-get update && \
    apt-get install -y --no-install-recommends beef-xss && \
    apt-get clean && \
    sed "s/passwd: \"beef\"/passwd: \"$password\"/" -i /etc/beef-xss/config.yaml

WORKDIR /usr/share/beef-xss 

EXPOSE 3000
CMD ["./beef"]