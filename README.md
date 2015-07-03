# TrailingFormatPlug [![Build Status](https://travis-ci.org/mschae/trailing_format_plug.svg?branch=master)](https://travis-ci.org/mschae/trailing_format_plug)

An elixir plug to support legacy APIs that use a rails-like trailing format e.g. http://api.dev/resources.json

## Installation

Add the `trailing_format_plug` dependency to your `mix.exs` as follows:

```elixir
def deps do
  #  ...
  {:trailing_format_plug, "~> 0.0.2"}
  # ...
end
```

## Usage

If you are using phoenix:

Add the plug before the router to your ```endpoint.ex```

```elixir
# ...
  plug TrailingFormatPlug

  plug :router, InfiltraderApi.Router
end

```
