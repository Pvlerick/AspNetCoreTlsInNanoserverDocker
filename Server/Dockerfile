FROM microsoft/nanoserver:sac2016 as tool

FROM microsoft/dotnet:2.1-aspnetcore-runtime-nanoserver-1803

WORKDIR /app
COPY /bin/publish .

COPY --from=tool /Windows/System32/certoc.exe .

USER ContainerAdministrator
RUN certoc.exe -addstore root root-ca.cer
USER ContainerUser

ENTRYPOINT ["dotnet", "Server.dll"]