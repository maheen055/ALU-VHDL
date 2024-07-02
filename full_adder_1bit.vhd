-- Maheen Shoaib & Jessica Persaud
-- ECE 124
-- Section 201

library ieee;
use ieee.std_logic_1164.all;

-- This code defines a 1-bit full adder, which is a basic building block for creating multi-bit adders.

ENTITY full_adder_1bit IS
port (
    input_A, input_B, Carry_in          : in std_logic;  -- 1-bit inputs and carry input
    full_adder_coutput, full_adder_soutput : out std_logic  -- 1-bit carry and sum outputs
);
END full_adder_1bit;

ARCHITECTURE adder OF full_adder_1bit IS

BEGIN
    -- Sum output calculation: sum is A XOR B XOR Carry_in
    full_adder_soutput <= ((input_A xor input_B) xor Carry_in);

    -- Carry output calculation: carry is (A AND B) OR ((A XOR B) AND Carry_in)
    full_adder_coutput <= ((input_A and input_B) or ((input_A xor input_B) and Carry_in));

END adder;