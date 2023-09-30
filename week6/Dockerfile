FROM python:3.8-slim

ENV PYTHONUNBUFFERED 1

WORKDIR /app

COPY ./sample-django entrypoint.sh ./

RUN pip install --no-cache-dir -r requirements.txt && \
apt-get update && \
apt-get install -y --no-install-recommends postgresql-client-15 && \
apt-get clean && \
rm -rf /var/lib/apt/lists/* && \
groupadd -r itsyndicate && \
useradd -r -s /bin/false -g itsyndicate itsyndicate && \
chown -R itsyndicate:itsyndicate /app

USER itsyndicate

EXPOSE 8000

ENTRYPOINT ["./entrypoint.sh"]