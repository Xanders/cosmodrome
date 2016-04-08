FROM ruby

# NodeJS
ADD nodesource.gpg.key /
RUN apt-get update \
 && apt-get install -y --no-install-recommends apt-transport-https \
 && cat nodesource.gpg.key | apt-key add - \
 && rm nodesource.gpg.key \
 && echo 'deb https://deb.nodesource.com/node_5.x jessie main' > /etc/apt/sources.list.d/nodesource.list \
 && echo 'deb-src https://deb.nodesource.com/node_5.x jessie main' >> /etc/apt/sources.list.d/nodesource.list \
 && apt-get update \
 && apt-get install -y --no-install-recommends nodejs \
 && rm -rf /var/lib/apt/lists/*

# Flex
ADD flex /opt/flex
RUN apt-get update \
 && apt-get install -y --no-install-recommends default-jdk \
 && rm -rf /var/lib/apt/lists/* \
 && curl -fsSL -o flex.tar.gz http://apache-mirror.rbc.ru/pub/apache/flex/4.15.0/binaries/apache-flex-sdk-4.15.0-bin.tar.gz \
 && echo 'fea88e779c63c1ca5c3c0cdf19280443e2a4b5672e2c26ff0dbc3c550c8ea3a9 *flex.tar.gz' | sha256sum -c - \
 && tar -xzf flex.tar.gz -C /opt/flex --strip-components=1 \
 && rm flex.tar.gz
ENV PATH=$PATH:/opt/flex/bin