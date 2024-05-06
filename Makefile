run:
	mkdocs serve
build:
	mkdocs build
clean:
ifeq ($(OS),Windows_NT) 
	-rmdir /S /Q .\site
else
	-rm -rf ./site
endif