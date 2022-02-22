----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/30/2021 07:10:32 PM
-- Design Name: 
-- Module Name: DataMemory - Behavioral
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
use IEEE.Numeric_Std.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity DataMemory is
    Port ( Instruction : in STD_lOGIC_VECTOR(2 downto 0);
           Address : in STD_LOGIC_VECTOR (31 downto 0);
           WriteData : in STD_LOGIC_VECTOR (31 downto 0);
           Clock : in std_logic;
           ReadData : out STD_LOGIC_VECTOR (31 downto 0));
end DataMemory;

architecture Behavioral of DataMemory is
          signal MemRead : STD_LOGIC;
          signal MemWrite : STD_LOGIC;

 type RAM_1000_x_32 is array (0 to 999) of std_logic_vector (31 downto 0);
 
 signal DM: RAM_1000_x_32 := (others => x"00000000");  --Assume starts at 0x100010000

begin
 process(clock) 
  begin 
  if (clock'event and clock='1') then
  if(Instruction="100")then
  MemRead<='1';
  MemWrite<='0';
  elsif(Instruction="101")then
  MemRead<='0';
  MemWrite<='1';
  else
  MemRead<='0';
  MemWrite<='0';
  end if;
   if (MemWrite = '1') then
    DM( (to_integer(unsigned(Address))-268500992)/4 ) <= WriteData;  --268500992=0x10010000
   end if;
   if (MemRead = '1') then
    ReadData <= DM( (to_integer(unsigned(Address))-268500992)/4 );
    else
    ReadData <=x"00000000";
   end if;
   end if;
 end process;


end Behavioral;
