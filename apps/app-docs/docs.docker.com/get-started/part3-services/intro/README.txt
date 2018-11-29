https://docs.docker.com/get-started/part3/#your-first-docker-composeyml-file
https://github.com/reyou/Ggg.Docker/blob/master/apps/app-docs/docs.docker.com/get-started/part2-containers/define-a-container-with-dockerfile/README.txt

This docker-compose.yml file tells Docker to do the following:

Pull the image we uploaded in step 2 from the registry.

Run 5 instances of that image as a service called web, limiting each one to use, at most, 10% of the CPU (across all cores), and 50MB of RAM.

Immediately restart containers if one fails.

Map port 4000 on the host to web’s port 80.

Instruct web’s containers to share port 80 via a load-balanced network called webnet. (Internally, the containers themselves publish to web’s port 80 at an ephemeral port.)

Define the webnet network with the default settings (which is a load-balanced overlay network).

***

Run your new load-balanced app
Before we can use the docker stack deploy command we first run:

$ sudo docker swarm init

Swarm initialized: current node (b11vglwt26rrvqs77up78i12a) is now a manager.

To add a worker to this swarm, run the following command:

    $ sudo docker swarm join --token SWMTKN-1-5xyo6nl4vbwq3z9fdysk6pdeu359risuelx93s9idbwp7ytu9d-1nz2ny93o49k5339h9tzn4m3d 192.168.1.143:2377

To add a manager to this swarm, run 'docker swarm join-token manager' and follow the instructions.

***

Now let’s run it. You need to give your app a name. Here, it is set to getstartedlab:

$ sudo docker stack deploy -c docker-compose.yml getstartedlab

Creating network getstartedlab_webnet
Creating service getstartedlab_web

***

Our single service stack is running 5 container instances 
of our deployed image on one host. Let’s investigate.

Get the service ID for the one service in our application:

$ sudo docker service ls

ID                  NAME                MODE                REPLICAS            IMAGE                        PORTS
0usuesm75jkm        getstartedlab_web   replicated          5/5                 aozdemir/get-started:part2   *:4000->80/tcp

***

A single container running in a service is called a task. Tasks are given unique IDs that numerically increment, up to the number of replicas you defined in docker-compose.yml. List the tasks for your service:

$ sudo docker service ps getstartedlab_web

ID                  NAME                  IMAGE                        NODE                DESIRED STATE       CURRENT STATE           ERROR               PORTS
rpqt2xmf3nve        getstartedlab_web.1   aozdemir/get-started:part2   aozdemir-ubuntu     Running             Running 3 minutes ago                       
4stq09n63yhz        getstartedlab_web.2   aozdemir/get-started:part2   aozdemir-ubuntu     Running             Running 3 minutes ago                       
vl0hkg6s2cjo        getstartedlab_web.3   aozdemir/get-started:part2   aozdemir-ubuntu     Running             Running 3 minutes ago                       
snqqx7hujljl        getstartedlab_web.4   aozdemir/get-started:part2   aozdemir-ubuntu     Running             Running 3 minutes ago                       
0h1pj5mk0z8c        getstartedlab_web.5   aozdemir/get-started:part2   aozdemir-ubuntu     Running             Running 3 minutes ago 

***

Tasks also show up if you just list all the containers on your 
system, though that is not filtered by service:

$ sudo docker container ls -q

5b740875f3bb
0710fed89e09
d0717b09f8a7
959b10bc141e
47abd7af0dd4

***

You can run curl -4 http://localhost:4000 several times in a row, or go to that URL in your browser and hit refresh a few times.

$ sudo curl -4 http://localhost:4000

Scale the app
You can scale the app by changing the replicas value in docker-compose.yml, saving the change, and re-running the docker stack deploy command:

$ sudo docker stack deploy -c docker-compose.yml getstartedlab
$ sudo docker container ls

Take down the app and the swarm
Take the app down with docker stack rm:

$ sudo docker stack rm getstartedlab

Take down the swarm.

$ sudo docker swarm leave --force
