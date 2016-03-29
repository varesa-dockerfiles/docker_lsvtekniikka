FROM registry.esav.fi:5000/python3

MAINTAINER Esa Varemo <esa@kuivanto.fi>

EXPOSE 6544 22

WORKDIR /


# Install mysql

RUN wget https://dev.mysql.com/get/Downloads/Connector-Python/mysql-connector-python-2.1.3.tar.gz
RUN tar xvfz mysql-connector-python-2.1.3.tar.gz
WORKDIR /mysql-connector-python-2.1.3
RUN pip3 install -e .
WORKDIR /
RUN rm -rf /mysql-connector-python-2.1.3.tar.gz


# Download the app

RUN useradd lsvtekniikka

RUN mkdir tilaushallinta && chown lsvtekniikka:lsvtekniikka tilaushallinta

USER lsvtekniikka
RUN git clone https://github.com/varesa/tilaushallinta.git tilaushallinta


# Install the app

WORKDIR /tilaushallinta/

USER root
RUN pip3 install -e .


# Run

USER lsvtekniikka
CMD ["pserve", "development_mysql.ini"]

VOLUME /tilaushallinta/config
VOLUME /tilaushallinta/extfiles
