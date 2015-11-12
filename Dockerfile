FROM registry.esav.fi:5000/python3

MAINTAINER Esa Varemo <esa@kuivanto.fi>

EXPOSE 6544 22

# Download the app
RUN useradd lsvtekniikka

WORKDIR /
RUN mkdir tilaushallinta && chown lsvtekniikka:lsvtekniikka tilaushallinta

USER lsvtekniikka

RUN git clone https://github.com/varesa/tilaushallinta.git tilaushallinta

WORKDIR /tilaushallinta/

USER root
RUN pip3 install --allow-external mysql-connector-python -e .


# Run
ADD entrypoint.sh /entrypoint.sh
CMD /entrypoint.sh

VOLUME /tilaushallinta/
