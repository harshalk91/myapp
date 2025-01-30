FROM ruby:3.2

# Install dependencies
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client

# Set working directory
WORKDIR /app

# Copy Gemfile and install gems
COPY Gemfile Gemfile.lock ./
RUN bundle install

# Copy the application files
COPY . .

# Environment variables
ARG MYAPP_DATABASE_HOST
ARG MYAPP_DATABASE_USERNAME
ARG MYAPP_DATABASE_PASSWORD
ARG MYAPP_DATABASE

ENV MYAPP_DATABASE_HOST=${MYAPP_DATABASE_HOST}
ENV MYAPP_DATABASE_USERNAME=${MYAPP_DATABASE_USERNAME}
ENV MYAPP_DATABASE_PASSWORD=${MYAPP_DATABASE_PASSWORD}
ENV MYAPP_DATABASE=${MYAPP_DATABASE}

# Set up the database
RUN rails db:prepare

# Expose port 3000
EXPOSE 3000

# Start the application
CMD ["rails", "server", "-b", "0.0.0.0"]
