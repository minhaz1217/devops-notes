
### install SEQ Cli
```
dotnet tool install --global seqcli
```

```
nC3sSXoDxDPbUqHAG6hC
seqcli config -k connection.serverUrl -v http://localhost:3003
seqcli config -k connection.apiKey -v nC3sSXoDxDPbUqHAG6hC
```
### Test that it is working
```
echo "Hello, world!" | seqcli ingest
```
seqcli ingest -i *.log --extract="{@m:*}" // the very basic one
seqcli ingest -i *.log --extract="{@t} -- {@l:level} -- {@m:*}{:n}{@x:*}" //worked
seqcli ingest -i *.log --extract="{@t:timestamp},{val1} -- {@l:level} -- {service} -- {@m:*}{:n}{@x:*}" -p Environment=test4 // successfully worked for the file
seqcli ingest -i *.log --extract="{@t:timestamp},{val1} -- {@l:level} -- {service} -- {@m:*}{:n}{@x:*}" -p Environment=test5 --invalid-data=ignore // it worked as well

seqcli ingest -i *.log --extract="{@t:timestamp},{ignoreVal1} -- {@l:level} -- {@m:={service} -- {msg:*}}{:n}{@x:*}" -p Environment=test8 --invalid-data=ignore // worked perfectly




echo 2025-02-15 08:28:28,303 -- DEBUG -- Identity -- The token request was successfully validated. | seqcli ingest --extract="{@t}, {@m:*}{:n}{@x:*}" -p Environment=Test2


echo 2025-02-15 08:28:28,303 -- DEBUG -- Identity -- The token request was successfully validated. | seqcli ingest --extract="{@t:timestamp}-- {@m:*}{:n}{@x:*}" -p Environment=Test2

// worked
echo 2025-02-15 08:28:28,303 The token request was successfully validated. | seqcli ingest --extract="{@t:timestamp}{@m:*}{:n}{@x:*}" -p Environment=Test2

// val1 working
echo 2025-02-15 08:28:28,303 The token request was successfully validated. | seqcli ingest --extract="{@t:timestamp},{val1}{@m:*}{:n}{@x:*}" -p Environment=Test2

// properly getting
echo 2025-02-15 08:28:28,303 -- DEBUG -- Identity -- The token request was successfully validated. | seqcli ingest --extract="{@t:timestamp},{val1} -- {@l:level} -- {service} -- {@m:*}{:n}{@x:*}" -p Environment=Test2



https://blog.datalust.co/parsing-plain-text-logs-with-seqcli/
https://docs.datalust.co/docs/command-line-client#extraction-patterns