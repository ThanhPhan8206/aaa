# Sử dụng SDK .NET 10 để build ứng dụng
FROM mcr.microsoft.com/dotnet/sdk:10.0 AS base-sdk
WORKDIR /src
COPY ["QLSanBong.csproj", "./"]
RUN dotnet restore "QLSanBong.csproj"
COPY . .
RUN dotnet publish -c Release -o /app/publish

# Chạy ứng dụng trên môi trường Runtime .NET 10
FROM mcr.microsoft.com/dotnet/aspnet:10.0 AS base
WORKDIR /app
EXPOSE 8080
COPY --from=base-sdk /app/publish .
ENTRYPOINT ["dotnet", "QLSanBong.dll"]
