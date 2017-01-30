defmodule KslNotifier do
  @categories "http://www.ksl.com/?nid=13"
  @search "http://www.ksl.com/?nid=231&nocache=1&sort=5&search="
  def get_category_links do
    categories = HTTPoison.get!(@categories)
      |> Map.get(:body)
      |> Floki.find(".categorySubsItem, a")

    categories
      |> Floki.attribute("href")
      |> Enum.filter(fn(link) -> String.starts_with?(link, "/classifieds")end)

    #categories
      #|> Floki.find(".categorySubsItemTitle")
      #|> Floki.text
      #|> IO.inspect
      #|> String.split(" ")
  end

  def scrape_page(search_term) do
    HTTPoison.get!(@search <> search_term)
      |> Map.get(:body)
      |> Floki.find(".adTitle a")
      |> Floki.text
      |> IO.inspect
  end

  def free_items do
    HTTPoison.get!("http://www.ksl.com/?nid=231&cat=272&category=349")
      |> Map.get(:body)
      |> Floki.find(".adTitle, a.listlink")
      |> IO.inspect
  end
end
