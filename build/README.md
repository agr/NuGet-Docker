Image for building service binaries.

```
docker build -t gallery-build .
docker run --rm -v e:\build-output:c:\output gallery-build
```

Will produce builds under `e:\build-output`.