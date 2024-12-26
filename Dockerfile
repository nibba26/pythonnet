# 1. .NET SDK �̹����� ������� ����
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /app

# 2. ������Ʈ ���� ���� �� ����
COPY *.csproj ./
RUN dotnet restore

# 3. ���ø����̼� �ڵ� ���� �� ����
COPY . ./
RUN dotnet publish -c Release -o /app/out

# 4. ��Ÿ�� �̹����� ����� ���� ���� ȯ�� ����
FROM mcr.microsoft.com/dotnet/runtime:8.0

#RUN apt update && apt install -y build-essential python3-dev
RUN apt update && apt install -y python3-dev


WORKDIR /app
COPY --from=build /app/out ./

# 5. ���� ��ɾ�
ENTRYPOINT ["dotnet", "python-net.dll"]