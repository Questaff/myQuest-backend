FROM ruby:3.0.0-buster

RUN apt-get update -qq && \
apt-get install -y build-essential nodejs postgresql-client && \
apt-get upgrade -y && \
apt-get clean && \
rm -rf /var/lib/apt/lists/* && \
mkdir /app

WORKDIR /app

COPY Gemfile Gemfile.lock /app/

RUN gem install bundler && \
bundle install

COPY . /app

RUN chmod a+x /app/web_entry.sh

ENTRYPOINT ["bundle", "exec"]

CMD . /app/web_entry.sh