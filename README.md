# PostGraphile simple example

Setup:

```
createdb graphile_example
createuser graphql
psql -Xf schema.sql graphile_example
yarn
./node_modules/.bin/postgraphile --watch
```

Computed columns/etc can be installed with:

```
psql -Xf demo.sql graphile_example
```

Settings are loaded from `.postgraphilerc.js` to avoid having to write too many CLI flags.

Cleanup:

```
dropdb graphile_example
dropuser graphql
```
