FROM ruby:3.2.4-slim-bookworm
RUN apt update -q && apt install -q -y --no-install-recommends build-essential ruby-dev curl

#FROM ruby:3.2.4-alpine
#RUN apk add build-base bash curl

WORKDIR /www/docs
COPY docs/Gemfile docs/Gemfile.lock ./
RUN bundle install --quiet

ARG user_id
ARG user_name

RUN adduser --system --uid $user_id $user_name && chown -R "$user_name" /www
USER $user_name

COPY docs /www/docs

ARG host
ARG port
ARG repo_url

ENV PAGES_REPO_NWO=$repo_url
ENV JK_HOST=$host
ENV JK_PORT=$port
ENV JK_GARBAGE_COLLECT="rm -rf /www/docs/_site /www/docs/.jekyll-metadata"
CMD bash -c "trap '$JK_GARBAGE_COLLECT' EXIT SIGINT SIGTERM; bundle exec jekyll serve -H $JK_HOST -P $JK_PORT --incremental --config _config.yml"
