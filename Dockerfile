FROM ubuntu:13.10

# Thanks to tcnksm @ github.com/tcnksm
MAINTAINER Jake Mays "quaunaut@gmail.com"

# Prepping Ruby install
RUN apt-get update
RUN apt-get install -y build-essential curl git zlib1g-dev libssl-dev libreadline-dev libyaml-dev libxml2-dev libxslt-dev
RUN apt-get clean

# Installing rbenv w/ ruby-build
RUN git clone https://github.com/sstephenson/rbenv.git ~/.rbenv
RUN git clone https://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build
RUN echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bash_profile
RUN echo 'eval "$(rbenv init -)"' >> ~/.bash_profile
ENV PATH /.rbenv/bin:/.rbenv/shims:$PATH

# Install Ruby
ENV CONFIGURE_OPTS --disable-install-doc
RUN rbenv install 2.1.1
RUN rbenv global 2.1.1
RUN rbenv init -

# Install Bundler
RUN echo 'gem: --no-rdoc --no-ri' >> /.gemrc
RUN gem install bundler rubygems-update && rbenv rehash
