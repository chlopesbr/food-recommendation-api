FROM mcr.microsoft.com/dotnet/sdk:5.0 AS build-env
COPY . /app

WORKDIR /app/src/FR.API
RUN dotnet publish -c Release -o out

FROM mcr.microsoft.com/dotnet/aspnet:5.0
WORKDIR /app/dll
COPY --from=build-env /app/src/FR.API/out /app/dll

ENV ASPNETCORE_ENVIRONMENT=Development
ENV FR_DATABASE_NAME=food-recommendation

CMD ["dotnet", "FR.API.dll"]