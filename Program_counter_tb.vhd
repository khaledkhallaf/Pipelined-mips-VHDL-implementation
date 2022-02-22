----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/02/2022 10:03:01 AM
-- Design Name: 
-- Module Name: Program_counter_tb - Behavioral
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

entity Program_counter_tb is
--  Port ( );
end Program_counter_tb;

architecture Behavioral of Program_counter_tb is
Component Program_counter is
    Port ( Zero : in STD_LOGIC;
           ALU_result : in STD_LOGIC_Vector(31 downto 0);
           Program_count : out STD_LOGIC_VECTOR(31 downto 0);
            Clock : in STD_LOGIC;
           stall: in STD_LOGIC);
end Component;
signal Zero : STD_LOGIC:='0';
signal  ALU_result : STD_LOGIC_Vector(31 downto 0):=(Others=>'0');
signal Program_count : STD_LOGIC_VECTOR(31 downto 0);
signal Clock : STD_LOGIC:='0';
signal stall: STD_LOGIC:='0';
begin
uut: Program_counter port map (Zero => Zero,
ALU_result => ALU_result,
Program_count=>Program_count,
Clock => Clock,
stall => stall);
clock_process: process
begin 
clock <='0'; wait for 5ns;
clock <='1'; wait for 5ns;
end process;
stim_process: Process
begin
wait for 100ns;
Zero<='1';
ALU_result<=x"0000000A";
wait for 10ns;
Zero<='0';
wait for 100ns;
Zero<='1';
ALU_result<=x"00000004";
wait for 10ns;
stall<='1'; 
Zero<='0';
wait for 10ns;
stall<='1';
wait;
end process;

end Behavioral;
