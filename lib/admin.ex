defmodule Eli.Admin do
  @moduledoc """
  Documentation for `Eli`.
  """

  @doc """
  Sign in.

  ## Examples

      iex> Eli.Admin.sign_in("user.email@domain.com", "seCr#t.passw0rd")
      200
      %{
        "data" => %{
          "token" => "JWT session token"
        }
      }

      400
      %{"errors" => %{"detail" => "invalid credentials"}},
  """
  def sign_in(email, password) do
    url = Eli.Config.base_url() <> "/rest/admin/sessions"
    options = %{
      params: %{
        email: email,
        password: password
      }
    }

    RESTApi.post(url, options)
  end

  @doc """
  Returns the current user data.

  ## Examples

      iex> Eli.signed_in("JWT session token")
      :signed_in

      200
      %{
        "data" => %{
          "active" => true,
          "email" => "user@mail.com",
          "id" => "732cf1c2-6299-41fa-8784-e458765743b7",
          "language" => "en",
          "name" => "User Name",
          "timezone" => "Europe/London"
        }
      }

      404
      %{"errors" => %{"detail" => "Not Found"}},

  """
  def current_user(session_token) do
    url = Eli.Config.base_url() <> "/rest/admin/sessions"
    options = %{
      headers: [ {"authorization", "Bearer #{session_token}"} ],
    }

    RESTApi.get(url, options)
  end

  @doc """
  Refresh your token session returning a new session token.

  ## Examples

      iex> Eli.refresh("JWT session token")

      200
      %{
        "data" => %{
          "token" => "JWT session token"
        }
      }

      404
      %{"errors" => %{"detail" => "Not Found"}},

  """
  def refresh(session_token) do
    url = Eli.Config.base_url() <> "/rest/admin/sessions"
    options = %{
      headers: [ {"authorization", "Bearer #{session_token}"} ],
    }

    RESTApi.put(url, options)
  end

  @doc """
  Signs user out closing and deleting session.

  ## Examples

      iex> Eli.sign_out("JWT session token")

      200
      %{"data" => %{"message" => "signed out successfully"}}

      404
       %{"errors" => %{"detail" => "Not Found"}}
  """
  def sign_out(session_token) do
    url = Eli.Config.base_url() <> "/rest/admin/sessions"
    options = %{
      headers: [ {"authorization", "Bearer #{session_token}"} ],
    }

    RESTApi.delete(url, options)
  end

  @doc """
  Unlocks user for making the he/she able to sign in again.

  ## Examples

      iex> Eli.unlock("Unlock token")

      200
      %{"data" => %{"message" => "account was successfully unlocked"}}

      404
      %{"errors" => %{"detail" => "Not Found"}}

  """
  def unlock(unlock_token) do
    url = Eli.Config.base_url() <> "/rest/sessions/unlock"
    options = %{
      params: %{ token: unlock_token }
    }

    RESTApi.put(url, options)
  end
end
