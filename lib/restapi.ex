defmodule RESTApi do
  @moduledoc """
  Documentation for `RESTApi`.
  """

  @doc """
  Post.

  ## Examples

      iex> RESTApi.post("/rest/your/endpoint", %{params: %{foo: "bar"}, headers: %{token: "A_TOKEN" }})
      :post

  """
  def post(url, %{} = options) do
    Req.post!(
      url,
      headers: normalize_headers(options[:headers]),
      json: options[:params]
    )
  end

  @doc """
  Put.

  ## Examples

      iex> RESTApi.put("/rest/your/endpoint", %{params: %{foo: "bar"}, headers: %{token: "A_TOKEN" }})
      :put

  """
  def put(url, %{} = options) do
    Req.put!(
      url,
      headers: normalize_headers(options[:headers]),
      json: options[:params]
    )
  end

  @doc """
  Patch.

  ## Examples

      iex> RESTApi.patch("/rest/your/endpoint", %{params: %{foo: "bar"}, headers: %{token: "A_TOKEN" }})
      :patch

  """
  def patch(url, %{} = options) do
    Req.patch!(
      url,
      headers: normalize_headers(options[:headers]),
      json: options[:params]
    )
  end

  @doc """
  Get.

  ## Examples

      iex> RESTApi.get("/rest/your/endpoint", %{params: %{foo: "bar"}, headers: %{token: "A_TOKEN" }})
      :get

  """
  def get(url, %{} = options) do
    Req.get!(
      build_url(url, options[:params]),
      headers: normalize_headers(options[:headers])
    )
  end

  @doc """
  Head.

  ## Examples

      iex> RESTApi.head("/rest/your/endpoint", %{params: %{foo: "bar"}, headers: %{token: "A_TOKEN" }})
      :head

  """
  def head(url, %{} = options) do
    Req.head!(
      build_url(url, options[:params]),
      headers: normalize_headers(options[:headers])
    )
  end

  @doc """
  Delete.

  ## Examples

      iex> RESTApi.delete("/rest/your/endpoint", %{params: %{foo: "bar"}, headers: %{token: "A_TOKEN" }})
      :delete

  """
  def delete(url, %{} = options) do
    Req.delete!(
      build_url(url, options[:params]),
      headers: normalize_headers(options[:headers])
    )
  end

  defp normalize_headers(headers) do
    headers = build_headers(headers)

    if headers_have_app_json_content_type(headers) do
      headers
    else
      Enum.concat(headers, build_headers())
    end
  end

  defp build_headers(headers) when is_map(headers) do
    Enum.map(headers.keys, fn key -> { "#{key}", "#{headers[key]}" } end)
  end

  defp build_headers(headers) when is_list(headers) do
    headers
  end

  defp build_headers(headers) when is_tuple(headers) do
    [headers]
  end

  defp build_headers(nil) do
    build_headers()
  end

  defp build_headers() do
    [
      {"content-type", "application/json"}
    ]
  end

  defp headers_have_app_json_content_type(headers) do
    Enum.find(headers, fn header ->
      ["CONTENT-TYPE", "APPLICATION/JSON"] == Enum.map(Tuple.to_list(header), fn h -> String.upcase("#{h}") end)
    end)
  end

  defp build_url(url, nil) do
    build_url(url, %{})
  end

  defp build_url(url, %{} = extra_params) do
    uri = URI.parse(url)

    Map.merge(uri, %{query: build_url_params(uri.query, extra_params)})
    |> URI.to_string
  end

  defp build_url_params(query_params, %{} = extra_params) do
    params = unless is_nil(query_params) do
      URI.decode_query(query_params)
    else
      %{}
    end

    Map.merge(params, extra_params)
    |> URI.encode_query
  end

end
