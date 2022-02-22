library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity SignExtend is
        Port (
                Input: in STD_LOGIC_VECTOR(4 downto 0);
                Output: out STD_LOGIC_VECTOR(31 downto 0)
              );
end SignExtend;

architecture Behavioral of SignExtend is
begin
process(Input)
begin
if (Input(4)='1') then --Checking if the first bit of the input bits is '1'
Output<="111111111111111111111111111"&Input; --The input is a negative number
else --The input is a positive number
Output<="000000000000000000000000000"&Input;
end if;
end process;
end Behavioral;
