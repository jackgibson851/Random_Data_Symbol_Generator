-------------------------------------------------------------------------------
-- Module     : t_datagen
-------------------------------------------------------------------------------
-- Author     : Matthias Kamuf
-- Company    : University of Applied Sciences Augsburg
-------------------------------------------------------------------------------
-- Description: Testbench for module datagen
--              
-------------------------------------------------------------------------------
-- Revisions  : see end of file
------------------------------------------------------------------------------- 
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;
USE STD.textio.ALL;

ENTITY t_datagen IS

END t_datagen;

ARCHITECTURE tbench OF t_datagen IS

  COMPONENT datagen IS
    GENERIC (
      INIT : integer);
    PORT (
      clk_i     : IN  std_ulogic;
      rst_ni    : IN  std_ulogic;
      sel_pn_i  : IN  std_ulogic;
      restart_o : OUT std_ulogic;
      valid_o   : OUT std_ulogic;
      symbol_o  : OUT std_ulogic_vector(7 DOWNTO 0));
  END COMPONENT datagen;

  -- component ports
  SIGNAL clk    : std_ulogic;
  SIGNAL rst_n  : std_ulogic;
  SIGNAL valid  : std_ulogic;
  SIGNAL symbol : std_ulogic_vector(7 DOWNTO 0);

  -- definition of a clock period
  CONSTANT period : time    := 20 ns;
  -- switch for clock generator
  SIGNAL clken_p  : boolean := true;

BEGIN

  -- component instantiation
  DUT : datagen
    GENERIC MAP (
      INIT => 48) -- OBS! some initial value is required here
    PORT MAP (
      clk_i     => clk,
      rst_ni    => rst_n,
      sel_pn_i  => '0',
      restart_o => OPEN,
      valid_o   => valid,
      symbol_o  => symbol);

  -- clock generation
  clock_proc : PROCESS
  BEGIN
    WHILE clken_p LOOP
      clk <= '0'; WAIT FOR period/2;
      clk <= '1'; WAIT FOR period/2;
    END LOOP;
    WAIT;
  END PROCESS;

  reset : rst_n <= '0', '1' AFTER period;

  observer : PROCESS
    VARIABLE Lo     : line;             -- pointer to file output buffer
    VARIABLE Vo     : integer;
    FILE resultfile : text OPEN write_mode IS "log/datagen_result.dat";

  BEGIN

    WAIT UNTIL rst_n = '1';             -- wait for reset

    FOR k IN 0 TO 4*10**3-1 LOOP
      WAIT UNTIL clk = '1';
      IF valid = '1' THEN
        Vo := to_integer(signed(symbol));
        write(Lo, Vo);
        writeline(resultfile, Lo);
      END IF;
    END LOOP;

    clken_p <= false;                   -- switch off clock generator

    WAIT;
  END PROCESS;
END tbench;

-------------------------------------------------------------------------------
-- Revisions:
-- ----------
-- $Id:$
-------------------------------------------------------------------------------
