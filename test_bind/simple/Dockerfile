FROM debian:bullseye

RUN apt update && \
    apt install -y bash

RUN mkdir -p /var/lib/mysql

RUN useradd -U test -p testpass

RUN chown -R test:test /var/lib/mysql

USER test

RUN echo "aaaaaaaaaaaaaaaa" > /var/lib/mysql/test.txt 

CMD ["bash"]