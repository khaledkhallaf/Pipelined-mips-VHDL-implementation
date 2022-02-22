
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;
entity InstructionMemory_tb is
-- Port ( );
end InstructionMemory_tb;

architecture Behavioral of InstructionMemory_tb is
component InstructionMemory is
Port (
        clk: in STD_LOGIC;
        ReadAddress: in STD_LOGIC_VECTOR(31 downto 0);
        Instruction: out STD_LOGIC_VECTOR(18 downto 0)
      );
end component;
--Inputs
signal clk_test: std_logic:='0';
signal ReadAddress_test: std_logic_vector(31 downto 0):="00000000000000000000000000000000";
--Outputs
signal Instruction_test: std_logic_vector(18 downto 0);
begin
uut: InstructionMemory 
PORT MAP(
clk_test,
ReadAddress_test,
Instruction_test
);
clk_process: Process
begin 
clk_test<='1';wait for 10ns;
clk_test<='0';wait for 10ns;
end process;
stim_process: Process
begin
ReadAddress_test<="00000000000000000000000000000000";wait for 10ns;
ReadAddress_test<="00000000000000000000000000000001";wait for 10ns;
ReadAddress_test<="00000000000000000000000000000010";wait for 10ns;
ReadAddress_test<="00000000000000000000000000000011";wait for 10ns;
ReadAddress_test<="00000000000000000000000000000100";
wait;
end process;
end Behavioral;
