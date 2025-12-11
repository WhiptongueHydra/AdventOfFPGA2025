library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity aoc1ZCounter IS
  generic(
    numInstructions: Positive
  );
  port (
    clk: in std_logic;
    inSum: in integer range 0 to 99;
    passwd: out integer range 0 to numInstructions -- Could be the case every single one lands on 0
  );
end entity aoc1ZCounter;


architecture A1 of aoc1ZCounter is
  signal cnt: integer := 0;
begin
  passwd <= cnt;
  
  process(clk) begin -- was process(inSum)
    if rising_edge(clk) then
      if (inSum = 0) then
        cnt <= cnt + 1;
      end if;
    end if;
  end process;
end architecture A1;

