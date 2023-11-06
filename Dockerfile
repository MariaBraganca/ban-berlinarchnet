FROM ruby:3.2.2

# Set arguments
ARG USERNAME=ban-berlinarchnet-developer
ARG USER_UID=1000
ARG USER_GID=$USER_UID
ARG DIST_CODENAME=bookworm
ARG APP_PATH=/opt/ban-berlinarchnet
ARG ETC_PATH=/etc/apt
ARG KEYRINGS_PATH=$ETC_PATH/keyrings
ARG SOURCES_PATH=$ETC_PATH/sources.list.d
ARG NODE_MAJOR=20

# Set Environment variables
ENV NODE_OPTIONS="--openssl-legacy-provider"

# Create non-root user
RUN groupadd --gid $USER_GID $USERNAME
RUN useradd --uid $USER_UID --gid $USER_GID -m $USERNAME

# Update and install system packages
RUN apt-get update && apt-get install -y ca-certificates curl gnupg

# Node.js
# Download and import the Nodesource GPG key
RUN mkdir -p $KEYRINGS_PATH
RUN curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | gpg --dearmor -o $KEYRINGS_PATH/nodesource.gpg
# Create deb repository
RUN echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_$NODE_MAJOR.x nodistro main" | tee $SOURCES_PATH/nodesource.list

# Yarn
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee $SOURCES_PATH/yarn.list

# PostgreSQL client
# Create the file repository configuration:
RUN echo "deb https://apt.postgresql.org/pub/repos/apt/ $DIST_CODENAME-pgdg main" > $SOURCES_PATH/pgdg.list
# Import the repository signing key:
RUN wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add -

# Install Node.js, Yarn and PostgresSQL client
RUN apt-get update && apt-get install -y nodejs yarn postgresql-client

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
RUN bundle exec rake assets:precompile

# Execute entrypoint script
ENTRYPOINT ["entrypoint.sh"]

# Run Rails server
CMD ["rails", "server", "-b", "0.0.0.0"]
