defmodule TrailingFormatPlug do
  @moduledoc """
  Allows you to define urls like

  /foo/:bar

  and receive paths like

  /foo/whatever.json

  - You can define a route whitelist in your 
    `config.exs`
    
    ```elixir
    config :trailing_format_plug,
      urls: ["/some/path/:foo", "/other/bar"]
    ```

    The Plug will be applied to:
    /some/path/whatever.js
    /other/bar.json

  - If you no define any whitelist, the Plug
    will be applied to every route

  """
  @behaviour Plug
  use Plug.Router

  plug :match
  plug :dispatch

  @urls Application.get_env(:trailing_format_plug, :routes) || 
    :no_routes

  case @urls do
    # There are configured routes:
    # take the format just for those
    # routes.
    [_ | _] -> Enum.map(@urls, &(
        match &1 do
          conn |> TrailingFormatPlug.add_format       
        end
        )
      )
      match _ do
        conn
      end
    # There are no configured routes: take
    # the format always.
    :no_routes -> 
      match _ do
        case conn do
          %{path_info: []} -> conn
          conn -> conn |> TrailingFormatPlug.add_format
        end
      end
  end

  def add_format(conn) do
    conn.path_info |> List.last() |> String.split(".") |> Enum.reverse |> case do
      [ _ ] -> conn
      [ format | fragments ] ->
        new_path       = fragments |> Enum.reverse |> Enum.join(".")
        path_fragments = List.replace_at conn.path_info, -1, new_path
        params         =
          Plug.Conn.fetch_query_params(conn).params
          |> Dict.put("_format", format)
        %{conn | path_info: path_fragments, query_params: params, params: params}
    end
  end
end
