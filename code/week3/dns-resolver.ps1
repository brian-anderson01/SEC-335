param ($networkpre, $serverip)

for ($i=1; $i -le 255; $i++) {

    Resolve-DnsName -DnsOnly "$networkpre.$i" -Server $serverip -ErrorAction Ignore |
    Select-Object Name, NameHost

}