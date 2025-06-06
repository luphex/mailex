defmodule MailexTest do
  use ExUnit.Case

  describe "generate/1" do
    test "generates both HTML and text email with valid params" do
      params = %{
        theme: "default",
        title: "Welcome to Our Service",
        product: %{
          name: "TestApp",
          link: "http://testapp.example.com"
        },
        intro: ["Welcome to our service!", "We're glad to have you here."],
        outro: ["If you have any questions, feel free to reach out."],
        dictionary: %{
          date: "2023-01-01",
          reference: "REF123"
        },
        table: [
          %{
            title: "Order Details",
            data: [
              %{
                item: "Basic Plan",
                description: "Monthly subscription",
                price: "$9.99"
              }
            ],
            columns: %{
              custom_width: %{
                item: "30%",
                price: "20%"
              },
              custom_alignment: %{
                price: "right"
              }
            }
          }
        ],
        action: [
          %{
            instructions: "Please verify your account:",
            button: [
              %{
                color: "#4CAF50",
                text: "Verify Account",
                link: "http://example.com/verify"
              }
            ]
          }
        ]
      }

      assert {:ok, result} = Mailex.generate(params)
      assert is_binary(result.html)
      assert is_binary(result.text)
      assert String.contains?(result.html, "Welcome to Our Service")
      assert String.contains?(result.text, "Welcome to Our Service")
    end
  end
end
