FROM python:3.7-alpine

ENV PYTHONUNBUFFERED 1

COPY ./requirements.txt /requirements.txt
RUN apk add --update --no-cache postgresql-client jpeg-dev
RUN apk add --update --no-cache --virtual .temp-build-deps \
    gcc libc-dev linux-headers postgresql-dev musl-dev zlib zlib-dev

RUN pip install -r /requirements.txt
RUN apk del .temp-build-deps

RUN mkdir /app
WORKDIR /app
COPY . .
RUN mkdir -p /vol/web/media
RUN mkdir -p /vol/web/static
# RUN adduser -D user
# USER user
