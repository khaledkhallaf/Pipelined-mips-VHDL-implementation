library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_signed.all;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity HazardControl is
  Port ( 
    InFirstInstruction: in STD_LOGIC_VECTOR (18 downto 0);
    InSecondInstruction: in STD_LOGIC_VECTOR (18 downto 0);
    ALU_Result : in STD_LOGIC_VECTOR(31 downto 0);
    ReadData1: out STD_LOGIC_VECTOR(31 downto 0);
    ReadData2: out STD_LOGIC_VECTOR(31 downto 0);
    stall: out STD_logic);
end HazardControl;

architecture Behavioral of HazardControl is
begin
Process(InFirstInstruction,InSecondInstruction,ALU_result)
begin
if((InSecondInstruction(4 downto 0)=InFirstInstruction(14 downto 10))and InSecondInstruction(15)='0') then --Checking if there is a Read After Write hazard 
                   ReadData1<=ALU_Result; --forwarding
elsif(InSecondInstruction(9 downto 5)=InFirstInstruction(14 downto 10))then
                   ReadData2<=ALU_Result; --forwarding   
end if;
     if(InFirstInstruction(18 downto 16)="110")then --detecting control hazards
         stall<='1'; --stalling
     else
        stall<='0';    --continuing
       
       end if;
end process;
end Behavioral;
