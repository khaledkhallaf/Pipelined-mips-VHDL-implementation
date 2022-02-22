----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/02/2022 08:48:54 AM
-- Design Name: 
-- Module Name: Program_counter - Behavioral
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
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.std_logic_signed.all;
-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Program_counter is
    Port ( Zero : in STD_LOGIC;
           ALU_result : in STD_LOGIC_Vector(31 downto 0);
           Program_count : out STD_LOGIC_VECTOR(31 downto 0);
           Clock : in STD_LOGIC;
           stall: in STD_LOGIC);
end Program_counter;

architecture Behavioral of Program_counter is
     signal current_program_count: std_logic_vector(31 downto 0):=(Others=>'0');      
            
begin
     Process(Clock)
           begin
           if(rising_edge(CLock))then
                if(Zero='1')then
                    current_program_count<=ALU_result;
                    Program_count<=current_program_count;
                    current_program_count<=current_program_count+1;
                elsif(stall='0')then
                    current_program_count<=current_program_count+1;
                    Program_count<=current_program_count; 
                    If(current_program_count=x"00000013")then
                        current_program_count<=x"00000000";
                    end if;    
                end if;   
           end if;     
          end process;
end Behavioral;
