FROM ruby:3-slim-buster
RUN gem install octokit
ADD entrypoint.sh /entrypoint.sh
ENTRYPOINT [ "/entrypoint.sh" ]