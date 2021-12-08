# MapToXml

Converts an Elixir map to an XML document. Inspired by [XmlToMap](https://github.com/homanchou/elixir-xml-to-map).

Documentation can be found at [https://hexdocs.pm/elixir_map_to_xml](https://hexdocs.pm/elixir_map_to_xml).

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `elixir_map_to_xml` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:elixir_map_to_xml, "~> 0.1.0"}
  ]
end
```

## Usage

### Basic example

```elixir
MapToXml.from_map(%{
  "tag1" => "value1",
  "tag2" => "value2",
  "tag3" => "value3"
})
```

will output:

```xml
<?xml version="1.0" encoding="UTF-8"?>
<tag1>value1</tag1>
<tag2>value2</tag2>
<tag3>value3</tag3>
```

### Nested maps

```elixir
MapToXml.from_map(%{
  "tag1" => %{
    "tag2" => %{
      "tag3" => "value"
    }
  }
})
```

will output:

```xml
<?xml version="1.0" encoding="UTF-8"?>
<tag1>
  <tag2>
    <tag3>value</tag3>
  </tag2>
</tag1>
```

### Repeated child tags

```elixir
MapToXml.from_map(%{
  "Tags" => %{
    "Tag1" => [
      %{"Sub1" => "Val1"},
      %{"Sub1" => "Val2"},
      %{"Sub1" => "Val3"}
    ]
  }
})
```

will output:

```xml
<?xml version="1.0" encoding="UTF-8"?>
<Tags>
  <Tag1>
    <Sub1>Val1</Sub1>
  </Tag1>
  <Tag1>
    <Sub1>Val2</Sub1>
  </Tag1>
  <Tag1>
    <Sub1>Val3</Sub1>
  </Tag1>
</Tags>
```

### Attributes

```elixir
MapToXml.from_map(%{
  "Tag1" => %{
    "#content" => "some value",
    "-id" => 123,
    "-something" => "111"
  }
})
```

will output:

```xml
<?xml version="1.0" encoding="UTF-8"?>
<Tag1 id="123" something="111">some value</Tag1>
```

## OrdMap

[OrdMap](https://github.com/MartinKavik/ord_map) are supported, but it raises if normal maps are
used together.

See [tests](test/map_to_xml_test.exs) for some more examples.
