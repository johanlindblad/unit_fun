defmodule UnitFunMulitplicationTest do
  use ExUnit.Case
  alias UnitFun.Value

  alias UnitFunMulitplicationTest.Meters
  alias UnitFunMulitplicationTest.Newtons
  alias UnitFunMulitplicationTest.Miles

  alias UnitFun.Units.CompositeUnit

  import UnitFun, only: [{:multiply, 2}]

  test "multiplication of matching units works" do
    value_one = %Value{value: 2, units: Meters.unit}
    value_two = %Value{value: 5, units: Meters.unit}

    meters_squared = Meters.unit
      |> CompositeUnit.multiply_unit(Meters.unit)

    expected = %Value{value: 10, units: meters_squared}
    assert value_one |> multiply(value_two) == expected
  end

  test "multiplication of different (unconvertable) units works" do
    value_one = %Value{value: 2, units: Meters.unit}
    value_two = %Value{value: 4, units: Newtons.unit}

    newton_meters = Meters.unit
      |> CompositeUnit.multiply_unit(Newtons.unit)

    expected = %Value{value: 8, units: newton_meters}
    assert value_one |> multiply(value_two) == expected
  end

end

defmodule UnitFunMulitplicationTest.Meters do
  use UnitFun.Unit
end

defmodule UnitFunMulitplicationTest.Newtons do
  use UnitFun.Unit
end

defmodule UnitFunMulitplicationTest.Miles do
  use UnitFun.Unit
end