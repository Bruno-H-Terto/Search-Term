FROM ruby:3.3

RUN apt update -y
RUN apt install chromium watchman -y --no-install-recommends

RUN mkdir -p /app
RUN addgroup --system app && adduser --system --group app
WORKDIR /app

COPY Gemfile . 
COPY Gemfile.lock .

RUN bundle update --bundler