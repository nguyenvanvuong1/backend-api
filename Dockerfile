FROM mcr.microsoft.com/dotnet/aspnet:9.0 AS base
WORKDIR /app
EXPOSE 5101

ENV ASPNETCORE_URLS=http://+:5101

USER app
FROM --platform=$BUILDPLATFORM mcr.microsoft.com/dotnet/sdk:9.0 AS build
ARG configuration=Release
WORKDIR /src
COPY ["backend-api/backend-api.csproj", "backend-api/"]
RUN dotnet restore "backend-api/backend-api.csproj"
COPY . .
WORKDIR "/src/backend-api"
RUN dotnet build "backend-api.csproj" -c $configuration -o /app/build

FROM build AS publish
ARG configuration=Release
RUN dotnet publish "backend-api.csproj" -c $configuration -o /app/publish /p:UseAppHost=false

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "backend-api.dll"]
