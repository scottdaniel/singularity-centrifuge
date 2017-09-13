BootStrap: debootstrap
OSVersion: trusty
MirrorURL: http://us.archive.ubuntu.com/ubuntu/

%environment
#    PERL5LIB=/app/fizkin/scripts
#    export PERL5LIB
    PATH=/app/centrifuge:$PATH
    LD_LIBRARY_PATH=/app
    export LD_LIBRARY_PATH

%runscript
    exec /app/centrifuge/centrifuge "$@"

%post
    apt-get update
    apt-get install -y locales git build-essential wget curl zip libcurl4-openssl-dev libssl-dev 
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

    wget -O centrifuge.zip ftp://ftp.ccb.jhu.edu/pub/infphilo/centrifuge/downloads/centrifuge-1.0.3-beta-Linux_x86_64.zip
    unzip centrifuge.zip
    mv centrifuge-1.0.3-beta centrifuge

#     #
#     # Add CRAN to sources to get latest R
#     #
#     gpg --keyserver keyserver.ubuntu.com --recv-key E084DAB9
#     gpg -a --export E084DAB9 | apt-key add -
#     echo "deb http://cran.rstudio.com/bin/linux/ubuntu xenial/" | \
#         tee -a /etc/apt/sources.list
#     apt-get install -y r-base r-base-dev
#  
#     #
#     # CPAN installs want to use "/bin/make"
#     #
#     ln -s /usr/bin/make /bin/make
# 
#     #
#     # Install Jellyfish binary
#     #
#     cd $APP_DIR
#     wget https://github.com/gmarcais/Jellyfish/releases/download/v2.2.6/jellyfish-2.2.6.tar.gz
#     tar xvf jellyfish-2.2.6.tar.gz
#     (cd jellyfish-2.2.6 && ./configure && make install)
# 
#     #
#     # Clone Fizkin 
#     #
#     cd $APP_DIR
#     git clone https://github.com/hurwitzlab/docker-fizkin.git fizkin
# 
#     #
#     # Install Perl modules
#     #
#     cd fizkin/scripts
#     cpan -i App::cpanminus
#     cpanm --installdeps .
# 
#     #
#     # Install R modules (need the .Rprofile to indicate CRAN mirror)
#     #
#     cat << EOF > .Rprofile
# local({
#   r = getOption("repos")
#   r["CRAN"] = "http://mirrors.nics.utk.edu/cran/"
#   options(repos = r)
# })
# EOF
#     Rscript install.R
#   
#   
#     # Mount points for TACC directories
#     mkdir /home1
#     mkdir /scratch
#     mkdir /work
