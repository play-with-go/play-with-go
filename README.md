# Contributing

Details to follow.

## Prerequisite 1 - GitHub account with `userguides` membership

A number of the play-with-go guides require the reader to commit code to a
remote source control server (for example publishing modules). The creation
of user account and any repositories happens automatically when a guide is
opened. This setup works via GitHub. Hence to develop any guides locally
you need to have a GitHub account and various permissions.

Please [raise an
issue](https://github.com/play-with-go/play-with-go/issues/new?title=access:%20please%20grant%20me%20access%20to%20develop%20guides)
requesting member accessing to the [`userguides`](https://github.com/userguides) organisation.

Once you have been granted access, [create a new personal access token](https://github.com/settings/tokens/new) with
`public_repo` scope.

Then set the following two environment variables:

* `PLAYWITHGODEV_GITHUB_USER`
* `PLAYWITHGODEV_GITHUB_PAT`

## Prerequisite 2 - `mkcert`-created play-with-go.dev SSL certificate

Firstly install [`mkcert`](https://github.com/FiloSottile/mkcert).

Then create a play-with-go.dev SSL certificate:

```
pushd $(mkcert -CAROOT)
mkdir play-with-go.dev
mkcert -cert-file play-with-go.dev/cert.pem -key-file play-with-go.dev/key.pem "*.play-with-go.dev" play-with-go.dev
popd
```

## Setup

In one terminal:

```
./_scripts/dc.sh up
```

_(we use `up` here as opposed to `up -d` because the log output is useful for debugging purposes)_

In another terminal:

```
./_scripts/setup.sh
```

to create the admin user.


## Regenerating guides

Regenerate guides using `preguide` via:

```
./_scripts/generateGuides.sh
```

For more verbose logging:

```
PREGUIDE_DEBUG=true ./_scripts/generateGuides.sh
```

To regenerate guides, skipping any cache checks:

```
PREGUIDE_SKIP_CACHE=true ./_scripts/generateGuides.sh
```

## Viewing a guide

For now you also need to run the [SDK](https://github.com/play-with-docker/sdk) locally, specifically [this
PR](https://github.com/play-with-docker/sdk/pull/35). Follow the instructions in that project's README to start the
`sdktest` container.

Then visit http://localhost:4000 and choose the guide from the list.
