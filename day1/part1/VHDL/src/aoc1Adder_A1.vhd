library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.numeric_std.all;

entity aoc1Adder is
  port (
    clk:  in std_logic;
    inst: in integer range -1000 to 1000;
    result: out integer range 0 to 99
  );
end entity aoc1Adder;


architecture A1 of aoc1Adder is
  signal accumulator: integer range -99 to 99 := 50;
begin
  adder_proc: process(clk)
    variable tempIn:      integer range -99 to 99 := 0;
  begin
    if rising_edge(clk) then
      tempIn := inst rem 100;
      accumulator <= (accumulator + tempIn) mod 100;
      result <= accumulator;
    end if;
  end process adder_proc;
end architecture A1;
