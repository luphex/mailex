# Mailex

Mailex is an Elixir library for generating structured, responsive HTML and plain text emails with a consistent layout. It's inspired by Mailgen and provides a simple way to create professional email templates.

## Installation

Add `mailex` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:mailex, git: "https://github.com/luphex/mailex.git", ref: "main"}
  ]
end
```

## Usage

Generate an HTML and text email using the `Mailex.generate/1` function:

```elixir
params = %{
  theme: "default",
  title: "Welcome to Our Service",
  product: %{
    name: "MyApp",
    link: "https://myapp.com"
  },
  intro: [
    "Welcome to our service!",
    "We're glad to have you here."
  ],
  outro: [
    "If you have any questions, feel free to reach out."
  ],
  dictionary: %{
    date: "2023-12-25",
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

{:ok, result} = Mailex.generate(params)
# result.html -> HTML version of the email
# result.text -> Plain text version of the email
```

## Features

- Generates both HTML and plain text versions of emails
- Responsive design that works across mail clients
- Support for:
  - Custom header/title
  - Introduction and outro text
  - Action buttons
  - Data tables with custom column widths and alignments
  - Key-value dictionaries
  - Product branding (name and link)

## Template Structure

The template includes:

- Product header with optional logo
- Main content area with title
- Introduction paragraphs
- Dictionary/key-value section
- Data tables
- Call-to-action buttons
- Outro text
- Footer with copyright

## Configuration

You can configure the templates directory in your config:

```elixir
config :mailex,
  email_templates_directory: "templates",  # Default
  email_application_priv: :mailex         # Default
```

## License

This project is open source under the MIT license.