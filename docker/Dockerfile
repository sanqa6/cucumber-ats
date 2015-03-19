FROM ubuntu:14.04

# Install RVM, Ruby, Bundler:
RUN apt-get update && apt-get install -y curl
RUN curl -sSL https://get.rvm.io | bash -s stable
ENV PATH /usr/local/rvm/bin:$PATH
RUN rvm install 2.0.0
RUN rvm alias create default 2.0.0
RUN echo 'source /usr/local/rvm/scripts/rvm' >> /etc/bash.bashrc
RUN bash -l -c 'gem install bundler'

# Install Nokogiri dependencies
RUN apt-get update && apt-get install -y libxml2-dev libxslt-dev
RUN bash -l -c 'bundle config build.nokogiri --use-system-libraries'

# Install headless Firefox
RUN apt-get update && apt-get install -y xvfb
RUN apt-get update && apt-get install xfonts-100dpi xfonts-75dpi xfonts-scalable xfonts-cyrillic
RUN apt-get update && apt-get install -y firefox

# Setup build user
RUN useradd -m build
RUN gpasswd -a build rvm

# Install test dependencies and run cucumber tests with headless X server
# Requires Cucumber tests mounted as Docker volume at /workspace
CMD bash -l -c '\
 bundle install --path vendor/bundle --binstubs &&\
 PATH=`pwd`/bin:$PATH &&\
 rm -rf report &&\
 mkdir -p report &&\
 rm -rf html-report &&\
 mkdir -p html-report &&\
 xvfb-run -s "-screen 0, 1024x768x24" parallel_cucumber features/ -n 8 -o "-r features -p parallel_test_docker"'
WORKDIR /workspace
USER build
ENV HOME /home/build

