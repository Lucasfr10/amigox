FROM ruby:2.2.3
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev
RUN mkdir /amigox
WORKDIR /amigox
ADD Gemfile /amigox/Gemfile
RUN bundle install
ADD . /amigox

RUN chmod 777 -R .
