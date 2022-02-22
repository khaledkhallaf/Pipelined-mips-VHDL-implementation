----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/26/2021 10:18:22 AM
-- Design Name: 
-- Module Name: ALU_tb - Behavioral
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

entity ALU_tb is
--  Port ( );
end ALU_tb;
 
architecture Behavioral of ALU_tb is
Component ALU 
Port ( Instruction : in STD_LOGIC_VECTOR(3 downto 0);
           Data1 : in STD_LOGIC_VECTOR(31 downto 0);
           Data2 : in STD_LOGIC_VECTOR(31 downto 0);
           Signextend: in STD_LOGIC_VECTOR(31 downto 0);
           Result : out STD_LOGIC_VECTOR(31 downto 0);
           Zero : out STD_logic:='0');
end Component;  
signal Instruction : STD_LOGIC_VECTOR(3 downto 0);
 signal Data1 : std_logic_vector (31 downto 0) := (Others =>'0');
signal Data2 : std_logic_vector (31 downto 0) :=(Others =>'0');
signal Signextend : std_logic_vector (31 downto 0) :=(Others =>'0');
signal Result : std_logic_vector (31 downto 0) :=(Others =>'0');
signal Zero : std_logic:='0';
begin
uut: ALU port map (Instruction=>Instruction,Data1=>Data1, Data2=>Data2, Signextend=>Signextend, Result=>Result, Zero=>Zero);
stim_proc: process
begin
wait for 200ns;
Instruction(0)<='0';
Data1<=x"CFFABBBB";
Data2<=x"11111111";wait for 200ns;
Instruction(3 downto 1)<= "000"; wait for 100us;
Instruction(3 downto 1)<= "001"; wait for 100us;
Instruction(3 downto 1)<= "010"; wait for 100us;
Instruction(3 downto 1)<= "111"; wait for 100us;
Instruction(3 downto 1)<= "100"; wait;
end process;
end Behavioral;