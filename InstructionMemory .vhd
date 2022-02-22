library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity InstructionMemory is
     Port(
        clk: in STD_LOGIC;
        ReadAddress: in STD_LOGIC_VECTOR(31 downto 0);
        Instruction: out STD_LOGIC_VECTOR(18 downto 0)
         );
end InstructionMemory;

architecture Behavioral of InstructionMemory is
type Memory is array (0 to 18) of std_logic_vector(18 downto 0);
signal InstructionMem: Memory :=
(
"0000010010100001010" ,-- ADD R9,R8,R10
--Read After Write
"0100011010110001110" , --AND R13,R12,R14
"0010011000101101101" ,-- SUB R12,R11,R13
"0110010000111101001" , --OR R8,R15,R9
--Write After Read
"0010010100100101111", --SUB R10,R9,R15
"0000011110100001011", --ADD R15,R8,R11 
--Write After Write
"0000011000110101110", --ADD R12,R13,R14
"0010011000101001001", --SUB R12,R10,R9
-- Read After Read
"0000011110100001011", --ADD R15,R8,R11
"0010011110100101100", --SUB R15,R9,R12
"0001011010100000101",-- ADDI R13,R8,5
"0011011000100100011", --SUBI R12,R9,3 ---> ADDI R12,R9,-3
"1001011000110100101",--LW R12,5(R13)
"1011010100101100101",--SW R10,5(R11)
"1101000000000110000", --JR R1,16
"1111000010001000101", --BEQZ R1,R2,5
"0000011110100001011", --ADD R15,R8,R11
"0010011110100101100", --SUB R15,R9,R12
"0001011010100000101"-- ADDI R13,R8,5
);
begin
process(clk)
begin
if(rising_edge(clk)) then
Instruction<=InstructionMem(CONV_INTEGER(ReadAddress));
end if;
end process;
end Behavioral;