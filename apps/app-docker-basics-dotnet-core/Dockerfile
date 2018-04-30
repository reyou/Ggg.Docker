# The Dockerfile contains Docker build instructions that run sequentially.+
# The first instruction must be FROM.
# The Base Image for our sample is the 2.0-sdk image from the 
# microsoft/dotnet repository.
FROM microsoft/dotnet:2.0-sdk

# The WORKDIR instruction sets the working directory for 
# any remaining RUN, CMD, ENTRYPOINT, COPY, and ADD 
# Dockerfile instructions.
WORKDIR /app

# copy csproj and restore as distinct layers
COPY *.csproj ./
# The RUN instruction executes any commands in a new 
# layer on top of the current image and commit the results.
RUN dotnet restore

# copy and build everything else
COPY . ./
RUN dotnet publish -c Release -o out
# The ENTRYPOINT instruction allows the container to 
# run as an executable.
ENTRYPOINT ["dotnet", "out/app-docker-basics-dotnet-core.dll"]
