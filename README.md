TrailingFormatPlug
==================
[![Build Status](https://travis-ci.org/mschae/trailing_format_plug.svg?branch=master)](https://travis-ci.org/mschae/trailing_format_plug)

## Usage

Add the `trailing_format_plug` dependency to your `mix.exs` as follows:

```elixir
def deps do
  #  ...
  {:trailing_format_plug, "~> 0.0.1"}
  # ...
end
```

If you are using phoenix:

Add the plug to the `:before` pipeline in your router.ex:

```elixir
defmodule Djay.Router do
  use Phoenix.Router

  pipeline :before do
    plug TrailingFormatPlug
    super
  end
```
