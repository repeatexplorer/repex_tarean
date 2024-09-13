# Base image
FROM ubuntu:20.04

# Set environment variables
ENV DEBIAN_FRONTEND=noninteractive
ENV LC_ALL=C
ENV PATH="/opt/conda/bin:/usr/games:$PATH"


# Copy files from host to container
COPY R_install.R /opt/R_install.R

# Set the shell to bash
SHELL ["/bin/bash", "-c"]

# Install required packages and software
RUN apt-get -y update && \
    dpkg --add-architecture i386 && \
    apt-get update && \
    apt-get -y install git wget build-essential gfortran libblas-dev liblapack-dev libc6:i386 libncurses5:i386 libstdc++6:i386 && \
    # Install Miniconda
    wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O /tmp/miniconda.sh && \
    bash /tmp/miniconda.sh -b -p /opt/conda && \
    rm /tmp/miniconda.sh && \
    # Initialize Conda for bash shell
    /opt/conda/bin/conda init bash && \
    # Activate Conda base environment and install mamba
    . ~/.bashrc && \
    conda install -y -c conda-forge -c bioconda python=3.8 blast mafft diamond last r-r2html r-data.tree r-rserve imagemagick r-base r-stringr r-dt r-scales r-igraph r-hwriter bioconductor-biostrings r-plotrix r-png r-dplyr r-plyr r-optparse r-dbi r-rsqlite numpy=1.11.3 pyrserve && \
    cd /opt && \
    git clone https://petrnovak@bitbucket.org/petrnovak/repex_tarean.git && \
    cd repex_tarean && make && \
    ln -s /opt/repex_tarean/seqclust /usr/local/bin/seqclust && \
    echo "source /opt/conda/etc/profile.d/conda.sh" >> ~/.bashrc && \
    echo "conda activate base" >> ~/.bashrc

# Set the default command to run when starting the container
CMD ["/bin/bash", "-c", "source /opt/conda/etc/profile.d/conda.sh && conda activate base && seqclust"]

# Metadata as labels
LABEL Author="petr@umbr.cas.cz" \
      Version="v0.0.2"


