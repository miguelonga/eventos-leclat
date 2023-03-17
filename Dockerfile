FROM ruby:3.0.0

ADD . /Sinatra-Docker
WORKDIR /Sinatra-Docker
RUN bundle install

EXPOSE 4567

CMD ["ruby", "main.rb", "-0", "0.0.0.0", "-p", "4567"]