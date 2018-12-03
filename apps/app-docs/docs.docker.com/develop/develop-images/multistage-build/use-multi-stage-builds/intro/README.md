https://docs.docker.com/develop/develop-images/multistage-build/#use-multi-stage-builds

With multi-stage builds, you use multiple FROM statements in your Dockerfile. 
Each FROM instruction can use a different base, and each of them begins a new stage of the build. 
You can selectively copy artifacts from one stage to another, leaving behind everything you 
don’t want in the final image. To show how this works, let’s adapt the Dockerfile from 
the previous section to use multi-stage builds.

You only need the single Dockerfile. You don’t need a separate build script, either. Just run docker build.

$ sudo docker build -t alexellis2/href-counter:latest .

How does it work? The second FROM instruction starts a new build stage with the alpine:latest 
image as its base. The COPY --from=0 line copies just the built artifact from the previous 
stage into this new stage. The Go SDK and any intermediate artifacts are left behind, 
and not saved in the final image.

