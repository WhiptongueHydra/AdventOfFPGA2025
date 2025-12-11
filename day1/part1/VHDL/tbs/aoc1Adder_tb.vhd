library ieee;
library std;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use std.textio.all;
use ieee.std_logic_textio.all;


entity aoc1Adder_tb is
end entity aoc1Adder_tb;


architecture A1 of aoc1Adder_tb is
  component aoc1Adder is
    port (
      clk:  in std_logic;
      inst: in integer range -1000 to 1000;
      result: out integer range 0 to 99
    );
  end component aoc1Adder;
  
  -- Device signals
  signal clk:     std_logic := '0';
  signal inst:    integer range -1000 to 1000;
  signal result:  integer range 0 to 99;
    
  -- Simulation signals
  signal simDone: std_logic := '0';
  signal T:       time      := 10 ns;
  
begin
  dut: aoc1Adder 
    port map (
      clk  => clk,
      inst => inst,
      result => result
    );

  clkproc: process
  begin
    while simDone = '0' loop
      clk <= not clk;
      wait for T/2;
    end loop;
    report "Simulation finished.";
    wait;
  end process clkproc;
    
  stimproc: process
    file datafile:    text open read_mode is "placeholder.txt";
    variable instr:   line;
    variable number:  integer range -1000 to 1000;
  begin
    while not endfile(datafile) loop
      readline(datafile, instr);
      read(instr, number);
      wait until rising_edge(clk);
      inst <= number;
    end loop;
    simDone <= '1';
    wait;
  end process stimproc;
end architecture A1;

