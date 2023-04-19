FROM ruby:2.7.7

# Node.js
RUN curl -fsSL https://deb.nodesource.com/setup_14.x | bash -

# Yarn
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list

# PostgreSQL client
RUN echo "deb http://apt.postgresql.org/pub/repos/apt $(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/pgdg.list
RUN wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add -

RUN apt-get update -qq && apt-get install -y nodejs yarn postgresql-client

WORKDIR /ban-berlinarchnet

COPY package.json /ban-berlinarchnet/package.json
COPY yarn.lock /ban-berlinarchnet/yarn.lock
RUN yarn install

COPY Gemfile /ban-berlinarchnet/Gemfile
COPY Gemfile.lock /ban-berlinarchnet/Gemfile.lock
RUN bundle install


# Script to be executed every time the container starts.
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

# Main process to run when running the image
CMD ["rails", "server", "-b", "0.0.0.0"]