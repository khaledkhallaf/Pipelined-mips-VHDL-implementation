----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/24/2021 06:19:52 PM
-- Design Name: 
-- Module Name: ALU - Behavioral
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
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use ieee.std_logic_signed.all;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ALU is
    Port ( Instruction : in STD_LOGIC_VECTOR(3 downto 0);
            HazadDetect1: in STD_LOGIC;
            HazardDetect2: in STD_LOGIC;
           Data1 : in STD_LOGIC_VECTOR(31 downto 0);
           Data2 : in STD_LOGIC_VECTOR(31 downto 0);
           Signextend: in STD_LOGIC_VECTOR(31 downto 0);
           Result : out STD_LOGIC_VECTOR(31 downto 0);
           Zero : out STD_logic:='0');
end ALU;

architecture Behavioral of ALU is
signal b : std_logic_VECTOR(31 downto 0);
begin
Process(Instruction(0),Data2,Signextend)
begin
if(Instruction(0)='1') then
b <=Signextend;
else
b<=Data1;
end if;
end process;
Process(Data1, b, Instruction(3 downto 1))
begin
case Instruction(3 downto 1) is
  when "000" =>   Result <=Data2 + b;
  when "001" =>   Result <= Data2 - b;
  when "010" =>  Result <= Data2 and b;
  when "011" => Result <= Data2 or b; 
  when "100" => Result<= Data2+b;
  when "101" => Result <= Data2+b;
  when "110" => Result <= Data2+b;
  when "111" => 
  if (Data1 = (Data1'range => '0')) then
        Zero<='1';
  else
        Zero<='0';      
  end if;
  when others => Result <= x"00000000";
end case;  
end process;
end Behavioral;
