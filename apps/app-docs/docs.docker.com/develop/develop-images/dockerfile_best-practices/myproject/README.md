Build context example

Create a directory for the build context and cd into it. Write “hello” into a text file named hello and create a Dockerfile that runs cat on it. Build the image from within the build context (.):

$ mkdir myproject && cd myproject
$ echo "hello" > hello
$ echo -e "FROM busybox\nCOPY /hello /\nRUN cat /hello" > Dockerfile
$ sudo docker build -t helloapp:v1 .
