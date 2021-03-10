.PHONY: up docker-build bash build clean help

DIR := ${CURDIR}
DOCKER_TAG := 1.0
DOCKER_REPO := latexbuilder/latex-build
CONTAINER_NAME := latex-build

ARGS := -pdf \
-file-line-error \
-halt-on-error \
-interaction=nonstopmode \
--output-directory=./build \
main.tex

docker-up:
	# start up the container
	docker-compose up

docker-down:
	# stop container
	docker-compose down -v --remove-orphans

docker-build:
	# bind mount a volume to container and run the build
	docker run --rm -i --mount type=bind,source="${DIR}",target=/tmp ${DOCKER_REPO}:${DOCKER_TAG} make build;

bash:
	# bind mount a volume to container and bash on in.
	docker run --name ${CONTAINER_NAME} --rm -it -d --mount type=bind,source="${DIR}",target=/tmp ${DOCKER_REPO}:${DOCKER_TAG} /bin/bash;
	docker exec -it -e COLUMNS=`tput cols` -e LINES=`tput lines` ${CONTAINER_NAME} bash

build:
	# If the build dir directory doesn't exist, create it.
	if [ ! -d ${DIR}/build ]; then mkdir -p ${DIR}/build; fi

	latexmk ${ARGS}

clean:
	rm -f ./build/main.aux \
		./build/main.dvi \
		./build/main.fdb_latexmk \
		./build/main.fls \
		./build/main.log \
		./build/main.out;

help:
	@echo ""
	@echo "Make file Help"
	@echo ""
	@echo "	Most of these commands should be run from the host"
	@echo "		--- Makefile Help --- "
	@echo "	make docker-up			Spins up the docker container"
	@echo "	make docker-down		Unwinds the docker container"
	@echo "	make docker-build		Run from the host, builds the tex file"
	@echo "	make bash			Gets you into the docker container"
	@echo "	make build			Should only be run from within the container"
	@echo "	make clean			Cleans up build files"
	@echo ""