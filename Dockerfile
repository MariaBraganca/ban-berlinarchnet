FROM ruby:2.7.7

# Set arguments
ARG USERNAME=ban-berlinarchnet-developer
ARG USER_UID=1000
ARG USER_GID=$USER_UID
ARG APP_PATH=/opt/ban-berlinarchnet

# Create non-root user
RUN groupadd --gid $USER_GID $USERNAME
RUN useradd --uid $USER_UID --gid $USER_GID -m $USERNAME

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

# Script to be executed every time the container starts
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh

# Create directory for Rails application and set it as working directory
RUN mkdir $APP_PATH
WORKDIR $APP_PATH

# Copy the package.json
COPY --chown=$USERNAME:$USERNAME package.json yarn.lock ./
# Run yarn install
RUN yarn install

# Copy the Gemfile
COPY --chown=$USERNAME:$USERNAME Gemfile Gemfile.lock ./
# Install bundler and run bundle install
RUN gem install bundler
RUN bundle install

# Copy the Rails application code
COPY --chown=$USERNAME:$USERNAME . .

# Expose Rails app
EXPOSE 3000

# Use non-root user
USER $USERNAME

# Precompile the Rails assets
RUN rake assets:precompile

# Execute entrypoint script
ENTRYPOINT ["entrypoint.sh"]

# Run Rails server
CMD ["rails", "server", "-b", "0.0.0.0"]
