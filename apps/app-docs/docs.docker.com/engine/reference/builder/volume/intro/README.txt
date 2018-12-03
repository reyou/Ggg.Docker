https://docs.docker.com/engine/reference/builder/
http://localhost:9000


$ sudo docker build . -t aozdemir/docsengine:volume
$ sudo docker run aozdemir/docsengine:volume

This Dockerfile results in an image that causes docker run to create a new 
mount point at /myvol and copy the greeting file into the newly created volume.


