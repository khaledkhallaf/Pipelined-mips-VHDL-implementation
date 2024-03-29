----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/03/2022 01:40:19 AM
-- Design Name: 
-- Module Name: Pipelined_tb - Behavioral
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

entity Pipelined_tb is
--  Port ( );
end Pipelined_tb;

architecture Behavioral of Pipelined_tb is
Component Pipelined is
port(Clock: in std_logic );
end Component;
signal Clock: std_logic;

begin
clk_process: Process
begin 
Clock<='0';wait for 10ns;
Clock<='1';wait for 10ns;
end process;
end Behavioral;
