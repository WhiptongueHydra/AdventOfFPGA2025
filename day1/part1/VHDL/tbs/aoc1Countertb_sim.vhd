library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;


entity aoc1CounterTB is
end entity aoc1CounterTB;


architecture sim of aoc1CounterTB is
    component aoc1ZCounter IS
      port (
        clk: in std_logic;
        inSum: in integer;
        passwd: out integer
      );
    end component aoc1ZCounter;
    
    -- Simulation signals
    signal simDone: std_logic := '0';
 
    -- Stim signals
    constant T: time := 10ns;
    signal clk: std_logic := '0';
    signal inSum: integer range 0 to 99;
    signal passwd: integer;
        
begin
  dut: aoc1ZCounter
    port map (
      clk => clk,
      inSum => inSum,
      passwd => passwd
    );

  clkproc: process begin
    while simDone = '0' loop
      clk <= not clk;
      wait for T/2;
    end loop;
    report "Simulation finished.";
    wait;
  end process clkproc;

-- Generating some 0 data efficiently 
  stimproc: process begin
    for i in 0 to 50 loop
      wait until rising_edge(clk);
      if (i mod 2) = 1 then
        inSum <= 0;
      else
        inSum <= i;
      end if;
    end loop;
    simDone <= '1';
    wait;
  end process stimproc;    
end architecture sim;

