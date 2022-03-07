FROM mcr.microsoft.com/dotnet/aspnet:6.0 AS base
WORKDIR /app
EXPOSE 80
EXPOSE 443

FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build
WORKDIR /src
COPY ["simple_dotnet_api.csproj", "."]
RUN dotnet restore "./simple_dotnet_api.csproj"
COPY . .
WORKDIR "/src/."
RUN dotnet build "simple_dotnet_api.csproj" -c Release -o /app/build

FROM build AS publish
RUN dotnet publish "simple_dotnet_api.csproj" -c Release -o /app/publish

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "simple_dotnet_api.dll"]