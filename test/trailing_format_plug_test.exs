defmodule TrailingFormatPlugTest do
  use ExUnit.Case, async: true
  use Plug.Test

  @no_opts TrailingFormatPlug.init([])
  @opts TrailingFormatPlug.init(["json"])

  describe "when formats are passed as options" do
    test "plug ignores formats that are not passed as options" do
      conn = conn(:get, "/foo/bar.html")

      conn = TrailingFormatPlug.call(conn, @opts)

      assert conn.path_info == ["foo", "bar.html"]
    end

    test "plug removes trailing format included in options" do
      conn = conn(:get, "/foo/bar.json")

      conn = TrailingFormatPlug.call(conn, @opts)

      assert conn.path_info == ["foo", "bar"]
    end
  end

  describe "when options are not passed" do
    test "plug removes trailing format" do
      conn = conn(:get, "/foo/bar.json")

      conn = TrailingFormatPlug.call(conn, @no_opts)

      assert conn.path_info == ["foo", "bar"]
    end

    test "plug does nothing without trailing format" do
      conn = conn(:get, "/foo/bar")

      conn = TrailingFormatPlug.call(conn, @no_opts)

      assert conn.path_info == ["foo", "bar"]
    end

    test "plug adds format to conn.params" do
      conn =
        conn(:get, "/foo/bar.json")
        |> Plug.Conn.fetch_query_params

      conn = TrailingFormatPlug.call(conn, @no_opts)
      assert conn.params["_format"] == "json"
    end

    test "plug removes .json from param" do
      params = Map.put(%{}, "sport", "hockey.json")

      conn =
        conn(:get, "/api/hockey.json")
        |> Plug.Conn.fetch_query_params
        |> Map.put(:params, params)

      conn = TrailingFormatPlug.call(conn, @no_opts)
      assert conn.params["_format"] == "json"
      assert conn.params["sport"] == "hockey"
    end

    test "plug supports empty path_info" do
      conn =
        conn(:get, "/")
        |> Plug.Conn.fetch_query_params

      conn = TrailingFormatPlug.call(conn, @no_opts)

      assert conn.path_info == []
      refute conn.params["_format"]
    end
  end
end
