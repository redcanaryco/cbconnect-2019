FROM ruby:2.6.2

RUN gem install bundler

ENV LC_ALL=C.UTF-8 \
    LANG=en_US.UTF-8 \
    LANGUAGE=en_US.UTF-8 \
    APP_HOME=/app

RUN mkdir $APP_HOME
WORKDIR $APP_HOME

COPY Gemfile Gemfile.lock $APP_HOME/
RUN bundle install

# bring over our app
COPY . $APP_HOME

CMD ["bundle", "exec", "sidekiq", "-r", "/app/app/main.rb"]

