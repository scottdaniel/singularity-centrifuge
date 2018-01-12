BootStrap: debootstrap
OSVersion: trusty
MirrorURL: http://us.archive.ubuntu.com/ubuntu/

%environment
	export PATH="/app/bin:/app/bin/share:$PATH"
	export LD_LIBRARY_PATH="/app"

%runscript
    exec /app/bin/centrifuge "$@"

%post
    apt-get update
    apt-get install -y locales git build-essential wget curl zip libcurl4-openssl-dev libssl-dev python
    locale-gen en_US.UTF-8

    #
    # Put everything into $APP_DIR
    #
    export APP_DIR=/app
    mkdir -p $APP_DIR
    cd $APP_DIR

    # Mount points for HPC/PBS directories
    mkdir /work
    mkdir /extra
    mkdir /xdisk
    mkdir /centdb

	cd /extra
	git clone https://github.com/infphilo/centrifuge
	cd centrifuge/
	make
	make install prefix=/app
	rm -rf /extra/*

