----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/30/2021 08:13:31 PM
-- Design Name: 
-- Module Name: DataMemory_tb - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity DataMemory_tb is
end DataMemory_tb;

architecture Behavioral of DataMemory_tb is

component DataMemory is
    Port ( Instruction : in STD_lOGIC_VECTOR(2 downto 0);
           Address : in STD_LOGIC_VECTOR (31 downto 0);
           WriteData : in STD_LOGIC_VECTOR (31 downto 0);
           clock : in std_logic;
           ReadData : out STD_LOGIC_VECTOR (31 downto 0));
end component;

--inputs
signal Address :  STD_LOGIC_VECTOR (31 downto 0) := x"00000000";
signal WriteData : STD_LOGIC_VECTOR (31 downto 0) := x"00000000";
signal clock : std_logic := '0';
signal Instruction : STD_LOGIC_VECTOR (2 downto 0) := "000";

--output
signal ReadData : STD_LOGIC_VECTOR (31 downto 0) := x"00000000";

begin

uut: DataMemory port map (
Instruction=>Instruction,
Address => Address,
WriteData => WriteData,
clock => clock,
ReadData => ReadData
);

clock_process: process
begin 
clock <='0'; wait for 5ns;
clock <='1'; wait for 5ns;
end process;

stim_proc: process
begin

--test two memory locations
--first test
Address <= x"10010000";
WriteData <= x"11112222";
Instruction<="000";
wait for 20 ns;
Instruction<="101"; --write memory
wait for 20 ns;
Instruction<="000";
wait for 20 ns;

--second test
Address <= x"10010004";
WriteData <= x"33334444";
Instruction<="000";
wait for 20 ns;
Instruction<="101"; --write memory
wait for 20 ns;
Instruction<="000";
wait for 20 ns;

--read the two memory locations
--first location
Address <= x"10010000";
Instruction<="000";
wait for 20 ns;
Instruction <= "100"; --read Memory
wait for 20 ns;
Instruction<="000";
wait for 20 ns;

--second location
Address <= x"10010004";
Instruction<="000";
wait for 20 ns;
Instruction <= "100"; --read memory
wait for 20 ns;
Instruction<="000";
wait for 20 ns;
end process;

end Behavioral;
