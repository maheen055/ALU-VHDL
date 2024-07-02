-- Maheen Shoaib & Jessica Persaud
-- ECE 124
-- Section 201

library ieee;
use ieee.std_logic_1164.all;

-- This code defines an inverter for push-button signals, converting active-low inputs to active-high outputs.

ENTITY PB_Inverters IS
PORT (
    pb_n : IN std_logic_vector(3 downto 0);  -- Active-low push-button inputs
    pb   : OUT std_logic_vector(3 downto 0)  -- Active-high push-button outputs
);
END PB_Inverters;

ARCHITECTURE gates OF PB_Inverters IS

BEGIN
    -- Invert the active-low push-button signals to active-high
    pb <= not(pb_n);

END gates;