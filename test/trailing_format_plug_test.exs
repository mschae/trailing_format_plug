defmodule TrailingFormatPlugTest do
  use ExUnit.Case, async: true
  use Plug.Test

  @opts TrailingFormatPlug.init([])

  test "plug removes trailing format" do
    conn = conn(:get, "/foo/bar.json")

    conn = TrailingFormatPlug.call(conn, @opts)

    assert conn.path_info == ["foo", "bar"]
  end

  test "plug does nothing without trailing format" do
    conn = conn(:get, "/foo/bar")

    conn = TrailingFormatPlug.call(conn, @opts)

    assert conn.path_info == ["foo", "bar"]
  end

  test "plug adds format to conn.params" do
    conn =
      conn(:get, "/foo/bar.json")
      |> Plug.Conn.fetch_query_params

    conn = TrailingFormatPlug.call(conn, @opts)

    assert conn.params["_format"] == "json"
  end
end
