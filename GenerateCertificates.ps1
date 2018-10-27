$rootCert  =  New-SelfSignedCertificate  `
	-Subject "CN=Root CA,OU=Me,O=MyCompany,L=Brussels,ST=Belgium,C=BE"  `
	-CertStoreLocation cert:\CurrentUser\My `
	-Provider "Microsoft Strong Cryptographic Provider"  `
	-DnsName "MyCompany Root CA"  `
	-KeyLength 2048  `
	-KeyAlgorithm "RSA"  `
	-HashAlgorithm "SHA256"  `
	-KeyExportPolicy "Exportable"  `
	-KeyUsage "CertSign",  "CRLSign"

Export-Certificate -Type CERT -Cert $rootCert -FilePath Server\root.cer
Export-Certificate -Type CERT -Cert $rootCert -FilePath Client\root.cer

$serverIpAddress = "172.18.254.1"

$serverCert = New-SelfSignedCertificate  `
	-Subject "CN=$serviceName,OU=ESF,O=Ingenico,L=Brussels,ST=Belgium,C=BE"  `
	-CertStoreLocation cert:\CurrentUser\My `
	-Provider "Microsoft Strong Cryptographic Provider"  `
	-Signer $rootCert  `
	-TextExtension @("2.5.29.17={text}ipaddress=$serverIpAddress") `
	-KeyLength 2048  `
	-KeyAlgorithm "RSA"  `
	-HashAlgorithm "SHA256"  `
	-KeyExportPolicy "Exportable"

$password = ConvertTo-SecureString -String "password" -AsPlainText -Force

Export-PfxCertificate -Cert $serverCert -Password $password -FilePath Server\server.pfx