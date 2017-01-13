defmodule TrailingFormatPlug do
  @behaviour Plug

  def init(options), do: options

  def call(%{path_info: []} = conn, _opts), do: conn
  def call(conn, _opts) do
    conn.path_info |> List.last |> String.split(".") |> Enum.reverse |> case do
      [ _ ] -> conn
      [ format | fragments ] ->
        new_path       = fragments |> Enum.reverse |> Enum.join(".")
        path_fragments = List.replace_at conn.path_info, -1, new_path
        params         =
          Plug.Conn.fetch_query_params(conn).params
          |> Dict.put("_format", format)
          |> Dict.put(new_path, new_path)
        %{conn | path_info: path_fragments, query_params: params, params: params}
    end
  end
end
