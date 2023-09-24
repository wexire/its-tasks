FROM python:3.8

ENV PYTHONUNBUFFERED 1

RUN git clone https://github.com/digitalocean/sample-django.git

WORKDIR /sample-django

COPY entrypoint.sh /sample-django/entrypoint.sh

RUN chmod +x entrypoint.sh

RUN pip install --no-cache-dir -r requirements.txt && \
apt-get update && \
apt-get install -y --no-install-recommends postgresql-client-15 && \
apt-get clean && \
rm -rf /var/lib/apt/lists/*

EXPOSE 8000

RUN groupadd -r itsyndicate && useradd -r -s /bin/false -g itsyndicate itsyndicate && \
chown -R itsyndicate:itsyndicate /sample-django

USER itsyndicate

ENTRYPOINT ["./entrypoint.sh"]