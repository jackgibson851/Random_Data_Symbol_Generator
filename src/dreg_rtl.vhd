-------------------------------------------------------------------------------
-- Module     : dreg
-------------------------------------------------------------------------------
-- Author     : Matthias Kamuf
-- Company    : University of Applied Sciences Augsburg
-------------------------------------------------------------------------------
-- Description: D-type register of generic width
--              including a low-active asynchronous reset input rst_ni
-------------------------------------------------------------------------------
-- Revisions  : see end of file
-------------------------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;

ENTITY dreg IS
  GENERIC (
    WIDTH : natural);
  PORT (
    clk_i  : IN  std_ulogic;
    rst_ni : IN  std_ulogic;
    d_i    : IN  std_ulogic_vector(WIDTH-1 DOWNTO 0);
    q_o    : OUT std_ulogic_vector(WIDTH-1 DOWNTO 0));
END dreg;

ARCHITECTURE rtl OF dreg IS

BEGIN

  q_o <= (OTHERS => '0') WHEN rst_ni = '0' ELSE d_i WHEN rising_edge(clk_i);

END rtl;

-------------------------------------------------------------------------------
-- Revisions:
-- ----------
-- $Id:$
-------------------------------------------------------------------------------

