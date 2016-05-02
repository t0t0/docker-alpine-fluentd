### Dockerfile fluentd

FROM alpine:latest
MAINTAINER Tomas Vercautter & Toon Lamberigts


ENV FLUENTD_OPT=""
ENV FLUENTD_CONF="fluent.conf"
ENV FLUENTD_VERSION=0.12.22

RUN apk --no-cache --update add \
                            build-base \
                            ca-certificates \
                            ruby \
                            git \
                            ruby-irb \
                            ruby-dev && \
    echo 'gem: --no-document' >> /etc/gemrc && \
    gem install fluentd -v $FLUENTD_VERSION && \
    apk del build-base ruby-dev && \
    rm -rf /tmp/* /var/tmp/* /var/cache/apk/*

# for log storage (maybe shared with host)
RUN mkdir -p /fluentd/log

# configuration/plugins path (default: copied from .)
RUN mkdir -p /fluentd/etc /fluentd/plugins

#installing fluent plugins
#RUN gem install rake
RUN gem install fluent-plugin-elasticsearch -V

RUN mkdir /src && cd /src && \
      git clone https://github.com/fabric8io/fluent-plugin-docker_metadata_filter && \
      cd fluent-plugin-docker_metadata_filter && \
      gem build fluent-plugin-docker_metadata_filter.gemspec && \
      gem install --no-ri --no-rdoc fluent-plugin-docker_metadata_filter && \
    rm -r /src

CMD exec fluentd -c /fluentd/etc/$FLUENTD_CONF -p /fluentd/plugins $FLUENTD_OPT
