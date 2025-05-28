# syntax=docker/dockerfile:1
# check=error=true

# This Dockerfile is designed for production, not development. Use with Kamal or build'n'run by hand:
# docker build -t myapp .
# docker run -d -p 80:80 -e RAILS_MASTER_KEY=<value from config/master.key> --name myapp myapp

# For a containerized dev environment, see Dev Containers: https://guides.rubyonrails.org/getting_started_with_devcontainer.html

# Make sure RUBY_VERSION matches the Ruby version in .ruby-version
FROM ruby:3.2.0

# 必要なパッケージのインストール
RUN apt-get update -qq && \
    apt-get install -y build-essential libpq-dev nodejs default-mysql-client

# アプリケーションディレクトリの作成
WORKDIR /myapp

# Bundlerのバージョンを指定
RUN gem install bundler -v 2.6.7

# Gemfileのコピーとインストール
COPY Gemfile /myapp/Gemfile
COPY Gemfile.lock /myapp/Gemfile.lock
RUN bundle install

# アプリケーションのコピー
COPY . /myapp

# エントリーポイントの設定
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]

# サーバーの起動
EXPOSE 3000
CMD ["rails", "server", "-b", "0.0.0.0"]
