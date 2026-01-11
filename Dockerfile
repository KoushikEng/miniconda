FROM debian:latest

WORKDIR /root

# Install wget
RUN apt-get update -y && apt-get install -y wget

# Download Miniconda installer script
RUN wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O miniconda.sh

# Install Miniconda silently to /opt/miniconda
RUN bash miniconda.sh -b -p /opt/miniconda

# Clean up
RUN rm miniconda.sh

# Add conda to PATH
ENV PATH="/opt/miniconda/bin:$PATH"

# Initialize conda for bash shell
RUN conda init --all

# Set the default command to bash
ENTRYPOINT [ "/bin/bash" ]