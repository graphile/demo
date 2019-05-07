# PostGraphile simple example

This is a simple demo project that I ([@benjie](https://twitter.com/benjie))
use during some presentations. It is not intended to be a full example of how
to use PostGraphile; better places to look are [the
docs](https://www.graphile.org/postgraphile/), or the [bootstrap-react-apollo
repo](https://github.com/graphile/bootstrap-react-apollo).

## Setup:

First we need to install all the dependencies with `yarn`. (If you don't have
yarn installed, you can install it with `npm install -g yarn`.)

Then we need to create a `graphile_example` repo, an unprivileged `graphql`
database role, and load `schema.sql` into this `graphile_example` repo.  All of
this is handled for us by the `yarn setup` command.

Finally we run `postgraphile` in watch mode.

```
yarn
yarn setup
./node_modules/.bin/postgraphile --watch
```

## The demo

Copy and paste chunks from `demo.sql` into the database as you go. To open a
connection to the database, run:

```
psql graphile_example
```

## Jump to the end

If you prefer to load everything up front rather than step-by-step, you can
install everything in the demo with this one command:

```
psql -Xv ON_ERROR_STOP=1 -f demo.sql graphile_example
```

## Smoke and mirrors

Settings are loaded from `.postgraphilerc.js` to avoid having to write too many
CLI flags. The various options that we used are documented in that file.

The `current_user_id()` function just returns the static number `1`. In a real app
you'd replace this with something like:

```sql
create or replace function current_user_id() returns int as $$
  select nullif(current_setting('jwt.claims.user_id', true), '')::int;
$$ language sql stable;
```

(Note that `jwt.claims.user_id` is only an example, you can substitute
authentication with whatever you like.)

If you're concerned your database connection string could ever be leaked,
you might go with something a bit more paranoid, such as:

```sql
create or replace function current_user_id() returns int as $$
  select user_id
  from app_private.sessions
  where secret = nullif(current_setting('jwt.claims.session_secret', true), '')::uuid;
$$ language sql stable;
```

To read more, see [our Row Level Security
infosheet](https://learn.graphile.org/docs/PostgreSQL_Row_Level_Security_Infosheet.pdf),
our [JWT security guide](https://www.graphile.org/postgraphile/security/), or
the [passport.js implementation in the bootstrap
repo](https://github.com/graphile/bootstrap-react-apollo/blob/65ce5333a3213c3abf48fd3bd5ec412f9484485c/server/middleware/installPostGraphile.js#L152-L188).

## Cleanup:

To delete the database and the user, run:

```
yarn cleanup
```
