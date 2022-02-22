library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity HazardControl_tb is
--  Port ( );
end HazardControl_tb;

architecture Behavioral of HazardControl_tb is
component HazardControl is
Port(
   InFirstInstruction: in STD_LOGIC_VECTOR (18 downto 0);
    InSecondInstruction: in STD_LOGIC_VECTOR (18 downto 0);
    ALU_Result : in STD_LOGIC_VECTOR(31 downto 0);
    ReadData1: out STD_LOGIC_VECTOR(31 downto 0);
    ReadData2: out STD_LOGIC_VECTOR(31 downto 0);
    stall: out STD_logic
);
end component;
--Inputs
    signal InFirstInstruction_test: STD_LOGIC_VECTOR (18 downto 0) := (Others =>'0');
    signal InSecondInstruction_test: STD_LOGIC_VECTOR (18 downto 0) := (Others =>'0');
    signal ALU_Result_test : STD_LOGIC_VECTOR(31 downto 0) := (Others =>'0');
--Outputs
    signal ReadData1_test: STD_LOGIC_VECTOR(31 downto 0) := (Others =>'0');
    signal ReadData2_test: STD_LOGIC_VECTOR(31 downto 0) := (Others =>'0');
    signal stall_test: STD_logic :='0';
begin
uut: HazardControl
PORT MAP(
InFirstInstruction_test,
InSecondInstruction_test,
ALU_Result_test,
ReadData1_test,
ReadData2_test,
stall_test
);
stim_process: Process
begin
--Read After Write
ALU_result_test<=x"10001000";
InFirstInstruction_test<="0010011000101101101"; --SUB R12,R11,R13
wait for 10ns;
InSecondInstruction_test<="0100011010110001110"; --AND R13,R12,R16
wait for 10ns;
ALU_result_test<=x"10001001";
wait for 10ns;
InFirstInstruction_test<="0010011000101101101"; --SUB R12,R11,R13
InSecondInstruction_test<="0100011010111001100"; --AND R13,R16,R12
wait for 10ns;
InFirstInstruction_test<="1111000010001000101"; --BEQZ R1,R2,5
wait for 10ns;
InSecondInstruction_test<="0100011010110001110"; --AND R13,R12,R16
wait;
end process;
end Behavioral;

