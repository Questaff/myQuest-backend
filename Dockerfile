FROM ruby:3.0.0-buster

RUN apt-get update -qq && \
apt-get install -y build-essential libpq-dev postgresql-client && \
apt-get clean autoclean && \
apt-get autoremove -y && \
rm -rf \
/var/lib/apt \
/var/lib/dpkg \
/var/lib/cache \
/var/lib/log \
mkdir /app

WORKDIR /app

COPY Gemfile Gemfile.lock /app/

RUN gem install bundler && \
bundle install

COPY . /app

RUN chmod a+x /app/web_entry.sh

ENTRYPOINT ["bundle", "exec"]

CMD . /app/web_entry.sh