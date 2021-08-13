defmodule Resuelvef.GhibliHandler do
  @moduledoc """
  This module takes care of the logical part related to Ghibli
  """

  @endpoint Application.get_env(:resuelvef, :endpoint)[:ghibli]

  @doc """
  Get the list of films

  ## Parameters

  ## Examples

      iex> Resuelvef.GhibliHandler.get_list()
      [
        %{
          "description" => "The orphan Sheeta inherited a mysterious crystal that links her to the mythical sky-kingdom of Laputa. With the help of resourceful Pazu and a rollicking band of sky pirates, she makes her way to the ruins of the once-great civilization. Sheeta and Pazu must outwit the evil Muska, who plans to use Laputa's science to make himself ruler of the world.",
          "director" => "Hayao Miyazaki",
          "id" => "2baf70d1-42bb-4437-b551-e5fed5a87abe",
          "locations" => ["https://ghibliapi.herokuapp.com/locations/"],
          "original_title" => "天空の城ラピュタ",
          "original_title_romanised" => "Tenkū no shiro Rapyuta",
          "people" => ["https://ghibliapi.herokuapp.com/people/"],
          "producer" => "Isao Takahata",
          "release_date" => "1986",
          "rt_score" => "95",
          "running_time" => "124",
          "species" => ["https://ghibliapi.herokuapp.com/species/af3910a6-429f-4c74-9ad5-dfe1c4aa04f2"],
          "title" => "Castle in the Sky",
          "url" => "https://ghibliapi.herokuapp.com/films/2baf70d1-42bb-4437-b551-e5fed5a87abe",
          "vehicles" => ["https://ghibliapi.herokuapp.com/vehicles/"]
        },
        %{
          "description" => "In the latter part of World War II, a boy and his sister, orphaned when their mother is killed in the firebombing of Tokyo, are left to survive on their own in what remains of civilian life in Japan. The plot follows this boy and his sister as they do their best to survive in the Japanese countryside, battling hunger, prejudice, and pride in their own quiet, personal battle.",
          "director" => "Isao Takahata",
          "id" => "12cfb892-aac0-4c5b-94af-521852e46d6a",
          "locations" => ["https://ghibliapi.herokuapp.com/locations/"],
          "original_title" => "火垂るの墓",
          "original_title_romanised" => "Hotaru no haka",
          "people" => ["https://ghibliapi.herokuapp.com/people/"],
          "producer" => "Toru Hara",
          "release_date" => "1988",
          "rt_score" => "97",
          "running_time" => "89",
          "species" => ["https://ghibliapi.herokuapp.com/species/af3910a6-429f-4c74-9ad5-dfe1c4aa04f2"],
          "title" => "Grave of the Fireflies",
          "url" => "https://ghibliapi.herokuapp.com/films/12cfb892-aac0-4c5b-94af-521852e46d6a",
          "vehicles" => ["https://ghibliapi.herokuapp.com/vehicles/"]
        },
        ...
      ]

  """

  @spec get_list :: any
  def get_list() do
    "films"
    |> request("get")
    |> build_list()
  end

  defp build_list({:ok, list}), do: list

  defp build_list({:error, _error}), do: []

  defp request(path, method, body \\ nil) do
		request = %HTTPoison.Request{url: "#{@endpoint}#{path}"}
      |> Map.put(:method, method |> String.to_atom)
      |> Map.put(:headers, ["Content-Type": "application/json"])
      |> Map.put(:options, [timeout: 50_000, recv_timeout: 50_000])
    case (method == "get" || method == "delete") do
      true -> request
      false -> request
        |> Map.put(:body, Poison.encode!(body))
    end
      |> HTTPoison.request
      |> case do
        {:ok, data} -> {:ok, (if data.body == "", do: data.body, else: Poison.decode!(data.body))}
        data -> {:error, data}
      end
  end

end
