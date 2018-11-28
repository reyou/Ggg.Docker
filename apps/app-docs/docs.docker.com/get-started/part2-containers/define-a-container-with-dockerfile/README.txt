https://docs.docker.com/get-started/part2/#dockerfile

Now run the build command. This creates a Docker image, which we’re going to tag using -t so it has a friendly name.

$ sudo docker build -t friendlyhello .
$ sudo docker image ls

Run the app, mapping your machine’s port 4000 to the container’s 
published port 80 using -p:

$ sudo docker run -p 4000:80 friendlyhello

url: http://localhost:4000

You can also use the curl command in a shell to view the same content.

$ curl http://localhost:4000

Now let’s run the app in the background, in detached mode:

$ sudo docker run -d -p 4000:80 friendlyhello

You can also see the abbreviated container ID with 

$ sudo docker container ls

Now use docker container stop to end the process, using the CONTAINER ID, like so:

$ sudo docker container stop 4eb8402d4265

Share your image
https://hub.docker.com/

Log in to the Docker public registry on your local machine.

$ sudo docker login
$ sudo docker tag friendlyhello aozdemir/get-started:part2

Upload your tagged image to the repository:

$ sudo docker push aozdemir/get-started:part2
url: https://hub.docker.com/r/aozdemir/get-started/

Pull and run the image from the remote repository

$ sudo docker run -p 4000:80 aozdemir/get-started:part2



