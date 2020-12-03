{_, contents} = File.read("input.txt")
lines = String.split(contents, "\n", trim: true)

defmodule Solution do
  def nthLines(lines, n) do
    lines
    |> Enum.with_index
    |> Enum.filter(fn({_, i}) -> rem(i,n) == 0 end)
    |> Enum.map(fn({line, _}) -> line end)
    |> Enum.with_index
  end

  def lineRight(lines, lineNumber, rightNumber) do
    lineLength = lines |> Enum.at(0) |> String.length

    lines
    |> Solution.nthLines(lineNumber)
    |> Enum.reduce(0, fn({line, i}, acc) ->
      calcIndex = rem(i * rightNumber, lineLength)

      acc + case String.at(line, calcIndex) do
        "." -> 0
        "#" -> 1
      end
    end)
  end
end

IO.puts "Part 1:"
IO.puts lines |> Solution.lineRight(1, 3)

IO.puts "Part 2:"
IO.puts (lines |> Solution.lineRight(1, 1)) *
 (lines |> Solution.lineRight(1, 3)) *
 (lines |> Solution.lineRight(1, 5)) *
 (lines |> Solution.lineRight(1, 7)) *
 (lines |> Solution.lineRight(2, 1))
