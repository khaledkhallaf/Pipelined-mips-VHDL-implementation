
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;
entity SignExtend_tb is
-- Port ( );
end SignExtend_tb;

architecture Behavioral of SignExtend_tb is
component SignExtend 
Port(
        Input: in STD_LOGIC_VECTOR(4 downto 0);
        Output: out STD_LOGIC_VECTOR(31 downto 0)
);
end component;
-- Inputs
signal Input_test: std_logic_vector(4 downto 0):="00000";
-- Outputs
signal Output_test: std_logic_vector(31 downto 0);
begin
uut: SignExtend 
PORT MAP(
Input_test,
Output_test
);
stim_proc: Process
begin
Input_test<="00000";wait for 10ns;
Input_test<="10000";wait;
wait; 
end process;
end Behavioral;