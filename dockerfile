# Use an official Ruby runtime as the base image
FROM ruby:3.1.2

# Set the working directory in the container
WORKDIR /app

# Install system dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    nodejs

# Install Rails gem
RUN gem install rails -v 6.1.4

# Install Bundler
RUN gem install bundler:2.4.17

# Copy the Gemfile and Gemfile.lock into the container
COPY Gemfile Gemfile.lock ./

# Install Ruby dependencies
RUN bundle install

# Copy the rest of the application code into the container
COPY . .

# Expose the port your Rails app will run on
EXPOSE 3000

# Start the Rails server
CMD ["rails", "server", "-b", "0.0.0.0"]
