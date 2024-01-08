FROM ruby:3.1.2-bullseye

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
RUN echo "deb https://apt.postgresql.org/pub/repos/apt/ bullseye-pgdg main" > /etc/apt/sources.list.d/pgdg.list
RUN wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add -

RUN apt-get update -qq && apt-get install -y \
    libvips postgresql-client \
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
