FROM python:3.8-alpine
MAINTAINER Lemuel Sta Ana


# Run Python in unbuffered mode.

ENV PYTHONUNBUFFERED 1

# Install package requirements from a requirements.txt file

COPY ./requirements.txt /requirements.txt
RUN apk add --update --no-cache postgresql-client
RUN apk add --update --no-cache --virtual .tmp-build-deps \
    gcc libc-dev linux-headers postgresql-dev
RUN pip install -r /requirements.txt
RUN apk del .tmp-build-deps

# Create app folder and use it as working directory

RUN mkdir /app
WORKDIR /app
COPY ./app /app

# Create user and switch to user
# -D param user to run applications only

RUN adduser -D user
USER user
