FROM microsoft/dotnet:2.1-aspnetcore-runtime AS base
WORKDIR /app
EXPOSE 60887
EXPOSE 44373

FROM microsoft/dotnet:2.1-sdk AS build
WORKDIR /src
COPY ["GggDockerWebApplication.csproj", "GggDockerWebApplication/"]
RUN dotnet restore "GggDockerWebApplication/GggDockerWebApplication.csproj"
COPY . ./
WORKDIR "/src/GggDockerWebApplication"
RUN dotnet build "GggDockerWebApplication.csproj" -c Release -o /app

FROM build AS publish
RUN dotnet publish "GggDockerWebApplication.csproj" -c Release -o /app

FROM base AS final
WORKDIR /app
COPY --from=publish /app .
ENTRYPOINT ["dotnet", "GggDockerWebApplication.dll"]