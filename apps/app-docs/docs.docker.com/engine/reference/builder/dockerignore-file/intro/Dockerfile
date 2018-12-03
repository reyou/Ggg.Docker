FROM busybox
RUN echo 'we are running some # of cool things'
ENV foo /bar
 # WORKDIR /bar
WORKDIR ${foo}  
# ADD . /bar
ADD . $foo       
# COPY $foo /quux
COPY \$foo /quux 