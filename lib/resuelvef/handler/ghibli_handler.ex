defmodule Resuelvef.GhibliHandler do

  @endpoint Application.get_env(:resuelvef, :endpoint)[:ghibli]

  def get_list() do
    "films"
    |> request("get")
  end

  def request(path, method, body \\ nil) do
		request = %HTTPoison.Request{url: "#{@endpoint}#{path}"}
      |> Map.put(:method, method |> String.to_atom)
      |> Map.put(:headers, ["Content-Type": "application/json"])
      |> Map.put(:options, [timeout: 50_000, recv_timeout: 50_000])
    case method == "get" || method == "delete" do
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
