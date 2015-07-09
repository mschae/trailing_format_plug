TrailingFormatPlug
==================
[![Build Status](https://travis-ci.org/mschae/trailing_format_plug.svg?branch=master)](https://travis-ci.org/mschae/trailing_format_plug)

## Usage

Add the `trailing_format_plug` dependency to your `mix.exs` as follows:

```elixir
def deps do
  #  ...
  {:trailing_format_plug, "~> 0.0.3"}
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
    plug :super
  end
end
```

## License

Copyright 2014 Michael Schaefermeyer

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
