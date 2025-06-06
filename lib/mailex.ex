defmodule Mailex do
  @moduledoc """
  Documentation for `Mailgen`.
  """

  defp get_base do
    {:ok,
     :code.priv_dir(Application.get_env(:mailex, :email_application_priv, :mailex))
     |> Path.join(Application.get_env(:mailex, :email_templates_directory, "templates"))}
  end

  @doc """

  ## Examples
      iex> Mailex.generate(
        %{theme: "default",
          title: "Hello world",
          product: %{name: "Trenr", link: "http://www.trenr.me"},
          intro: ["Welcome to Mailgen! We\'re very excited to have you on board."],
          outro: ["Need help, or have questions? Just reply to this email, we\'d love to help."],
          dictionary: %{
            date: "June 11th, 2016",
            address: "123 Park Avenue, Miami, Florida"
          },
          table: [%{
            title: "hello",
            data: [
              %{
                  item: "Node.js",
                  description: "Event-driven I/O server-side JavaScript environment based on V8.",
                  price: "$10.99"
              },
              %{
                  item: "Mailgen",
                  description: "Programmatically create beautiful e-mails using plain old JavaScript.",
                  price: "$1.99"
              }
            ],
            columns: %{
              custom_width: %{
                item: "20%",
                  price: "15%"
                },
              custom_alignment: %{
                price: "right"
              }
            },
          }],
          action: [%{
            instructions: "To get started with Mailgen, please click here:",
            button: [%{
              color: "#22BC66", #optionnal
              text: "Confirm your account",
              link: "https://mailgen.js/confirm?s=d9729feb74992cc3482b350163a1a010"
            }]}]})
      {:ok, %{html: "....", text: "......"}}

  """
  @spec generate(map()) :: {:ok, %{html: binary(), text: binary()}}
  def generate(
        %{
          theme: "default",
          title: title,
          product: %{name: _name, link: _link} = product
        } = params
      ) do
    action = Map.get(params, :action, [])
    table = Map.get(params, :table, [])
    intro = Map.get(params, :intro, [])
    outro = Map.get(params, :outro, [])

    dictionary = Map.get(params, :dictionary, [])

    with {:ok, base} <- get_base() do
      templates =
        %{
          "default.html" => base |> Path.join("default.html.eex") |> EEx.compile_file([]),
          "default.txt" => base |> Path.join("default.txt.eex") |> EEx.compile_file([])
        }

      data = [
        go_to_action: %{
          link: "",
          text: "",
          description: ""
        },
        title: title,
        action: action,
        signature: "Best regards",
        intro: intro,
        outro: outro,
        table: table,
        dictionary: dictionary,
        product: product,
        text_direction: "ltr"
      ]

      {html, _} = Code.eval_quoted(Map.get(templates, "default.html"), data)
      {text, _} = Code.eval_quoted(Map.get(templates, "default.txt"), data)

      {:ok,
       %{
         html: html,
         text: text
       }}
    end
  end
end
