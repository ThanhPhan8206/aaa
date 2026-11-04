# Sử dụng SDK để build ứng dụng
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src
COPY ["TenProjectCuaBan.csproj", "./"]
RUN dotnet restore "TenProjectCuaBan.csproj"
COPY . .
RUN dotnet publish -c Release -o /app/publish

# Chạy ứng dụng trên môi trường Runtime
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS base
WORKDIR /app
EXPOSE 8080
COPY --from=build /app/publish .
ENTRYPOINT ["dotnet", "TenProjectCuaBan.dll"]
