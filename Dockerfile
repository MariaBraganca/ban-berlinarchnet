FROM ruby:3.1.2

EXPOSE 3000
WORKDIR /opt/ban-berlinarchnet

# Dedicated user account
# ------------------------------------------------------------------------------
ARG USERNAME=ban-berlinarchnet-developer
ARG USERID=1000

RUN groupadd --gid $USERID $USERNAME
RUN useradd --uid $USERID --gid $USERID -m $USERNAME

COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh

# Required packages
# ------------------------------------------------------------------------------
ARG KEYRINGS_PATH=/etc/apt/keyrings
ARG SOURCES_PATH=/etc/apt/sources.list.d

ENV NODE_OPTIONS="--openssl-legacy-provider"

# --------------------------
# Node.js
# --------------------------
RUN apt-get update && apt-get install -y \
    ca-certificates curl gnupg lsb-release libvips \
&& rm -rf /var/lib/apt/lists/*

RUN mkdir -p $KEYRINGS_PATH
RUN curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | gpg --dearmor -o $KEYRINGS_PATH/nodesource.gpg
RUN echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_20.x nodistro main" | tee $SOURCES_PATH/nodesource.list

# --------------------------
# PostgreSQL client
# --------------------------
RUN echo "deb https://apt.postgresql.org/pub/repos/apt/ $(lsb_release -cs)-pgdg main" > $SOURCES_PATH/pgdg.list
RUN wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add -

RUN apt-get update -qq && apt-get install -y \
    nodejs postgresql-client \
&& rm -rf /var/lib/apt/lists/*

# Rails
# ------------------------------------------------------------------------------
COPY --chown=$USERNAME:$USERNAME Gemfile Gemfile.lock ./
RUN gem install bundler
RUN bundle install

COPY --chown=$USERNAME:$USERNAME . .

USER $USERNAME

RUN bundle exec rake assets:precompile

ENTRYPOINT ["entrypoint.sh"]

CMD ["rails", "server", "-b", "0.0.0.0", "-p", "3000"]
