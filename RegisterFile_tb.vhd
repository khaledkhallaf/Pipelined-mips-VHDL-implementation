library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;
entity RegisterFile_tb is
--Port ( );
end RegisterFile_tb;

architecture Behavioral of RegisterFile_tb is
component RegisterFile is
Port (
         Clock: in STD_LOGIC;
                Instruction: in STD_LOGIC_VECTOR(2 downto 0);            
                ReadRegister1: in STD_LOGIC_VECTOR (4 downto 0);
                ReadRegister2: in STD_LOGIC_VECTOR (4 downto 0);
                WriteRegister: in STD_LOGIC_VECTOR (4 downto 0);
                WriteData: in STD_LOGIC_VECTOR(31 downto 0);
                ReadData1: out STD_LOGIC_VECTOR(31 downto 0);
                ReadData2: out STD_LOGIC_VECTOR(31 downto 0)
         );
end component;
--Inputs
signal clk_test: std_logic := '0';
signal Instruction_test: STD_LOGIC_VECTOR(2 downto 0);
signal ReadRegister1_test: std_logic_vector(4 downto 0):="00000";
signal ReadRegister2_test: std_logic_vector(4 downto 0):="00000";
signal WriteRegister_test: std_logic_vector(4 downto 0):="00000";
signal WriteData_test: std_logic_vector(31 downto 0):= "00000000000000000000000000000000";
--Output
signal ReadData1_test: std_logic_vector(31 downto 0);
signal ReadData2_test: std_logic_vector(31 downto 0);
begin
uut: RegisterFile 
PORT MAP(
clk_test,
Instruction_test,
ReadRegister1_test,
ReadRegister2_test,
WriteRegister_test,
WriteData_test,
ReadData1_test,
ReadData2_test
);
clk_process: Process
begin 
clk_test<='0';wait for 5ns;
clk_test<='1';wait for 5ns;
end process;
stim_proc: Process
begin
ReadRegister1_test<="00000"; ReadRegister2_test<="00000"; WriteRegister_test<="00000"; 
WriteData_test<="00000000000000000000000000000000"; Instruction_test<="111";wait for 10ns;
ReadRegister1_test<="00001"; ReadRegister2_test<="00001"; WriteRegister_test<="00001"; 
WriteData_test<="00000000000000000000000000000011"; Instruction_test<="111";wait for 10ns;
ReadRegister1_test<="00010"; ReadRegister2_test<="00001"; WriteRegister_test<="00010"; 
WriteData_test<="00000000000000000000000000000110"; Instruction_test<="000";wait for 10ns;
ReadRegister1_test<="00010";wait;
wait;
end process;
end Behavioral;
