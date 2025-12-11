library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity aoc1Mem is 
  generic (
    numInstructions: Positive
  );
  port (
    clk:  in std_logic;
    we:   in std_logic;
    addr: in unsigned(15 downto 0);
    din:  in integer range -1000 to 1000;
    dout: out integer range -1000 to 1000
  );
end entity aoc1Mem;


architecture A1 of aoc1Mem is
  type mem_t is array (0 to numInstructions) of signed(15 downto 0);  
  signal memory: mem_t := (others => (others => '0'));
begin
  process(clk)
  begin
    if rising_edge(clk) then
      if (we = '1') then
        memory(to_integer(addr)) <= to_signed(din, 16);
      else 
        dout <= to_integer(memory(to_integer(addr)));    
      end if;
    end if;    
  end process;
end architecture A1;
