-- Maheen Shoaib & Jessica Persaud
-- ECE 124
-- Section 201

library ieee;
use ieee.std_logic_1164.all;

-- This code defines a multiplexer that selects between two 4-bit inputs based on a single select signal.

ENTITY mux_design IS
port (
    hex_num     : in std_logic_vector(3 downto 0);  -- First 4-bit input
    adder_num   : in std_logic_vector(3 downto 0);  -- Second 4-bit input
    mux_select  : in std_logic;                     -- Multiplexer select signal
    mux_out     : out std_logic_vector(3 downto 0)  -- Multiplexer output
);
END mux_design;

ARCHITECTURE mux_logic OF mux_design IS

BEGIN
    -- Multiplexing logic based on mux_select value
    with mux_select select
        mux_out <= hex_num when '0',    -- Select hex_num when select is '0'
                   adder_num when '1';  -- Select adder_num when select is '1'
END mux_logic;