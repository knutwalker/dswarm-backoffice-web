PORT=9999

all: install
.PHONY: all

env-install:
	cd yo && npm install
	cd yo && bower install
.PHONY: env-install


## needs build after `bower install'

yo/app/components/angular-ui-bootstrap/dist/ui-bootstrap-0.5.0.js: yo/app/components/angular-ui-bootstrap/package.json yo/app/components/angular-ui-bootstrap/Gruntfile.js
	cd yo/app/components/angular-ui-bootstrap && npm install
	cd yo/app/components/angular-ui-bootstrap && grunt build

yo/app/components/angular-ui-utils/components/angular-ui-docs/build/ui-utils.js: yo/app/components/angular-ui-utils/package.json yo/app/components/angular-ui-utils/gruntFile.js
	cd yo/app/components/angular-ui-utils && npm install
	cd yo/app/components/angular-ui-utils && grunt build

# shorthand

ui-bootstrap: yo/app/components/angular-ui-bootstrap/dist/ui-bootstrap-0.5.0.js
ui-utils: yo/app/components/angular-ui-utils/components/angular-ui-docs/build/ui-utils.js
.PHONY: ui-bootstrap ui-utils


# install all

install: env-install ui-bootstrap ui-utils
.PHONY: install

# update all
update-files:
	cd yo && bower update

update: update-files ui-bootstrap ui-utils
.PHONY: update-files update


# upgrade installation base
upgrade:
	git fetch origin
	git pull
.PHONY: upgrade


# run tests

test: yo/Gruntfile.js
	cd yo && grunt test:ci
.PHONY: test

jenkins: yo/Gruntfile.js
	cd yo && grunt --no-color jenkins
.PHONY: jenkins


# run static analysis

lint: yo/Gruntfile.js
	cd yo && grunt jshint
.PHONY: lint


# build live version

yo/publish:
	mkdir yo/publish


dist: yo/Gruntfile.js install | yo/publish
	cd yo && grunt build
	rsync --delete --recursive yo/dist/ yo/publish
.PHONY: dist


# clean

clean:
	rm -rf yo/app/components
	rm -rf yo/node_modules
.PHONY: clean
