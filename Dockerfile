FROM ruby:2.4.0

# Prepare apt-get
RUN apt-get update

# UTF-8 locales
RUN apt-get install -y --no-install-recommends locales \
 && sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen \
 && echo 'LANG="en_US.UTF-8"'>/etc/default/locale \
 && dpkg-reconfigure --frontend=noninteractive locales \
 && update-locale LANG=en_US.UTF-8
ENV LANG=en_US.UTF-8

# nano
ENV TERM=xterm
RUN apt-get install -y --no-install-recommends nano

# NodeJS
ADD nodesource.gpg.key /
RUN apt-get install -y --no-install-recommends apt-transport-https \
 && cat nodesource.gpg.key | apt-key add - \
 && rm nodesource.gpg.key \
 && echo 'deb https://deb.nodesource.com/node_8.x jessie main' > /etc/apt/sources.list.d/nodesource.list \
 && echo 'deb-src https://deb.nodesource.com/node_8.x jessie main' >> /etc/apt/sources.list.d/nodesource.list \
 && apt-get update \
 && apt-get install -y --no-install-recommends nodejs

# Flex
ADD flex /opt/flex
RUN apt-get install -y --no-install-recommends default-jdk \
 && curl -fsSL -o flex.tar.gz http://apache-mirror.rbc.ru/pub/apache/flex/4.16.0/binaries/apache-flex-sdk-4.16.0-bin.tar.gz \
 && echo '8a339bd19babca331962b76badc9f10b7455cd67eb7b8b32785a7390afc68c7c *flex.tar.gz' | sha256sum -c - \
 && tar -xzf flex.tar.gz -C /opt/flex --strip-components=1 \
 && rm flex.tar.gz
ENV PATH=$PATH:/opt/flex/bin

# Clean up apt-get
RUN rm -rf /var/lib/apt/lists/*