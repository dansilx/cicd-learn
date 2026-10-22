FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src

COPY ["cicd-learn.csproj", "./"]
RUN dotnet restore "cicd-learn.csproj"

COPY . .
RUN dotnet publish "cicd-learn.csproj" -c Release -o /app/publish /p:UseAppHost=false

FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS final
WORKDIR /app

COPY --from=build /app/publish .

EXPOSE 8080

ENTRYPOINT ["dotnet", "cicd-learn.dll"]