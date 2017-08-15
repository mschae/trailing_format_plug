defmodule TrailingFormatPlug do
  @moduledoc """
  Trailing Format Plug takes a trailing format after a dot and turns it
  into the _format type.
  
  Optionally can take a `valid: []` list of string valid formats to
  exactly match or can take a 1-arg function to do custom testing.
  """
  @behaviour Plug

  def init(options), do: options

  def call(%{path_info: []} = conn, _opts), do: conn
  def call(conn, opts) do
    path = conn.path_info |> List.last() |> String.split(".") |> Enum.reverse()

    case path do
      [ _ ] ->
        conn

      [ format | fragments ] ->
        opts[:valid]
        |> case do
          [] -> true
          nil -> true
          formats when is_list(formats) -> Enum.member?(formats, format)
          f when is_function(f, 1) -> f.(format)
        end
        |> if do
          new_path       = fragments |> Enum.reverse() |> Enum.join(".")
          path_fragments = List.replace_at conn.path_info, -1, new_path
          params         =
            Plug.Conn.fetch_query_params(conn).params
            |> update_params(new_path, format)
            |> Map.put("_format", format)

          %{
            conn |
            path_info: path_fragments,
            query_params: params,
            params: params
          }
        else
          conn
        end
    end
  end

  defp update_params(params, new_path, format) do
    wildcard = Enum.find params, fn {_, v} -> v == "#{new_path}.#{format}" end

    case wildcard do
      {key, _} ->
        Map.put(params, key, new_path)

      _ ->
        params
    end
  end
end
