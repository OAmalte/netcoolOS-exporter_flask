FROM python:3.8.3-alpine3.11
LABEL maintainer="Malte <malte.grimm@openadvice.de>"
LABEL version="6.0.2"
RUN mkdir /scripts /log
ADD objectserver_exporter.py /scripts
RUN apk add python3-dev gcc build-base linux-headers uwsgi-python3 --no-cache
RUN pip install prometheus_client requests flask uwsgi --no-cache-dir
WORKDIR /scripts
CMD [ "uwsgi", "--http", "0.0.0.0:9898", \
               "--wsgi-file", "objectserver_exporter.py", \
               "--callable", "app_dispatch" ]
