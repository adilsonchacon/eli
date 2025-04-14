defmodule Eli do
  @moduledoc """
  Documentation for `Eli`.
  """

  @doc """
  Sign in.

  ## Examples

      iex> Eli.sign_in("app token", "user.email@domain.com", "secret.password")
      200
      %{
        "data" => %{
          "token" => "JWT session token"
        }
      }

      400
      %{"errors" => %{"detail" => "invalid credentials"}},
  """
  def sign_in(app_token, email, password) do
    url = Eli.Config.base_url() <> "/rest/sessions"

    options = %{
      headers: [{"app-token", app_token}],
      params: %{
        email: email,
        password: password
      }
    }

    RESTApi.post(url, options)
  end

  @doc """
  Checks whether the user is signed in or not.

  ## Examples

      iex> Eli.signed_in("JWT session token")
      :signed_in

      true

      false
  """
  def signed_in(session_token) do
    url = Eli.Config.base_url() <> "/rest/sessions/signed_in"

    options = %{
      headers: [{"authorization", "Bearer #{session_token}"}]
    }

    resp = RESTApi.head(url, options)
    resp.status == 200
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
          "email" => "user.name@domain.com",
          "id" => "732cf1c2-6299-41fa-8784-e458765743b7",
          "language" => "en",
          "name" => "Adilson Chacon",
          "timezone" => "Europe/London"
        }
      }

      404
      %{"errors" => %{"detail" => "Not Found"}},

  """
  def current_user(session_token) do
    url = Eli.Config.base_url() <> "/rest/sessions"

    options = %{
      headers: [{"authorization", "Bearer #{session_token}"}]
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
    url = Eli.Config.base_url() <> "/rest/sessions"

    options = %{
      headers: [{"authorization", "Bearer #{session_token}"}]
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
    url = Eli.Config.base_url() <> "/rest/sessions"

    options = %{
      headers: [{"authorization", "Bearer #{session_token}"}]
    }

    RESTApi.delete(url, options)
  end

  @doc """
  Unlocks user for making the he/she able to sign in again.

  ## Examples

      iex> Eli.unlock("Unlock token")

      202
      %{"data" => %{"message" => "account was successfully unlocked"}}

      404
      %{"errors" => %{"detail" => "Not Found"}}

  """
  def unlock(unlock_token) do
    url = Eli.Config.base_url() <> "/rest/accounts/unlock"

    options = %{
      params: %{token: unlock_token}
    }

    RESTApi.put(url, options)
  end

  @doc """
  Confirms user email.

  ## Examples

      iex> Eli.confirm("Confirmation token")

      202
      %{"data" => %{"message" => "account was successfully confirmed"}}

      404
      %{"errors" => %{"detail" => "Not Found"}}

  """
  def confirm(confirmation_token) do
    url = Eli.Config.base_url() <> "/rest/accounts/confirm"

    options = %{
      params: %{token: confirmation_token}
    }

    RESTApi.put(url, options)
  end

  @doc """
  Requests password recovery.

  ## Examples

      iex> Eli.request_password_recovery("Confirmation token")

      200
      %{"data" => %{"message" => "password recovery was successfully requested"}}

      404
      %{"errors" => %{"detail" => "Not Found"}}

  """
  def request_password_recovery(app_token, email) do
    url = Eli.Config.base_url() <> "/rest/accounts/password/recover"

    options = %{
      headers: [{"app-token", app_token}],
      params: %{email: email}
    }

    RESTApi.post(url, options)
  end

  @doc """
  Recover password updating it.

  ## Examples

      iex> Eli.request_password_recovery("Confirmation token")

      200
      %{"data" => %{"message" => "password was successfully recovered"}}

      400
      %{"errors" => %{"detail" => "token is invalid"}}

      400
      %{"errors" => %{"detail" => "password has an invalid format"}}

      400
      %{"errors" => %{"detail" => "password and confirmation password are different"}}
  """
  def recover_password(token, password, password_confirmation) do
    url = Eli.Config.base_url() <> "/rest/accounts/password/recover"

    options = %{
      params: %{token: token, password: password, password_confirmation: password_confirmation}
    }

    RESTApi.put(url, options)
  end
end
