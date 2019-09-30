all: clean build

clean:
	rm -rf site/

build:
	mkdocs build

pdf-deps:
	pip install mkdocs-pdf-export-plugin

pdf:
	cp mkdocs.yml mkdocs.backup.yml
	@cat plugins.yml >> mkdocs.yml
	LC_ALL='en_US.UTF-8' LANG='en_US.UTF-8' PDF=1 mkdocs build
	mv mkdocs.backup.yml mkdocs.yml

serve:
	mkdocs serve

setup:
	pip install mkdocs mkdocs-material pymdown-extensions pygments
