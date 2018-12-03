https://docs.docker.com/engine/reference/builder/
http://localhost:9000


$ sudo docker build . -t aozdemir/docsengine:exec-form-entrypoint-example
$ sudo docker run -p 8085:80 aozdemir/docsengine:exec-form-entrypoint-example
url: http://localhost:8085

you can then examine the container’s processes with docker exec:

"friendly_bardeen" is container name assigned by Docker.

$ sudo docker exec -it friendly_bardeen ps aux

USER       PID %CPU %MEM    VSZ   RSS TTY      STAT START   TIME COMMAND
root         1  0.0  0.0   4292  1536 ?        Ss   22:44   0:00 /bin/sh /usr/sb
root        14  0.0  0.0  75616  4868 ?        S    22:44   0:00 /usr/sbin/apach
www-data    15  0.0  0.0 430392  4768 ?        Sl   22:44   0:00 /usr/sbin/apach
www-data    16  0.0  0.0 495928  4884 ?        Sl   22:44   0:00 /usr/sbin/apach
root        71  0.0  0.0  36640  2844 pts/0    Rs+  22:53   0:00 ps aux

or docker top: 

$ sudo docker top friendly_bardeen

UID                 PID                 PPID                C                   STIME               TTY                 TIME                CMD
root                20402               20372               0                   17:44               ?                   00:00:00            /bin/sh /usr/sbin/apache2ctl -D FOREGROUND
root                20463               20402               0                   17:44               ?                   00:00:00            /usr/sbin/apache2 -D FOREGROUND
www-data            20465               20463               0                   17:44               ?                   00:00:00            /usr/sbin/apache2 -D FOREGROUND
www-data            20466               20463               0                   17:44               ?                   00:00:00            /usr/sbin/apache2 -D FOREGROUND

Then ask the script to stop Apache:

$ sudo docker stop friendly_bardeen
