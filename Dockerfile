# Learn about building .NET container images:
# https://github.com/dotnet/dotnet-docker/blob/main/samples/README.md
FROM  --platform=$BUILDPLATFORM mcr.microsoft.com/dotnet/sdk:9.0 AS build
ARG TARGETARCH
WORKDIR /source

# Copy project file and restore as distinct layers
COPY --link BlankAspnetCore/*.csproj .
RUN dotnet restore -a $TARGETARCH BlankAspNetCore.csproj

# Copy source code and publish app
COPY --link BlankAspnetCore/. .
RUN dotnet publish  --no-restore -o /app

# Runtime stage
FROM mcr.microsoft.com/dotnet/aspnet:9.0 AS APP
RUN apt update && apt install -y curl && rm -rf /var/lib/apt/lists/*
EXPOSE 8080
WORKDIR /app
COPY --link --from=build /app .
USER $APP_UID
ENTRYPOINT ["dotnet", "BlankAspNetCore.dll"]