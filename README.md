# Backend

## Build

In order to build and start you application the following steps are required

- Clone the repository `git clone https://github.com/genpag/backend`
- Install dependencies with `mix deps.get`
- Create and migrate the database with `mix ecto.setup`
- Start Phoenix endpoint with `iex -S mix phx.server`

## Usage

The endpoins with examples are listed on the `collection.json` file at the root directory of the repo.

## Tests and code analysis

Tests are included on the reposory and configured in `config/test.exs`, in order to run the tests use the
`mix test` command. And to run the code analysis with [credo](https://github.com/rrrene/credo) use the
`mix credo` command.
