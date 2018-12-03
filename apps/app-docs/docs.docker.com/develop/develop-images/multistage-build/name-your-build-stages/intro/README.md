https://docs.docker.com/develop/develop-images/multistage-build/#name-your-build-stages

By default, the stages are not named, and you refer to them by their integer number, 
starting with 0 for the first FROM instruction. However, you can name your stages, 
by adding an as <NAME> to the FROM instruction. This example improves the previous one 
by naming the stages and using the name in the COPY instruction. 
This means that even if the instructions in your Dockerfile are re-ordered later, 
the COPY doesn’t break.

### Stop at a specific build stage

When you build your image, you don’t necessarily need to build the entire Dockerfile 
including every stage. You can specify a target build stage. The following command assumes 
you are using the previous Dockerfile but stops at the stage named builder:

$ docker build --target builder -t alexellis2/href-counter:latest .

A few scenarios where this might be very powerful are:

1. Debugging a specific build stage
2. Using a debug stage with all debugging symbols or tools enabled, and a lean production stage
3. Using a testing stage in which your app gets populated with test data, but building for production using a different stage which uses real data

