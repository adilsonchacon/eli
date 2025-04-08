defmodule Eli.Admin.Organization do
  defstruct [:name, :description]

  @doc """

  ## Examples

      #Req.Response<
        status: 201,
        body: %{
          "data" => %{
            "description" => "New orgranization description",
            "id" => "bf893f08-72ba-46f7-9320-0aec814d668c",
            "name" => "New Organization"
          }
        },
        ...
      >
  """
  def create(session_token, %Eli.Admin.Organization{} = organization) do
    url = Eli.Config.base_url() <> "/rest/admin/organizations"

    options = %{
      params: %{
        organization: %{
          name: organization.name,
          description: organization.description
        }
      },
      headers: [{"authorization", "Bearer #{session_token}"}]
    }

    RESTApi.post(url, options)
  end

  @doc """

  ## Examples
      #Req.Response<
        status: 200,
        body: %{
          "data" => [
            %{
              "description" => "A description example",
              "id" => "76f4b18b-e612-438c-a1e2-74b12beccdd1",
              "name" => "Org Name Example"
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
  def list(session_token, page \\ 1, per_page \\ 20) do
    url = Eli.Config.base_url() <> "/rest/admin/organizations"

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
      #Req.Response<
        status: 200,
        body: %{
          "data" => %{
            "description" => "A description example",
            "id" => "76f4b18b-e612-438c-a1e2-74b12beccdd1",
            "name" => "Org Name Example"
          }
        },
        ...
      >
  """
  def get(session_token, id) do
    url = Eli.Config.base_url() <> "/rest/admin/organizations/" <> id

    options = %{
      headers: [{"authorization", "Bearer #{session_token}"}]
    }

    RESTApi.get(url, options)
  end

  @doc """

  ## Examples
      #Req.Response<
        status: 200,
        body: %{
          "data" => %{
            "description" => "New Some description",
            "id" => "00543b54-ab48-458d-b73a-3fe0177315aa",
            "name" => "New name for Organization"
          }
        },
        ...
      >
  """
  def update(session_token, id, %Eli.Admin.Organization{} = organization) do
    url = Eli.Config.base_url() <> "/rest/admin/organizations/" <> id

    options = %{
      params: %{
        organization: %{
          name: organization.name,
          description: organization.description
        }
      },
      headers: [{"authorization", "Bearer #{session_token}"}]
    }

    RESTApi.put(url, options)
  end

  @doc """

  ## Examples
      #Req.Response<
        status: 204,
        body: ""
        },
        ...
      >
  """
  def delete(session_token, id) do
    url = Eli.Config.base_url() <> "/rest/admin/organizations/" <> id

    options = %{
      headers: [{"authorization", "Bearer #{session_token}"}]
    }

    RESTApi.delete(url, options)
  end

  @doc """

  ## Examples

      Eli.Admin.Organization.list_admin_user(
        "Session token",
        "c28de4d1-14ea-4494-99a9-cf7cf9f8f186")

      #Req.Response<
        status: 200,
        body: %{
          "data" => [
            %{
              "id" => "d008ae02-29a4-4cf5-95d9-2cd90fc29b4c",
              "user" => %{
                "email" => "user@domain.com",
                "name" => "User Name"
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
  def list_admin_users(session_token, id, page \\ 1, per_page \\ 20) do
    url = Eli.Config.base_url() <> "/rest/admin/organizations/" <> id <> "/admin_users"

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
      Eli.Admin.Organization.add_admin_user(
        "Session token",
        "c28de4d1-14ea-4494-99a9-cf7cf9f8f186",
        "user.email@domain.com")

      #Req.Response<
        status: 201,
        body: %{
          "data" => %{
            "id" => "d008ae02-29a4-4cf5-95d9-2cd90fc29b4c",
            "user" => %{
              "email" => "user@domain.com",
              "name" => "User Name"
            }
          },
        },
        ...
      >
  """
  def add_admin_user(session_token, id, email) do
    url = Eli.Config.base_url() <> "/rest/admin/organizations/" <> id <> "/admin_users"

    options = %{
      params: %{
        email: email
      },
      headers: [{"authorization", "Bearer #{session_token}"}]
    }

    RESTApi.post(url, options)
  end

  @doc """

  ## Examples
      Eli.Admin.Organization.remove_admin_user(
        "Session token",
        "c28de4d1-14ea-4494-99a9-cf7cf9f8f186",
        "47dff89a-97ca-4eca-8057-2a9398d90e03")

      #Req.Response<
        status: 204,
        body: "",
        ...
      >
  """
  def remove_admin_user(session_token, id, organization_admin_user_id) do
    url =
      Eli.Config.base_url() <>
        "/rest/admin/organizations/" <> id <> "/admin_users/" <> organization_admin_user_id

    options = %{
      headers: [{"authorization", "Bearer #{session_token}"}]
    }

    RESTApi.delete(url, options)
  end
end
