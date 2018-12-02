https://docs.docker.com/get-started/part4/#prerequisites
https://github.com/reyou/Ggg.Docker/blob/master/apps/app-docs/docs.docker.com/get-started/part3-services/intro/README.txt

### Create a cluster
Now, create a couple of VMs using docker-machine, using the VirtualBox driver:

https://www.virtualbox.org/wiki/Linux_Downloads

$ wget -q https://www.virtualbox.org/download/oracle_vbox_2016.asc -O- | sudo apt-key add -
$ wget -q https://www.virtualbox.org/download/oracle_vbox.asc -O- | sudo apt-key add -

To install VirtualBox, do

$ sudo apt-get update
$ sudo apt-get install virtualbox

If you are running on Linux:
https://docs.docker.com/machine/install-machine/#install-machine-directly

$ base=https://github.com/docker/machine/releases/download/v0.16.0 &&
  curl -L $base/docker-machine-$(uname -s)-$(uname -m) >/tmp/docker-machine &&
  sudo install /tmp/docker-machine /usr/local/bin/docker-machine


$ sudo docker-machine create --driver virtualbox myvm1
$ sudo docker-machine create --driver virtualbox myvm2

### LIST THE VMS AND GET THEIR IP ADDRESSES
You now have two VMs created, named myvm1 and myvm2.

Use this command to list the machines and get their IP addresses.

$ sudo docker-machine ls

Here is example output from this command.

$ docker-machine ls
NAME    ACTIVE   DRIVER       STATE     URL                         SWARM   DOCKER        ERRORS
myvm1   -        virtualbox   Running   tcp://192.168.99.100:2376           v17.06.2-ce
myvm2   -        virtualbox   Running   tcp://192.168.99.101:2376           v17.06.2-ce

### INITIALIZE THE SWARM AND ADD NODES
The first machine acts as the manager, which executes management 
commands and authenticates workers to join the swarm, and the second is a worker.

You can send commands to your VMs using docker-machine ssh. 
Instruct myvm1 to become a swarm manager with docker swarm init 
and look for output like this:

$ sudo docker-machine ssh myvm1 "docker swarm init --advertise-addr <myvm1 ip>"

Swarm initialized: current node <node ID> is now a manager.

To add a worker to this swarm, run the following command:

$ sudo docker swarm join \
  --token <token> \
  <myvm ip>:<port>

To add a manager to this swarm, run 'docker swarm join-token manager' and follow the instructions.

As you can see, the response to docker swarm init contains 
a pre-configured docker swarm join command for you to run 
on any nodes you want to add. Copy this command, and send it to myvm2 via docker-machine ssh to have myvm2 join your new swarm as a worker:

$ sudo docker-machine ssh myvm2 "docker swarm join \
--token <token> \
<ip>:2377"

This node joined a swarm as a worker.
Congratulations, you have created your first swarm!

Run 
$ sudo docker node ls 
on the manager to view the nodes in this swarm:

$ docker-machine ssh myvm1 "docker node ls"
ID                            HOSTNAME            STATUS              AVAILABILITY        MANAGER STATUS
brtu9urxwfd5j0zrmkubhpkbd     myvm2               Ready               Active
rihwohkh3ph38fhillhhb84sk *   myvm1               Ready               Active              Leader

### Leaving a swarm

If you want to start over, you can run 
$ sudo docker swarm leave 
from each node.

### DOCKER MACHINE SHELL ENVIRONMENT ON MAC OR LINUX
Run docker-machine env myvm1 to get the command to configure your shell to talk to myvm1.

$ sudo docker-machine env myvm1
export DOCKER_TLS_VERIFY="1"
export DOCKER_HOST="tcp://192.168.99.100:2376"
export DOCKER_CERT_PATH="/Users/sam/.docker/machine/machines/myvm1"
export DOCKER_MACHINE_NAME="myvm1"
# Run this command to configure your shell:
# eval $(docker-machine env myvm1)

Run the given command to configure your shell to talk to myvm1.

$ eval $(docker-machine env myvm1)

Run docker-machine ls to verify that myvm1 is now the active machine, as indicated by the asterisk next to it.

$ sudo docker-machine ls
NAME    ACTIVE   DRIVER       STATE     URL                         SWARM   DOCKER        ERRORS
myvm1   *        virtualbox   Running   tcp://192.168.99.100:2376           v17.06.2-ce
myvm2   -        virtualbox   Running   tcp://192.168.99.101:2376           v17.06.2-ce

Just like before, run the following command to deploy the app on myvm1.

$ sudo docker stack deploy -c docker-compose.yml getstartedlab

Note: If your image is stored on a private registry instead 
of Docker Hub, you need to be logged in using 
docker login <your-registry> and then you need to add the 
--with-registry-auth flag to the above command. 
For example:

$ sudo docker login registry.example.com

$ sudo docker stack deploy --with-registry-auth -c docker-compose.yml getstartedlab

$ docker stack ps getstartedlab

ID            NAME                  IMAGE                   NODE   DESIRED STATE
jq2g3qp8nzwx  getstartedlab_web.1   gordon/get-started:part2  myvm1  Running
88wgshobzoxl  getstartedlab_web.2   gordon/get-started:part2  myvm2  Running
vbb1qbkb0o2z  getstartedlab_web.3   gordon/get-started:part2  myvm2  Running
ghii74p9budx  getstartedlab_web.4   gordon/get-started:part2  myvm1  Running
0prmarhavs87  getstartedlab_web.5   gordon/get-started:part2  myvm2  Running

Cleanup and reboot
Stacks and swarms
You can tear down the stack with docker stack rm. For example:

$ sudo docker stack rm getstartedlab

Unsetting docker-machine shell variable settings
You can unset the docker-machine environment variables 
in your current shell with the given command.

On Mac or Linux the command is:

$ sudo eval $(docker-machine env -u)

Restarting Docker machines
If you shut down your local host, Docker machines stops running. 
You can check the status of machines by running docker-machine ls.

$ sudo docker-machine ls
NAME    ACTIVE   DRIVER       STATE     URL   SWARM   DOCKER    ERRORS
myvm1   -        virtualbox   Stopped                 Unknown
myvm2   -        virtualbox   Stopped                 Unknown
To restart a machine that’s stopped, run:

$ sudo docker-machine start <machine-name>
