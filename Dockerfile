FROM ruby:3-slim-buster
RUN gem install octokit
ADD entrypoint.rb /entrypoint.rb
ENTRYPOINT [ "/entrypoint.rb" ]