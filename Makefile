VERSION ?= 0.12.22


build:
	docker build --no-cache --force-rm -t t0t0/docker-alpine-fluentd:$(VERSION) $(VERSION)

clean:
	docker rmi t0t0/docker-alpine-fluentd:$(VERSION)