#SINGULARITY = /usr/local/bin/singularity

SINGULARITY = singularity
IMG_NAME = centrifuge.img
DEF_NAME = ubuntu.sh
SIZE = 1024

run:
	sudo $(SINGULARITY) run $(IMG_NAME)

img:
	sudo $(SINGULARITY) build $(IMG_NAME) $(DEF_NAME)

shell:
	sudo $(SINGULARITY) shell --writable -B $(shell pwd):/tmp $(IMG_NAME)
