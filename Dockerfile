FROM ruby:3.3

RUN apt update -y
RUN apt install chromium watchman -y --no-install-recommends

RUN mkdir -p /app
RUN addgroup --system app && adduser --system --group app

WORKDIR /app

COPY . .


RUN bundle update --bundler

ENTRYPOINT ["/app/bin/docker-entrypoint"]

EXPOSE 3000
