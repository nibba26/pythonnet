# 1. .NET SDK 이미지를 기반으로 빌드
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /app

# 2. 프로젝트 파일 복사 및 복원
COPY *.csproj ./
RUN dotnet restore

# 3. 애플리케이션 코드 복사 및 빌드
COPY . ./
RUN dotnet publish -c Release -o /app/out

# 4. 런타임 이미지를 사용해 최종 실행 환경 설정
FROM mcr.microsoft.com/dotnet/runtime:8.0

#RUN apt update && apt install -y build-essential python3-dev
RUN apt update && apt install -y python3-dev


WORKDIR /app
COPY --from=build /app/out ./

# 5. 실행 명령어
ENTRYPOINT ["dotnet", "python-net.dll"]