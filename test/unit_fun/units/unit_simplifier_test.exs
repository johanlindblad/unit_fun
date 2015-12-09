defmodule UnitFun.Units.UnitSimplifierTests do
  use ExUnit.Case
  alias UnitFun.Units.CompositeUnit
  alias UnitFun.Units.UnitSimplifier

  alias UnitFun.Units.UnitSimplifierTests.Meters
  alias UnitFun.Units.UnitSimplifierTests.Newtons

  test "Complex types wrapping a single unit are removed" do
    complex = CompositeUnit.new_with_numerator(Meters.unit)

    expected = Meters.unit

    assert (UnitSimplifier.simplify_unit(complex)) == expected
  end

  test "Complex types have units cancelled out" do
    complex = CompositeUnit.new_with_numerator(Meters.unit)
      |> CompositeUnit.multiply_unit(Meters.unit)
      |> CompositeUnit.multiply_unit(Newtons.unit)
      |> CompositeUnit.divide_unit(Meters.unit)

    expected = CompositeUnit.new_with_numerator(Meters.unit)
      |> CompositeUnit.multiply_unit(Newtons.unit)

    assert (UnitSimplifier.simplify_unit(complex)) == expected
  end

end

defmodule UnitFun.Units.UnitSimplifierTests.Meters do
  use UnitFun.Unit
end

defmodule UnitFun.Units.UnitSimplifierTests.Newtons do
  use UnitFun.Unit
end