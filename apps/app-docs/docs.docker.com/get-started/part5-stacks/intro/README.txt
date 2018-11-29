https://docs.docker.com/get-started/part5/#prerequisites
https://github.com/reyou/Ggg.Docker/blob/master/apps/app-docs/docs.docker.com/get-started/part4-swarms/intro/README.txt

### docker-compose.yml
The only thing new here is the peer service to web, named visualizer. 
Notice two new things here: a volumes key, giving the visualizer access to 
the host’s socket file for Docker, and a placement key, ensuring that this 
service only ever runs on a swarm manager -- never a worker. 
That’s because this container, built from an open source project created by 
Docker, displays Docker services running on a swarm in a diagram.

Re-run the docker stack deploy command on the manager, and whatever services need updating are updated:

$ sudo docker stack deploy -c docker-compose.yml getstartedlab
$ sudo docker container ls

CONTAINER ID        IMAGE                             COMMAND             CREATED             STATUS              PORTS               NAMES
30ecdbdc7877        dockersamples/visualizer:stable   "npm start"         2 minutes ago       Up 2 minutes        8080/tcp            getstartedlab_visualizer.1.hqsj6rjkhdf0yzgxnmfzsc3s7
a2cac6adc7b5        aozdemir/get-started:part2        "python app.py"     2 minutes ago       Up 2 minutes        80/tcp              getstartedlab_web.2.1q1if2bd2wv9d8cj6ibxez9a6
6cb7fecad27d        aozdemir/get-started:part2        "python app.py"     2 minutes ago       Up 2 minutes        80/tcp              getstartedlab_web.5.c8fj6pvwef3a93041tg6w8ctm
402ad48afc3c        aozdemir/get-started:part2        "python app.py"     2 minutes ago       Up 2 minutes        80/tcp              getstartedlab_web.1.oj6krgiqduqtbtwglr2btnvz2
8644ff75ea6a        aozdemir/get-started:part2        "python app.py"     2 minutes ago       Up 2 minutes        80/tcp              getstartedlab_web.3.5wjzsnz7x5itji2gsj5j5ronu
f2d295e6b6f4        aozdemir/get-started:part2        "python app.py"     2 minutes ago       Up 2 minutes        80/tcp              getstartedlab_web.4.orn4hj333nlba4xmls6u77f2g

You saw in the Compose file that visualizer runs on port 8080. 
Get the IP address of one of your nodes by running docker-machine ls. 
Go to either IP address at port 8080 and you can see the visualizer running:

url: http://localhost:8080/

The single copy of visualizer is running on the manager 
as you expect, and the 5 instances of web are spread out 
across the swarm. You can corroborate this visualization 
by running docker stack ps <stack>:

$ sudo docker stack ps getstartedlab

ID                  NAME                         IMAGE                             NODE                DESIRED STATE       CURRENT STATE           ERROR               PORTS
hqsj6rjkhdf0        getstartedlab_visualizer.1   dockersamples/visualizer:stable   aozdemir-ubuntu     Running             Running 9 minutes ago                       
oj6krgiqduqt        getstartedlab_web.1          aozdemir/get-started:part2        aozdemir-ubuntu     Running             Running 9 minutes ago                       
1q1if2bd2wv9        getstartedlab_web.2          aozdemir/get-started:part2        aozdemir-ubuntu     Running             Running 9 minutes ago                       
5wjzsnz7x5it        getstartedlab_web.3          aozdemir/get-started:part2        aozdemir-ubuntu     Running             Running 9 minutes ago                       
orn4hj333nlb        getstartedlab_web.4          aozdemir/get-started:part2        aozdemir-ubuntu     Running             Running 9 minutes ago                       
c8fj6pvwef3a        getstartedlab_web.5          aozdemir/get-started:part2        aozdemir-ubuntu     Running             Running 9 minutes ago                       

Create a ./data directory for Redis (check in docker-compose.yml):

$ sudo mkdir /home/docker/data

Run docker stack deploy one more time.

$ sudo docker stack deploy -c docker-compose.yml getstartedlab

Run 

$ sudo docker service ls 

to verify that the three services are running as expected.

ID                  NAME                       MODE                REPLICAS            IMAGE                             PORTS
2lvgbosklkyb        getstartedlab_redis        replicated          1/1                 redis:latest                      *:6379->6379/tcp
8iznx52jgtug        getstartedlab_visualizer   replicated          1/1                 dockersamples/visualizer:stable   *:8080->8080/tcp
8jj0sz1dt5a6        getstartedlab_web          replicated          5/5                 aozdemir/get-started:part2        *:80->80/tcp

url: http://localhost/
url: http://localhost:8080/