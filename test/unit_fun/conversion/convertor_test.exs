defmodule UnitFun.ConvertorTest do
  use ExUnit.Case
  alias UnitFun.Value
  alias UnitFun.Errors.MissingConversionError
  alias UnitFun.Conversion.ConversionHelper

  alias UnitFun.ConvertorTest.Kilometers
  alias UnitFun.ConvertorTest.Miles
  alias UnitFun.ConvertorTest.Furlongs

  test "Protocol is used to convert mismatched units" do
    value_one = %Value{value: 1, units: Kilometers.unit}
    value_two = %Value{value: 1, units: Miles.unit}

    expected_sum = %Value{value: 2.6, units: Kilometers.unit}
    assert value_one |> UnitFun.add(value_two) == expected_sum
  end

  test "Fails if no protocol is implemented" do
    value_one = %Value{value: 1, units: Miles.unit}
    value_two = %Value{value: 1, units: Furlongs.unit}

    message = "No conversions into Elixir.UnitFun.ConvertorTest.Miles implemented"
    assert_raise MissingConversionError, message, fn ->
      value_one |> UnitFun.add(value_two)
    end
  end

  test "Fails if no valid conversion is implemented by protocol" do
    value_one = %Value{value: 1, units: Kilometers.unit}
    value_two = %Value{value: 1, units: Furlongs.unit}

    message = "Can't convert Elixir.UnitFun.ConvertorTest.Furlongs into Elixir.UnitFun.ConvertorTest.Kilometers"
    assert_raise MissingConversionError, message, fn ->
      value_one |> UnitFun.add(value_two)
    end
  end

  test "Protocol is used when directly invoked by helper" do
    value_one = %Value{value: 1, units: Miles.unit}

    expected_value = %Value{value: 1.6, units: Kilometers.unit}
    assert value_one |> ConversionHelper.convert_to(Kilometers.unit) == expected_value
  end

end
