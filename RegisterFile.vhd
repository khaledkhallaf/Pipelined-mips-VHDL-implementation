library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity RegisterFile is
            Port(
                Clock: in STD_LOGIC;
                Instruction: in STD_LOGIC_VECTOR(2 downto 0);            
                ReadRegister1: in STD_LOGIC_VECTOR (4 downto 0);
                ReadRegister2: in STD_LOGIC_VECTOR (4 downto 0);
                WriteRegister: in STD_LOGIC_VECTOR (4 downto 0);
                WriteData: in STD_LOGIC_VECTOR(31 downto 0);
                ReadData1: out STD_LOGIC_VECTOR(31 downto 0);
                ReadData2: out STD_LOGIC_VECTOR(31 downto 0)
             );
end RegisterFile;

architecture Behavioral of RegisterFile is
type registerfile is array (0 to 31) of std_logic_vector (31 downto 0);
signal List: registerfile:=
(
    "00000000000000000000000000000000", --zero
    "00000000000000000000000000000001", --at
    "00000000000000000000000000000010", --v0
    "00000000000000000000000000000011", --v1
    "00000000000000000000000000000100", --a0
    "00000000000000000000000000000101", --a1
    "00000000000000000000000000000110", --a2
    "00000000000000000000000000000111", --a3
    "00000000000000000000000000001000", --t0
    "00000000000000000000000000001001", --t1
    "00000000000000000000000000001010", --t2
    "00000000000000000000000000001011", --t3
    "00000000000000000000000000001100", --t4
    "00000000000000000000000000001101", --t5
    "00000000000000000000000000001110", --t6
    "00000000000000000000000000001111", --t7
    "00000000000000000000000000010000", --s0
    "00000000000000000000000000010001", --s1
    "00000000000000000000000000010010", --s2
    "00000000000000000000000000010011", --s3
    "00000000000000000000000000010100", --s4
    "00000000000000000000000000010101", --s5
    "00000000000000000000000000010110", --s6
    "00000000000000000000000000010111", --s7
    "00000000000000000000000000011000", --t8
    "00000000000000000000000000011001", --t9
    "00000000000000000000000000011010", --k0
    "00000000000000000000000000011011", --k1
    "00000000000000000000000000011100", --gp
    "00000000000000000000000000011101", --sp
    "00000000000000000000000000011110", --fp
    "00000000000000000000000000011111" --ra
);
signal RegWrite: std_logic :='0';
begin
process(clock)
begin
if(rising_edge(clock)) then
if(Instruction="101" or Instruction="110" or Instruction="111") then
RegWrite <='0';
else
RegWrite <='1';
end if; 
 --At the rising edge 
if(RegWrite='1') then
List(to_integer(unsigned(WriteRegister)))<=WriteData; --Saving the value in the required register
end if;
end if;
ReadData1<=List(to_integer(unsigned(ReadRegister1))); --defining the output for ReadRegister1
if(Instruction="101")then                              --defining the output for ReadRegister2 according to opcode
ReadData2<=List(to_integer(unsigned(WriteRegister)));
else
ReadData2<=List(to_integer(unsigned(ReadRegister2)));
end if;
end process;

end Behavioral;
