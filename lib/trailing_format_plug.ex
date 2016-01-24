defmodule TrailingFormatPlug do
  @behaviour Plug

  def init(options), do: options

  def call(conn, _opts) do
    case conn.path_info |> List.last do
      nil -> conn
      segment -> trim(conn, segment)
    end
  end

  defp trim(conn, segment) do
    case segment |> String.split(".") |> Enum.reverse do
      [ _ ] -> conn
      [ format | fragments ] ->
        new_path       = fragments |> Enum.reverse |> Enum.join(".")
        path_fragments = List.replace_at conn.path_info, -1, new_path
        params         =
          Plug.Conn.fetch_query_params(conn).params
          |> Dict.put("format", format)
        %{conn | path_info: path_fragments, query_params: params, params: params}
    end
  end
end
