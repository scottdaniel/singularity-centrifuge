#SINGULARITY = /usr/local/bin/singularity

SINGULARITY = /usr/bin/singularity
IMG_NAME = centrifuge.img
DEF_NAME = ubuntu.sh
SIZE = 1024

run:
	sudo $(SINGULARITY) run $(IMG_NAME)

clean:
	rm -f $(IMG_NAME)

img: clean
	sudo $(SINGULARITY) create --size $(SIZE) $(IMG_NAME)
	sudo $(SINGULARITY) bootstrap $(IMG_NAME) $(DEF_NAME)

shell:
	sudo $(SINGULARITY) shell --writable -B $(shell pwd):/tmp $(IMG_NAME)
