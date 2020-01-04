require Integer
defmodule Euler do
  def muliple_of_3? n do
    rem(n, 3) == 0
  end

  def muliple_of_5? n do
    rem(n, 5) == 0
  end

  def is_prime? n do
    2..(div(n, 2))
    |> Enum.any?(&(rem(n, &1) == 0))
    |> Kernel.not
  end

  def sum_of_3s_and_5s max do
    sum_filter(&(muliple_of_3?(&1) || muliple_of_5?(&1)), max)
  end

  def fibonacci max do
    Stream.unfold({1, 2}, fn {a, b} ->
      {a, {b, a + b}}
    end)
    |> Stream.take_while(&(&1 <= max))
  end

  def fibonacci_even_sum max do
    fibonacci(max)
    |> sum_filter(&(rem(&1, 2) == 0))
  end

  def sum_filter(enumerable, filter_fn) do
    enumerable
    |> Stream.filter(filter_fn)
    |> Enum.sum()
  end


  def get_factors n do
    (trunc(:math.sqrt(n)))..2
    |> Stream.filter(&(rem(n, &1)) == 0)
  end

  def largest_prime_factor n do
    get_factors(n)
    |> Enum.find(&Euler.is_prime?/1)
  end

  def is_palindrome_number? n do
    forward_digits = Integer.digits n
    backward_digits = Enum.reverse forward_digits
    forward_digits == backward_digits
  end

  def find_3_digit_palindrome_product do
    products = Stream.flat_map 999..100, fn i ->
      Stream.flat_map 999..100, fn j ->
        [i * j]
      end
    end
    products
    |> Stream.filter(&Euler.is_palindrome_number?/1)
    |> Enum.max
  end

  def divisible_by_range? n, min, max do
    Enum.all?(min..max, fn x -> rem(n, x) == 0 end)
  end

  def find_smallest_divisible_by_range min, max do
    Stream.unfold(40, fn n -> {n, n + 20} end)
    |> Enum.find(&(divisible_by_range?(&1, min, max)))
  end
end