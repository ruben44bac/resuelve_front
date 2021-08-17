defmodule Resuelvef.HarvardHandler do
  @moduledoc """
  This module takes care of the logical part related to Harvard
  """

  @endpoint Application.get_env(:resuelvef, :endpoint)[:harvar]

  @doc """
  Get the list of films

  ## Parameters

  ## Examples

      iex> Resuelvef.HarvardHandler.get_list(1)
      %{
        "info" => %{
          "next" => "https://api.harvardartmuseums.org/object?apikey=b2b107bb-64f0-4651-99ff-d3b0e15fceb7&size=30&page=2",
          "page" => 1,
          "pages" => 7904,
          "totalrecords" => 237096,
          "totalrecordsperquery" => 30
        },
        "records" => [
          %{
            "title" => "Lid or Bell",
            "dateoflastpageview" => "2021-07-24",
            "groupcount" => 1,
            "dated" => "mid 1st millennium BCE-mid 1st millennium CE",
            "classificationid" => 32,
            "objectid" => 303748,
            "dateoffirstpageview" => "2012-08-21",
            "publicationcount" => 0,
            "period" => "Roman period",
            "creditline" => "Harvard Art Museums/Arthur M. Sackler Museum, Gift of the Misses Norton",
            "dimensions" => "2.6 x 3.5 x 3.5 cm (1 x 1 3/8 x 1 3/8 in.)",
            "id" => 303748,
            "culture" => "Graeco-Roman",
            "medium" => "Bronze",
            "lendingpermissionlevel" => 0,
            "department" => "Department of Ancient and Byzantine Art & Numismatics",
            "exhibitioncount" => 0,
            "peoplecount" => 0,
            "primaryimageurl" => "https://nrs.harvard.edu/urn-3:HUAM:LEG251164_dynmc",
            "relatedcount" => 0,
            "colorcount" => 10,
            "rank" => 51916,
            "division" => "Asian and Mediterranean Art",
            "totaluniquepageviews" => 67,
            "edition" => nil,
            "imagecount" => 4,
            "mediacount" => 0,
            "labeltext" => nil,
            ...
            },
            ...
          ]
      }
  """

  def get_list(page) do
    request("get", page)
    |> build_list()
  end

  defp build_list({:ok, list}), do: list

  defp build_list({:error, _error}), do: []

  defp request(method, page) do
		%HTTPoison.Request{url: "#{@endpoint}&size=32&page=#{page}"}
      |> Map.put(:method, method |> String.to_atom)
      |> Map.put(:headers, ["Content-Type": "application/json"])
      |> Map.put(:options, [timeout: 50_000, recv_timeout: 50_000])
      |> HTTPoison.request
      |> case do
        {:ok, data} -> {:ok, (if data.body == "", do: data.body, else: Poison.decode!(data.body))}
        data -> {:error, data}
      end
  end

end
