# Sealed Secret Slave

Automatically imports secrets from source context/namespace and seals them with destination context/namespace public key.
Can be configured to retain cleartext secrets (careful, don't commit them to git).

## Usage

```bash
sealed-secret-slave -sc source-context -sn source-namespace -dc destination-context -dn destination-namespace
```

## Parameters

- -sc Source context
- -sn Source namespace
- -dc Destination context
- -dn Destination namespace
- -r Retain cleartext secrets


### todo: 
- convert to installable brew package
- create tap
- extend readme