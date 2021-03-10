# Using fedora
FROM fedora:latest

# Install all dependencies necessary
RUN dnf install \
    texlive \
    latexmk \
    make \
    vim \
    -y

# If you have a preferred BASH setup, uncomment the following:
# COPY	.profile /root/.profile
# COPY	.bashrc /root/.bashrc

# Set the working directory.
WORKDIR	/tmp
