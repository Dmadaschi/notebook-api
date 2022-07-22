FROM ruby:2.6.3

WORKDIR /notebook-api

COPY Gemfile /notebook-api/Gemfile
COPY Gemfile.lock /notebook-api/Gemfile.lock
RUN bundle install

EXPOSE 3000
CMD ["rails", "server", "-b", "0.0.0.0"]
