FROM microsoft/nanoserver:sac2016 as tool

FROM microsoft/dotnet:2.1-sdk as build
WORKDIR /app
COPY . .
RUN dotnet build -c Release -o bin/

FROM microsoft/dotnet:2.1-runtime-nanoserver-1803

WORKDIR /app
COPY --from=build /app/bin .
COPY --from=build /app/root-ca.cer .

COPY --from=tool /Windows/System32/certoc.exe .
USER ContainerAdministrator
RUN certoc.exe -addstore root root-ca.cer
USER ContainerUser

ENTRYPOINT ["dotnet", "Client.dll"]