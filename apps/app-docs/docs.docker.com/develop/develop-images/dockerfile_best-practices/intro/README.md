https://docs.docker.com/develop/develop-images/dockerfile_best-practices/

Each instruction creates one layer:

FROM creates a layer from the ubuntu:15.04 Docker image.
COPY adds files from your Docker client’s current directory.
RUN builds your application with make.
CMD specifies what command to run within the container.
