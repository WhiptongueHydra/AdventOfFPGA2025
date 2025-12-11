library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
library std;
use std.textio.all;
use ieee.std_logic_textio.all;

entity aoc1TB is
end entity aoc1TB;


architecture sim of aoc1TB is
  component aoc1Mem is
    generic (
      numInstructions: Positive
    );
    port (
      clk:  in std_logic;
      we:   in std_logic;
      addr: in unsigned(15 downto 0);
      din:  in integer;
      dout: out integer range -1000 to 1000
    );
  end component aoc1Mem;
  
  component aoc1ZCounter IS
    generic (
      numInstructions: Positive
    );
    port (
      clk: in std_logic;
      inSum: in integer;
      passwd: out integer
    );
  end component aoc1ZCounter;

  component aoc1Adder is
    port (
      clk:  in std_logic;
      inst: in integer range -1000 to 1000;
      result: out integer range 0 to 99
    );
  end component aoc1Adder;
  
  -- Stim signals
  signal T:     time      := 10 ns;
  signal clk:   std_logic := '0';
  signal we:    std_logic := '0';
  signal addr:  unsigned(15 downto 0) := (others => '0');
  signal din:   integer range -1000 to 1000 := 0;
  signal dout:  integer range -1000 to 1000 := 0;
  
  -- Component signals
  signal mem2Adder:     integer range -1000 to 1000 := 50;
  signal adder2Counter: integer range 0 to 99       := 50;
  signal passwd:        integer := 0;
  
  -- Simulation signals
  signal simDone:   std_logic := '0';
  signal loadDone:  std_logic := '0';
  
  -- Set value here
  constant numInstructions: integer := 4780;
  
begin
  -- Instantiate memory, adder, and zero counter
  mem: aoc1Mem 
    generic map (
      numInstructions => numInstructions
    )
    port map (
      clk => clk,
      we => we,
      addr => addr,
      din => din,
      dout => mem2Adder
    );  
    
  adder: aoc1Adder
    port map (
      clk => clk,
      inst => mem2Adder,
      result => adder2Counter
    );
    
  counter: aoc1ZCounter
    generic map (
      numInstructions => numInstructions
    )
    port map (
      clk => clk,
      inSum => adder2Counter,
      passwd => passwd
    );
  
  
  clk_proc: process begin
    while simDone = '0' loop
      clk <= not clk;
      wait for T/2;
    end loop;
    report "Password: " & integer'image(passwd-1); -- Started at 1 for some reason
    wait;
  end process clk_proc; 
  
  
  -- Swap with relative path 
  memLoad: process 
    file inst_file: text open read_mode is "placeholder.txt";
    variable inst_line: line;
    variable num:       integer range -1000 to 1000;
    variable addrVar:   unsigned(15 downto 0);
  begin
    report "Loading memory";
    we <= '1';
    addr <= (others => '0');
    addrVar := (others => '0');
    while not endfile(inst_file) loop
      readline(inst_file, inst_line);
      read(inst_line, num);
      
      -- This works. Waits til a falling edge, sets num to first number in memory
      -- and address to 0. Sets off a delta cycle by waiting for rising edge
      -- so address is locked in, then increments address variable.
      wait until falling_edge(clk);
      din  <= num;
      addr <= addrVar;
      wait until rising_edge(clk);
      addrVar := addrVar + 1;
    end loop;
    -- Two processes acting on same signal cause multiple driver problems
    -- even if not simultaneously driving. Have to deselect by driving Z 
    we <= 'Z';
    addr <= (others => 'Z');
    loadDone <= '1';
    wait;
  end process memLoad;
  
  
  memDump: process
    variable num: integer := 0;
  begin
    -- Deselect for load process
    we <= 'Z';
    addr <= (others => 'Z');
    report "Dumping memory into adder";
    wait until loadDone = '1';
      we <= '0';
      for i in 0 to numInstructions loop
        wait until falling_edge(clk);
        addr <= to_unsigned(i, 16);
        wait until rising_edge(clk);
      end loop;    
      report "Done dumping memory";
      simDone <= '1';
      wait;
  end process memDump;
end architecture sim;

