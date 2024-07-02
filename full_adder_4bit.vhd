-- Maheen Shoaib & Jessica Persaud
-- ECE 124
-- Section 201

library ieee;
use ieee.std_logic_1164.all;

-- This code defines a 4-bit full adder by chaining four 1-bit full adders.

ENTITY full_adder_4bit IS
    port (
        bus0, bus1 : in std_logic_vector (3 downto 0);  -- Two 4-bit input buses
        Carry_in   : in std_logic;                     -- Carry input
        sum        : out std_logic_vector (3 downto 0);-- 4-bit sum output
        Carry_out  : out std_logic                     -- Carry output
    );
END full_adder_4bit;

ARCHITECTURE second_adder OF full_adder_4bit IS

    -- Component declaration for the 1-bit full adder
    component full_adder_1bit
        port (
            input_A, input_B, Carry_in : in std_logic;  -- 1-bit inputs and carry input
            full_adder_coutput, full_adder_soutput : out std_logic  -- 1-bit carry and sum outputs
        );
    end component;

    signal carry : std_logic_vector(3 downto 0);  -- Internal carry signals

BEGIN
    -- Chaining the four 1-bit full adders to form a 4-bit full adder
    INST1: full_adder_1bit port map(
        input_B => bus0(0), 
        input_A => bus1(0), 
        Carry_in => Carry_in, 
        full_adder_coutput => carry(1), 
        full_adder_soutput => sum(0)
    );
    
    INST2: full_adder_1bit port map(
        input_B => bus0(1), 
        input_A => bus1(1), 
        Carry_in => carry(1), 
        full_adder_coutput => carry(2), 
        full_adder_soutput => sum(1)
    );
    
    INST3: full_adder_1bit port map(
        input_B => bus0(2), 
        input_A => bus1(2), 
        Carry_in => carry(2), 
        full_adder_coutput => carry(3), 
        full_adder_soutput => sum(2)
    );
    
    INST4: full_adder_1bit port map(
        input_B => bus0(3), 
        input_A => bus1(3), 
        Carry_in => carry(3), 
        full_adder_coutput => Carry_out, 
        full_adder_soutput => sum(3)
    );

END second_adder;