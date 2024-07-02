-- Maheen Shoaib & Jessica Persaud
-- ECE 124
-- Section 201

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- Entity Declaration
entity LogicalStep_Lab2_top is 
   port (
       clkin_50   : in std_logic;                    
       pb_n       : in std_logic_vector(3 downto 0); -- 4 push-button inputs, active low
       sw         : in std_logic_vector(7 downto 0); -- 8 switch inputs
       leds       : out std_logic_vector(7 downto 0); -- 8 LEDs for displaying outputs
       seg7_data  : out std_logic_vector(6 downto 0); -- 7-bit output for 7-segment display data
       seg7_char1 : out std_logic;                   -- 7-segment display digit 1 selector
       seg7_char2 : out std_logic                    -- 7-segment display digit 2 selector
   ); 
end LogicalStep_Lab2_top;

architecture SimpleCircuit of LogicalStep_Lab2_top is

  -- Component Declarations
  component SevenSegment 
    port (
        hex       : in  std_logic_vector(3 downto 0);   -- 4-bit data to be displayed
        sevenseg  : out std_logic_vector(6 downto 0)    -- 7-bit output for 7-segment display
    ); 
  end component; 

  component segment7_mux 
    port (
        clk       : in std_logic := '0';                
        DIN2      : in std_logic_vector(6 downto 0);    -- Data input for digit 2
        DIN1      : in std_logic_vector(6 downto 0);    -- Data input for digit 1
        DOUT      : out std_logic_vector(6 downto 0);   -- Multiplexed output
        DIG2      : out std_logic;                      -- Digit 2 selector
        DIG1      : out std_logic                       -- Digit 1 selector
    ); 
  end component; 

  component LogicProcessor 
    port (
        logic_in0   : in std_logic_vector(3 downto 0);  -- Logic input 0
        logic_in1   : in std_logic_vector(3 downto 0);  -- Logic input 1
        mux_select  : in std_logic_vector(1 downto 0);  -- Multiplexer select input
        logic_out   : out std_logic_vector(3 downto 0)  -- Logic output
    );
  end component; 

  component PB_Inverters 
    port (
        pb_n : in std_logic_vector(3 downto 0);         -- Active low push-button inputs
        pb   : out std_logic_vector(3 downto 0)         -- Active high push-button outputs
    );
  end component; 

  component full_adder_4bit 
    port (
        bus0      : in std_logic_vector (3 downto 0);   -- First 4-bit input for addition
        bus1      : in std_logic_vector (3 downto 0);   -- Second 4-bit input for addition
        Carry_in  : in std_logic;                       -- Carry-in bit for addition
        sum       : out std_logic_vector (3 downto 0);  -- 4-bit sum output
        Carry_out : out std_logic                       -- Carry-out bit
    );
  end component;

  component mux_design 
    port (
        hex_num    : in std_logic_vector (3 downto 0);  -- 4-bit input from hex switch
        adder_num  : in std_logic_vector (3 downto 0);  -- 4-bit input from adder output
        mux_select : in std_logic;                      -- Multiplexer select input
        mux_out    : out std_logic_vector (3 downto 0)  -- Multiplexed output
    );
  end component; 

  -- Signal Declarations
  signal seg7_A   : std_logic_vector(6 downto 0);  -- 7-segment data for digit 1
  signal seg7_B   : std_logic_vector(6 downto 0);  -- 7-segment data for digit 2
  signal hex_A    : std_logic_vector(3 downto 0);  -- Lower 4 bits of switch inputs
  signal hex_B    : std_logic_vector(3 downto 0);  -- Upper 4 bits of switch inputs
  signal pb_signal: std_logic_vector(3 downto 0);  -- Processed push-button signals
  signal carry_out: std_logic;                     -- Carry-out from full adder
  signal hex_sum  : std_logic_vector(3 downto 0);  -- Sum output from full adder
  signal new_c    : std_logic_vector(3 downto 0);  -- Carry-out signal adjusted for mux
  signal digit1   : std_logic_vector(3 downto 0);  -- Multiplexed output for 7-segment digit 1
  signal digit2   : std_logic_vector(3 downto 0);  -- Multiplexed output for 7-segment digit 2

begin

  -- Assign switch inputs to hex_A and hex_B
  hex_A <= sw(3 downto 0);
  hex_B <= sw(7 downto 4);
  
  -- Adjust carry-out for mux input
  new_c <= "000" & carry_out;
  
  -- Component Instantiation and Signal Mapping
  INST1 : SevenSegment port map(hex => digit1, sevenseg => seg7_A); 
  INST2 : SevenSegment port map(hex => digit2, sevenseg => seg7_B); 
  INST3 : segment7_mux port map(clk => clkin_50, DIN2 => seg7_A, DIN1 => seg7_B, DOUT => seg7_data, DIG2 => seg7_char2, DIG1 => seg7_char1);
  INST4 : PB_Inverters port map(pb_n => pb_n, pb => pb_signal);
  INST5 : LogicProcessor port map(logic_in0 => hex_A, logic_in1 => hex_B, mux_select => pb_signal(1 downto 0), logic_out => leds(3 downto 0));
  INST6 : full_adder_4bit port map(bus0 => hex_B, bus1 => hex_A, Carry_in => '0', Carry_out => carry_out, sum => hex_sum);
  INST7 : mux_design port map(hex_num => hex_B, adder_num => new_c, mux_select => pb_signal(2), mux_out => digit2);
  INST8 : mux_design port map(hex_num => hex_A, adder_num => hex_sum, mux_select => pb_signal(2), mux_out => digit1);

end SimpleCircuit;