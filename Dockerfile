FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build-env
WORKDIR /app

# Copy everything else and build
COPY . .
WORKDIR /app/Dotnet6WebApi
RUN dotnet restore
RUN dotnet publish -c Release -o out

# Build runtime image
FROM mcr.microsoft.com/dotnet/aspnet:6.0
WORKDIR /app
COPY --from=build-env /app/Dotnet6WebApi/out .
EXPOSE 80
ENTRYPOINT ["dotnet", "Dotnet6WebApi.dll"]