-- Maheen Shoaib & Jessica Persaud
-- ECE 124
-- Section 201

library ieee;
use ieee.std_logic_1164.all;

-- This code defines a multiplexer that takes in 2 inputs and, depending on the select value, displays an output.

entity LogicProcessor is
port (
    logic_in0   : in std_logic_vector(3 downto 0);  -- First 4-bit logic input
    logic_in1   : in std_logic_vector(3 downto 0);  -- Second 4-bit logic input
    mux_select  : in std_logic_vector(1 downto 0);  -- Multiplexer select signal
    logic_out   : out std_logic_vector(3 downto 0)  -- Multiplexer output
);

end LogicProcessor;

architecture mux_logic of LogicProcessor is

begin

    -- Multiplexing logic based on mux_select value
    with mux_select select
    logic_out <=  (logic_in0 AND logic_in1) when "00",  -- AND operation when select is "00"
                  (logic_in0 OR logic_in1) when "01",   -- OR operation when select is "01"
                  (logic_in0 XOR logic_in1) when "10",  -- XOR operation when select is "10"
                  (logic_in0 XNOR logic_in1) when "11"; -- XNOR operation when select is "11"
                  
end mux_logic;