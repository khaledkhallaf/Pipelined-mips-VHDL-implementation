----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/30/2021 06:51:04 PM
-- Design Name: 
-- Module Name: MUX - Behavioral
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

entity WriteBack is
    Port ( Instruction : in STD_LOGIC_VECTOR(2 downto 0);
           a : in STD_LOGIC_vector (31 downto 0);
           b : in STD_LOGIC_vector (31 downto 0);
           mux_out : out STD_LOGIC_vector (31 downto 0));
end WriteBack;

architecture Behavioral of WriteBack is
signal MemtoReg: std_logic :='0';
begin
process(Instruction)
begin
if(Instruction="100")then
    MemtoReg<='1';
else
   MemtoReg<='0'; 
end if;
end process;   
 process (a,b,MemtoReg)
  begin
   case MemtoReg is
   when '0' => mux_out <= a;
   when '1' => mux_out <= b;
   end case;
 end process;
end Behavioral;
