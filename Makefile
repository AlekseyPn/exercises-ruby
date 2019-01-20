export RUBYLIB=$(realpath lib)

compose: compose-build
	docker-compose up

gcloud-builds-submit:
	gcloud builds submit --config cloudbuild.yaml .

compose-test:
	docker-compose run exercises make test

compose-install:
	docker-compose run exercises bundle install

compose-bash:
	docker-compose run exercises bash

compose-build:
	docker-compose build

SUBDIRS := $(wildcard modules/**/*/.)

lint:
	yamllint modules

test: $(SUBDIRS)
$(SUBDIRS):
	@echo
	@ make test -s -C $@
	@echo

.PHONY: all $(SUBDIRS)
