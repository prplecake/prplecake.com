SHELL := /bin/bash
BUNDLE := bundle
JEKYLL := $(BUNDLE) exec jekyll
HTMLPROOFER := $(BUNDLE) exec htmlproofer

PROJECT_DEPS := Gemfile

.PHONY: all clean install update

all: serve

check:
	$(JEKYLL) doctor

install: $(PROJECT_DEPS)
	$(BUNDLE) install --path vendor/bundle

update: $(PROJECT_DEPS)
	$(BUNDLE) update

build: install
	echo -n $(git_hash) > $(PWD)/_includes/version
	JEKYLL_ENV=production $(JEKYLL) build

serve: install
	JEKYLL_ENV=production $(JEKYLL) serve

HASHMARK := \#
grep_cmd := grep -v '^$(HASHMARK)' | sed '/^$$/d'
proofer_ignore_files := `awk '{print}' .proofer_ignore_files | $(grep_cmd) | paste -s -d, -`
proofer_opts := --check-html # --file-ignore $(proofer_ignore_files)

html-proof: install build
	$(HTMLPROOFER) $(proofer_opts) _site

git_hash=`git rev-parse --short HEAD`
sshopts := -o StrictHostKeyChecking=no -i ~/.ssh/mario_rsa

deploy: update build
	rsync --rsh="ssh $(sshopts)" -rP _site/ deploy@prplecake.com:/var/www/prplecake.com --delete

clean:
	rm -r _site
