defmodule Eli.Admin.App do
  defstruct [:name, :description, :organization_id, :unlock_sign_in_url]

  @doc """

  ## Examples

      app = %Eli.Admin.App{name: "New App Name", description: "New App Description", organization_id: "3d36fb7c-bbb6-4b27-8945-c7880de5484f", unlock_sign_in_url: "http://localhost:4000"}

      Eli.Admin.App.create("JWT session token", app)

      #Req.Response<
        status: 201,
        body: %{
          "data" => %{
            "description" => "New App Description",
            "id" => "319f3afa-69bd-4bcc-b168-f26613c9581f",
            "name" => "New App Name"
          }
        },
        ...
      >

  """
  def create(session_token, %Eli.Admin.App{} = app) do
    url = Eli.Config.base_url() <> "/rest/admin/organizations/" <> app.organization_id <> "/apps"

    options = %{
      params: %{
        app: %{
          name: app.name,
          description: app.description,
          unlock_sign_in_url: app.unlock_sign_in_url
        }
      },
      headers: [{"authorization", "Bearer #{session_token}"}]
    }

    RESTApi.post(url, options)
  end

  @doc """

  ## Examples

      Eli.Admin.App.list("JWT session token", "3d36fb7c-bbb6-4b27-8945-c7880de5484f")
      #Req.Response<
        status: 200,
        body: %{
          "data" => [
            %{
              "description" => nil,
              "id" => "5223b223-52f0-4e61-afbe-e44ce60515e4",
              "name" => "App Test"
            },
            %{
              "description" => "New App Description",
              "id" => "319f3afa-69bd-4bcc-b168-f26613c9581f",
              "name" => "New App Name"
            }
          ],
          "pagination" => %{
            "count" => 2,
            "first" => 1,
            "last" => 1,
            "next" => nil,
            "page" => 1,
            "per_page" => 20,
            "prev" => nil,
            "serie" => []
          }
        },
      >

  """
  def list(session_token, organization_id, page \\ 1, per_page \\ 20) do
    url = Eli.Config.base_url() <> "/rest/admin/organizations/" <> organization_id <> "/apps"

    options = %{
      params: %{
        page: page,
        per_page: per_page
      },
      headers: [{"authorization", "Bearer #{session_token}"}]
    }

    RESTApi.get(url, options)
  end

  @doc """

  ## Examples

      Eli.Admin.App.get("JWT session token", "3d36fb7c-bbb6-4b27-8945-c7880de5484f", "5223b223-52f0-4e61-afbe-e44ce60515e4")

      #Req.Response<
        status: 200,
        body: %{
          "data" => %{
            "description" => nil,
            "id" => "5223b223-52f0-4e61-afbe-e44ce60515e4",
            "name" => "App Test"
          }
        },
        ...
      >

  """
  def get(session_token, organization_id, id) do
    url =
      Eli.Config.base_url() <> "/rest/admin/organizations/" <> organization_id <> "/apps/" <> id

    options = %{
      headers: [{"authorization", "Bearer #{session_token}"}]
    }

    RESTApi.get(url, options)
  end

  @doc """

  ## Examples

      app = %Eli.Admin.App{name: "Another App Name", description: "Changed Description", organization_id: "3d36fb7c-bbb6-4b27-8945-c7880de5484f", unlock_sign_in_url: "http://localhost:4000"}

      Eli.Admin.App.update("JWT session token", "319f3afa-69bd-4bcc-b168-f26613c9581f", app)

      #Req.Response<
        status: 200,
        body: %{
          "data" => %{
            "description" => "Changed Description",
            "id" => "319f3afa-69bd-4bcc-b168-f26613c9581f",
            "name" => "Another App Name"
          }
        },
        ...
      >

  """
  def update(session_token, id, %Eli.Admin.App{} = app) do
    url =
      Eli.Config.base_url() <>
        "/rest/admin/organizations/" <> app.organization_id <> "/apps/" <> id

    options = %{
      params: %{
        app: %{
          name: app.name,
          description: app.description,
          unlock_sign_in_url: app.unlock_sign_in_url
        }
      },
      headers: [{"authorization", "Bearer #{session_token}"}]
    }

    RESTApi.put(url, options)
  end

  @doc """

  ## Examples

      Eli.Admin.App.delete("JWT session token", "3d36fb7c-bbb6-4b27-8945-c7880de5484f", "319f3afa-69bd-4bcc-b168-f26613c9581f")

      #Req.Response<
        status: 204,
        body: "",
        ...
      >

  """
  def delete(session_token, organization_id, id) do
    url =
      Eli.Config.base_url() <> "/rest/admin/organizations/" <> organization_id <> "/apps/" <> id

    options = %{
      headers: [{"authorization", "Bearer #{session_token}"}]
    }

    RESTApi.delete(url, options)
  end

  @doc """

  ## Examples

      Eli.Admin.App.list_app_users("JWT session token", "3d36fb7c-bbb6-4b27-8945-c7880de5484f")

      #Req.Response<
        status: 200,
        body: %{
          "data" => [
            %{
              "id" => "b05b504b-d737-4962-835c-f5bc8a2518e2",
              "user" => %{
                "email" => "user.email@example.com",
                "name" => "App User Test"
              }
            }
          ],
          "pagination" => %{
            "count" => 1,
            "first" => 1,
            "last" => 1,
            "next" => nil,
            "page" => 1,
            "per_page" => 20,
            "prev" => nil,
            "serie" => []
          }
        },
        ...
      >

  """
  def list_app_users(session_token, organization_id, id, page \\ 1, per_page \\ 20) do
    url =
      Eli.Config.base_url() <>
        "/rest/admin/organizations/" <> organization_id <> "/apps/" <> id <> "/users"

    options = %{
      params: %{
        page: page,
        per_page: per_page
      },
      headers: [{"authorization", "Bearer #{session_token}"}]
    }

    RESTApi.get(url, options)
  end

  @doc """
  list app user

  ## Examples

      Eli.Admin.App.add_app_user("JWT session token", "3d36fb7c-bbb6-4b27-8945-c7880de5484f", "5223b223-52f0-4e61-afbe-e44ce60515e4", "one.more_user@domain.com", "Secret.123!")
      #Req.Response<
        status: 201,
        body: %{
          "data" => %{
            "id" => "b05b504b-d737-4962-835c-f5bc8a2518e2",
            "user" => %{
              "email" => "user.email@example.com",
              "name" => "App User Test"
            }
          }
        },
        ...
      >
  """
  def add_app_user(session_token, organization_id, id, email, password) do
    url =
      Eli.Config.base_url() <>
        "/rest/admin/organizations/" <> organization_id <> "/apps/" <> id <> "/users"

    options = %{
      params: %{
        password: password,
        email: email
      },
      headers: [{"authorization", "Bearer #{session_token}"}]
    }

    RESTApi.post(url, options)
  end

  @doc """
  remove app user

  ## Examples

      Eli.Admin.App.delete_app_user("JWT session token", "3d36fb7c-bbb6-4b27-8945-c7880de5484f", "5223b223-52f0-4e61-afbe-e44ce60515e4", "")
      #Req.Response<
        status: 204,
        body: "",
        ...
      >
  """
  def remove_app_user(session_token, organization_id, id, app_user_id) do
    url =
      Eli.Config.base_url() <>
        "/rest/admin/organizations/" <>
        organization_id <> "/apps/" <> id <> "/users/" <> app_user_id

    options = %{
      headers: [{"authorization", "Bearer #{session_token}"}]
    }

    RESTApi.delete(url, options)
  end

  @doc """
  Create tokens

  ## Examples

      Eli.Admin.App.create_token("JWT session token", "3d36fb7c-bbb6-4b27-8945-c7880de5484f", "5223b223-52f0-4e61-afbe-e44ce60515e4")
      #Req.Response<
        status: 201,
        body: %{
          "data" => %{
            "app_id" => "5223b223-52f0-4e61-afbe-e44ce60515e4",
            "id" => "29ea1802-1816-4e2a-9763-fd88db73a309",
            "revoked_at" => nil,
            "revoked_by" => nil,
            "token" => "5SD9LpETwFaDX0sL1NO9b6fkLTgaE9Ajm48f29ea1802"
          }
        },
        ...
      >
  """
  def create_token(session_token, organization_id, app_id) do
    url =
      Eli.Config.base_url() <>
        "/rest/admin/organizations/" <> organization_id <> "/apps/" <> app_id <> "/tokens"

    options = %{
      headers: [{"authorization", "Bearer #{session_token}"}]
    }

    RESTApi.post(url, options)
  end

  @doc """
  List tokens

  ## Examples

      Eli.Admin.App.list_tokens("JWT session token", "3d36fb7c-bbb6-4b27-8945-c7880de5484f", "5223b223-52f0-4e61-afbe-e44ce60515e4")
      #Req.Response<
        status: 200,
        body: %{
          "data" => [
            %{
              "app_id" => "5223b223-52f0-4e61-afbe-e44ce60515e4",
              "id" => "d68d6c7f-d2e1-4057-ae57-10211a6839ee",
              "revoked_at" => nil,
              "revoked_by" => nil
            }
          ],
          "pagination" => %{
            "count" => 1,
            "first" => 1,
            "last" => 1,
            "next" => nil,
            "page" => 1,
            "per_page" => 20,
            "prev" => nil,
            "serie" => []
          }
        },
        ...
      >
  """
  def list_tokens(session_token, organization_id, app_id, page \\ 1, per_page \\ 20) do
    url =
      Eli.Config.base_url() <>
        "/rest/admin/organizations/" <> organization_id <> "/apps/" <> app_id <> "/tokens"

    options = %{
      params: %{
        page: page,
        per_page: per_page
      },
      headers: [{"authorization", "Bearer #{session_token}"}]
    }

    RESTApi.get(url, options)
  end

  @doc """
  Show tokens

  ## Examples

      Eli.Admin.App.get_token("JWT session token", "3d36fb7c-bbb6-4b27-8945-c7880de5484f", "5223b223-52f0-4e61-afbe-e44ce60515e4", "63cb25d9-d321-4f0e-aa24-a195e3aea2c4")
      #Req.Response<
        status: 200,
        body: %{
          "data" => %{
            "app_id" => "5223b223-52f0-4e61-afbe-e44ce60515e4",
            "id" => "d68d6c7f-d2e1-4057-ae57-10211a6839ee",
            "revoked_at" => nil,
            "revoked_by" => nil
          }
        },
        ...
      >
  """
  def get_token(session_token, organization_id, app_id, id) do
    url =
      Eli.Config.base_url() <>
        "/rest/admin/organizations/" <> organization_id <> "/apps/" <> app_id <> "/tokens/" <> id

    options = %{
      headers: [{"authorization", "Bearer #{session_token}"}]
    }

    RESTApi.get(url, options)
  end

  @doc """
  Revoke a token

  ## Examples

      Eli.Admin.App.revoke_token("JWT session token", "3d36fb7c-bbb6-4b27-8945-c7880de5484f", "5223b223-52f0-4e61-afbe-e44ce60515e4", "63cb25d9-d321-4f0e-aa24-a195e3aea2c4")
      #Req.Response<
        status: 204,
        body: "",
        ...
      >
  """
  def revoke_token(session_token, organization_id, app_id, id) do
    url =
      Eli.Config.base_url() <>
        "/rest/admin/organizations/" <> organization_id <> "/apps/" <> app_id <> "/tokens/" <> id

    options = %{
      headers: [{"authorization", "Bearer #{session_token}"}]
    }

    RESTApi.delete(url, options)
  end
end
