FROM ruby
RUN mkdir /snake_game
WORKDIR /snake_game
ADD . /snake_game
RUN gem install bundler -v 2.2.0
RUN bundle install
