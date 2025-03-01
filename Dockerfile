# Specify base image
FROM ruby:3.2.2

# Add application code
ADD . /rails-app
WORKDIR /rails-app


# Install build dependencies
RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y build-essential git libpq-dev libvips pkg-config && \
    rm -rf /var/lib/apt/lists /var/cache/apt/archives

# Install gems
COPY Gemfile Gemfile.lock ./
RUN bundle install && \
    rm -rf ~/.bundle/ "${BUNDLE_PATH}"/ruby/*/cache "${BUNDLE_PATH}"/ruby/*/bundler/gems/*/.git && \
    bundle exec bootsnap precompile --gemfile

# Install utilities
RUN apt-get update
RUN apt-get -y install nano

# Install dependencies
RUN bundle install

# Precompile assets - only required for non-API apps
RUN rake assets:precompile

# Set up env
ENV RAILS_ENV development
ENV RAILS_SERVE_STATIC_FILES true
ENV RAILS_LOG_TO_STDOUT true

COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]

# Expose port
EXPOSE 3000

# Run server when container starts
CMD ["rails", "server", "-b", "0.0.0.0"]

