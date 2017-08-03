.PHONY: all push

USER="501stalpha1"
ifeq ($(shell uname -m), i686)
  PLATFORM="386"
else
  PLATFORM="amd64"
endif
VERSION="trusty-sameersbn"

all: .last-docker-build

.last-docker-build: Dockerfile
	docker build -t "$(USER)/ubuntu:$(VERSION)-$(PLATFORM)" .
	@touch $@

push: .last-docker-push

.last-docker-push: .last-docker-build
	docker push "$(USER)/ubuntu:$(VERSION)-$(PLATFORM)"
	manifest-tool push from-spec ./manifest.yml --ignore-missing
	@touch $@
