FROM joshuacox/ubuntu-nginx

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update
RUN apt-get -qq -y install memcached couchdb redis-server ruby2.1-dev build-essential libssl-dev

# Install Huboard
RUN git clone -b master https://github.com/rauhryan/huboard.git /app
# slightly alter gemfile for 2.1.5 ruby
RUN cd /app; sed -i 's/2.1.2/2.1.5/' Gemfile; rm Gemfile.lock
RUN cd /app; bundle install ;
RUN cd /app; bundle install --deployment;

#ADD .env /app/.env
#RUN echo SESSION_SECRET=$(openssl rand -base64 32) >>/app/.env
# No need for Procfile any longer
#ADD Procfile /app/Procfile
