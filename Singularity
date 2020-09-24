Bootstrap: docker
From: ubuntu:20.04
%files
    R_install.R  /opt/R_install.R


%post
    export DEBIAN_FRONTEND=noninteractive
    apt-get -y update
    apt-get -y install git python3 ncbi-blast+-legacy ncbi-blast+ python3 mafft python3-pip imagemagick diamond-aligner last-align
    apt-get -y install r-base libcurl4-openssl-dev libxml2-dev libgtk2.0-dev libssl-dev build-essential gfortran libblas-dev liblapack-dev r-cran-future
    apt-get -y install r-cran-stringr r-cran-dt r-cran-scales r-cran-igraph r-cran-hwriter r-bioc-biostrings 
    apt-get -y install r-cran-plotrix r-cran-png r-cran-dplyr r-cran-plyr r-cran-optparse r-cran-dbi r-cran-rsqlite
    dpkg --add-architecture i386
    apt-get update
    apt-get -y install libc6:i386 libncurses5:i386 libstdc++6:i386
    Rscript /opt/R_install.R
    pip3 install pyRserve
    cd opt
    git clone https://petrnovak@bitbucket.org/petrnovak/repex_tarean.git
    cd repex_tarean && make
    ln -s /opt/repex_tarean/seqclust /usr/local/bin/seqclust
%environment
    export LC_ALL=C
    export PATH=/usr/games:$PATH

%runscript
    seqclust $@

%labels
    Author petr@umbr.cas.cz
    Version v0.0.1

%test
    cd /opt/repex_tarean/
    /opt/repex_tarean/test_repex_pipeline.py SHORT_SUITE