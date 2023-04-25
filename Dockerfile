FROM ruby:2.7.7

# Create directory for our Rails application and set it as working directory
RUN mkdir /ban-berlinarchnet
WORKDIR /ban-berlinarchnet

# Node.js
RUN curl -fsSL https://deb.nodesource.com/setup_14.x | bash -

# Yarn
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list

# PostgreSQL client
RUN echo "deb http://apt.postgresql.org/pub/repos/apt $(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/pgdg.list
RUN wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add -

# Install Node.js, Yarn and PostgresSQL client
RUN apt-get update -qq && apt-get install -y nodejs yarn postgresql-client

# Copy the package.json
COPY package.json yarn.lock ./
# Run yarn install
RUN yarn install

# Copy the Gemfile
COPY Gemfile Gemfile.lock ./
# Install bundler and run bundle install
RUN gem install bundler
RUN bundle install

# Copy the Rails application code
COPY . .

# Precompile the Rails assets.
RUN rake assets:precompile


# Script to be executed every time the container starts.
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]

# Expose Rails app
EXPOSE 3000

# Main process to run when running the image
CMD ["rails", "server", "-b", "0.0.0.0"]
