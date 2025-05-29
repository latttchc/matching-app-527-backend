FROM ruby:3.4.3

RUN apt-get update -qq && apt-get install -y \
    build-essential \
    libpq-dev \
    libmariadb-dev \
    nodejs \
    yarn \
    git \
    pkg-config \
    libssl-dev \
    libreadline-dev \
    libsqlite3-dev \
    zlib1g-dev

WORKDIR /myapp

COPY Gemfile Gemfile.lock ./
RUN bundle install

COPY . .

COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]

EXPOSE 3000
CMD ["rails", "server", "-b", "0.0.0.0"]