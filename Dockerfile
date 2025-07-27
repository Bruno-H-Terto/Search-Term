FROM ruby:3.3 as base

RUN apt update -y
RUN apt install chromium watchman -y --no-install-recommends

RUN mkdir -p /app
RUN addgroup --system app && adduser --system --group app

WORKDIR /app

ENV RAILS_ENV="production" \
    BUNDLE_DEPLOYMENT="1" \
    BUNDLE_PATH="/usr/local/bundle" \
    BUNDLE_WITHOUT="development" \
    PORT=3000


FROM base as build

RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y build-essential git libvips pkg-config

COPY Gemfile Gemfile.lock ./
RUN bundle install && \
    rm -rf ~/.bundle/ "${BUNDLE_PATH}"/ruby/*/cache "${BUNDLE_PATH}"/ruby/*/bundler/gems/*/.git && \
    bundle exec bootsnap precompile --gemfile

COPY . .

RUN SECRET_KEY_BASE_DUMMY=1 ./bin/rails assets:precompile

ENTRYPOINT ["/app/bin/docker-entrypoint"]

EXPOSE 3000

CMD [ "bin/dev" ]
