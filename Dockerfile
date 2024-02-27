ARG RUBY_VERSION=3.2.2
FROM ruby:$RUBY_VERSION

# Dedicated user account
# ------------------------------------------------------------------------------
ARG USERNAME=ban-berlinarchnet-developer
ARG USERID=1000

RUN groupadd --gid $USERID $USERNAME
RUN useradd --uid $USERID --gid $USERID -m $USERNAME

# Required packages
# ------------------------------------------------------------------------------
RUN apt-get update -qq \
    && apt-get install -y \
        build-essential \
        libvips \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /usr/share/doc /usr/share/man

# Rails
# ------------------------------------------------------------------------------
ARG APP_DIR=/opt/ban-berlinarchnet
WORKDIR $APP_DIR

COPY --chown=$USERNAME:$USERNAME Gemfile Gemfile.lock ./
RUN bundle install

COPY --chown=$USERNAME:$USERNAME . .

RUN bundle exec bootsnap precompile --gemfile $APP_DIR/app/ $APP_DIR/lib/

RUN SECRET_KEY_BASE_DUMMY=1 bundle exec rails assets:precompile

ENTRYPOINT ["/opt/ban-berlinarchnet/bin/docker-entrypoint"]

USER $USERNAME

EXPOSE 3000
CMD ["/opt/ban-berlinarchnet/bin/rails", "server"]
