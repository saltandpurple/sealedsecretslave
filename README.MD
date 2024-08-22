# Sealed Secret Slave

Automatically imports secrets from source context/namespace and seals them with destination context/namespace public key.
Can be configured to retain cleartext secrets (careful, don't commit them to git).

## Usage

```bash
sss -sc source-context -sn source-namespace -dc destination-context -dn destination-namespace (-r)
```

## Parameters

- -sc Source context
- -sn Source namespace
- -dc Destination context
- -dn Destination namespace
- -r Retain cleartext secrets


### todo: 
- extend readme
- add mode: live encrypt with base64 decoding
- add mode: bulk encrypt
- add mode: import only (no autosealing against destination)
- auto-generate .gitignore to prevent cleartext secrets from being committed
- add more helpful bash output
- fix file naming