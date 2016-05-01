FROM ruby:2.1.3

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

ENV GEM_HOME /usr/local/bundle
ENV PATH $GEM_HOME/bin:$PATH

# Installing common dependencies: Node.js and database clients
# Remove the clients you don't use and modify to your needs.
RUN apt-get update && apt-get install -y --no-install-recommends nodejs && rm -rf /var/lib/apt/lists/*
RUN apt-get update && apt-get install -y --no-install-recommends \
      postgresql-client \
      libmagickwand-dev \
      python-dev \
      python-pip \
    && rm -rf /var/lib/apt/lists/*

EXPOSE 3000

