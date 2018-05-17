//=============================================================================
Docker Images vs. Containers
http://blog.codesupport.info/docker-images-vs-containers/
https://stackoverflow.com/questions/23735149/what-is-the-difference-between-a-docker-image-and-a-container
IMAGE :- An image is an inert, immutable, file that’s essentially a snapshot 
of a container. Images are created with the build command, and they’ll 
produce a container when started with run. Images are stored in a Docker 
registry such as registry.hub.docker.com. Because they can become quite large, 
images are designed to be composed of layers of other images, allowing a miminal 
amount of data to be sent when transferring images over the network.

CONTAINER :- To use a programming metaphor, if an image is a class, then 
a container is an instance of a class—a runtime object. Containers are 
hopefully why you’re using Docker; they’re lightweight and portable 
encapsulations of an environment in which to run applications.
//=============================================================================
