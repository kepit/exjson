defprotocol ExJSON.Generator do
  def generate(element)
end

defimpl ExJSON.Generator, for: Atom do
  def generate(atom), do: inspect(atom_to_binary(atom))
end

defimpl ExJSON.Generator, for: BitString do
   def generate(thing) do
     if String.valid?(thing) do
 	inspect(thing)
     else
	"#{ExJSON.Generator.generate(Hex.encode(thing))}"
     end
   end
end

defimpl ExJSON.Generator, for: Float do
  def generate(number), do: "#{number}"
end

defimpl ExJSON.Generator, for: Integer do
  def generate(number), do: "#{number}"
end

defimpl ExJSON.Generator, for: Tuple do
  def generate({}), do: "{}"

  def generate({key, value}) do
    "#{ExJSON.Generator.generate(key)}:#{ExJSON.Generator.generate(value)}"
  end

  def generate({val}) do
    "#{ExJSON.Generator.generate(val)}"
  end
end

defimpl ExJSON.Generator, for: List do
  def generate([]), do: "{}"
  def generate([{}]), do: "{}"

  def generate(list) do
    if has_tuple?(list) do
      "{#{jsonify(list)}}"
    else
      "[#{jsonify(list)}]"
    end
  end

  defp jsonify(list) do
    Enum.join(Enum.map(list, &ExJSON.Generator.generate(&1)),",")
  end

  defp has_tuple?(list) when is_list(list) do
    Enum.any?(list, fn(x) -> is_tuple(x) end)
  end

  defp has_tuple?(_) do
    false
  end
end

