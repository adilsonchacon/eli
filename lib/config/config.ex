defmodule Eli.Config do
  @moduledoc """
  Documentation for `Eli.Config`.
  """

  @spec base_url(binary()) :: nil
  @doc """
  Set base_url value

  ### Example
    Eli.Config.base_url("http://localhost:4000")
  """
  def base_url(value) when is_binary(value) do
    Process.put(:eli_config_base_url, value)
  end

  @spec base_url() :: binary()
  @doc """
  Get base_url value

  ### Example
    Eli.Config.base_url()
  """
  def base_url() do
    Process.get(:eli_config_base_url)
  end
end
