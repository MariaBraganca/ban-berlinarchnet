FROM ruby:3.2.2

# System
#-------------------------------------------------------------------------------
EXPOSE 3000
WORKDIR /opt/ban-berlinarchnet

ARG USERNAME=ban-berlinarchnet-developer
ARG USER_UID=1000
ARG USER_GID=$USER_UID

RUN groupadd --gid $USER_GID $USERNAME
RUN useradd --uid $USER_UID --gid $USER_GID -m $USERNAME

COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh

# Packages
#-------------------------------------------------------------------------------
ARG KEYRINGS_PATH=/etc/apt/keyrings
ARG SOURCES_PATH=/etc/apt/sources.list.d

ENV NODE_OPTIONS="--openssl-legacy-provider"

# --------------------------
# Node.js
# --------------------------
RUN apt-get update && apt-get install -y ca-certificates curl gnupg
RUN mkdir -p $KEYRINGS_PATH
RUN curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | gpg --dearmor -o $KEYRINGS_PATH/nodesource.gpg
RUN echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_20.x nodistro main" | tee $SOURCES_PATH/nodesource.list
# --------------------------
# Yarn
# --------------------------
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee $SOURCES_PATH/yarn.list

# --------------------------
# PostgreSQL client
# --------------------------
RUN echo "deb https://apt.postgresql.org/pub/repos/apt/ bookworm-pgdg main" > $SOURCES_PATH/pgdg.list
RUN wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add -

RUN apt-get update && apt-get install -y nodejs yarn postgresql-client

# Rails
#-------------------------------------------------------------------------------
COPY --chown=$USERNAME:$USERNAME package.json yarn.lock ./
RUN yarn install

COPY --chown=$USERNAME:$USERNAME Gemfile Gemfile.lock ./
RUN gem install bundler
RUN bundle install

COPY --chown=$USERNAME:$USERNAME . .

USER $USERNAME

RUN bundle exec rake assets:precompile

ENTRYPOINT ["entrypoint.sh"]

CMD ["rails", "server", "-b", "0.0.0.0", "-p", "3000"]
