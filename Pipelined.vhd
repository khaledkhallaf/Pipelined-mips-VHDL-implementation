----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/02/2022 05:54:11 PM
-- Design Name: 
-- Module Name: Pipelined - Behavioral
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
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.NUMERIC_STD.ALL;
use ieee.std_logic_signed.all;
-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Pipelined is
    Port ( Clock : in STD_LOGIC);
end Pipelined;

architecture Behavioral of Pipelined is
signal count: STD_LOGIC_VECTOR(7 downto 0):=(Others=>'0');
signal Zero : STD_LOGIC:='0';
signal  ALU_result : STD_LOGIC_Vector(31 downto 0):=(Others=>'0');
signal Program_count : STD_LOGIC_VECTOR(31 downto 0):=(Others=>'0');
signal stall: STD_LOGIC:='0';
signal signextended: STD_LOGIC_VECTOR(31 downto 0);
type pipeline is array (0 to 4) of std_logic_vector(18 downto 0);
signal InstructionMem: pipeline :=
(
"0000000000000000000" ,
"0000000000000000000" , 
"0000000000000000000" ,
"0000000000000000000" , 
"0000000000000000000" 
);
signal single_instruction : Std_logic_vector(18 downto 0):=(Others=>'0');
signal writeData: Std_logic_vector(31 downto 0):=(Others=>'0'); 
signal ReadData1: STD_LOGIC_VECTOR(31 downto 0);
signal ReadData2: STD_LOGIC_VECTOR(31 downto 0);
signal MemoryReadData: STD_LOGIC_VECTOR(31 downto 0);
Component Program_counter is
    Port ( Zero : in STD_LOGIC;
           ALU_result : in STD_LOGIC_Vector(31 downto 0);
           Program_count : out STD_LOGIC_VECTOR(31 downto 0);
            Clock : in STD_LOGIC;
           stall: in STD_LOGIC);
end Component;
component InstructionMemory is
Port (
        clk: in STD_LOGIC;
        ReadAddress: in STD_LOGIC_VECTOR(31 downto 0);
        Instruction: out STD_LOGIC_VECTOR(18 downto 0)
      );
end component;
component RegisterFile is
Port (
         Clock: in STD_LOGIC;
                Instruction: in STD_LOGIC_VECTOR(2 downto 0);            
                ReadRegister1: in STD_LOGIC_VECTOR (4 downto 0);
                ReadRegister2: in STD_LOGIC_VECTOR (4 downto 0);
                WriteRegister: in STD_LOGIC_VECTOR (4 downto 0);
                WriteData: in STD_LOGIC_VECTOR(31 downto 0);
                ReadData1: out STD_LOGIC_VECTOR(31 downto 0);
                ReadData2: out STD_LOGIC_VECTOR(31 downto 0)
         );
       
end component;
component SignExtend 
Port(
        Input: in STD_LOGIC_VECTOR(4 downto 0);
        Output: out STD_LOGIC_VECTOR(31 downto 0)
);
end component;
Component ALU 
Port ( Instruction : in STD_LOGIC_VECTOR(3 downto 0);
           Data1 : in STD_LOGIC_VECTOR(31 downto 0);
           Data2 : in STD_LOGIC_VECTOR(31 downto 0);
           Signextend: in STD_LOGIC_VECTOR(31 downto 0);
           Result : out STD_LOGIC_VECTOR(31 downto 0);
           Zero : out STD_logic:='0');
end Component;  
component DataMemory is
    Port ( Instruction : in STD_lOGIC_VECTOR(2 downto 0);
           Address : in STD_LOGIC_VECTOR (31 downto 0);
           WriteData : in STD_LOGIC_VECTOR (31 downto 0);
           clock : in std_logic;
           ReadData : out STD_LOGIC_VECTOR (31 downto 0));
end component;
Component WriteBack is
    Port ( Instruction : in STD_LOGIC_VECTOR(2 downto 0);
           a : in STD_LOGIC_vector (31 downto 0);
           b : in STD_LOGIC_vector (31 downto 0);
           mux_out : out STD_LOGIC_vector (31 downto 0));
end Component;
Component HazardControl is
  Port ( 
    InFirstInstruction: in STD_LOGIC_VECTOR (18 downto 0);
    InSecondInstruction: in STD_LOGIC_VECTOR (18 downto 0);
    ALU_Result : in STD_LOGIC_VECTOR(31 downto 0);
    ReadData1: out STD_LOGIC_VECTOR(31 downto 0);
    ReadData2: out STD_LOGIC_VECTOR(31 downto 0);
    stall: out STD_logic);
end Component;

begin 
PC1: Program_counter port map(Zero=>Zero,ALU_result=>ALU_result,Program_count=>Program_count,Clock=>Clock,stall=>stall);
InstrMem: InstructionMemory port map(Clock,Program_Count, single_instruction);
RegFile: RegisterFile port map(CLock,Instructionmem(0)(18 downto 16),Instructionmem(0)(4 downto 0),
Instructionmem(0)(9 downto 5),Instructionmem(0)(14 downto 10),WriteData=>WriteData,ReadData1=>ReadData1,ReadData2=>ReadData2);
Sigextend: SignExtend port map(Instructionmem(0)(4 downto 0) ,signextended);
ALU1: ALU port map(Instructionmem(1)(18 downto 15),ReadData1,ReadData2,signextended,ALU_result,Zero=>Zero);
Hazard: HazardControl port map(InstructionMem(0),InstructionMem(1),ALU_Result,ReadData1,ReadData2,stall);
DM: DataMemory port map(Instructionmem(2)(18 to 16),ALU_result,ReadData2,clock,MemoryReadData);
WB: WriteBack port map(Instructionmem(3)(18 to 16),ALU_result,MemoryReadData,WriteData);
Process(Clock)
begin
if(Rising_edge(Clock))then
  if(count="000")then
      Instructionmem(0)<=single_instruction;
      count<=count+1;
   elsif(count="001")then
           Instructionmem(1)<=single_instruction;   
                 count<=count+1;
    elsif(count="010")then
                 Instructionmem(2)<=single_instruction;
                 count<=count+1;
    elsif(count="011")then
              Instructionmem(3)<=single_instruction;
              count<=count+1;
    else
         if(stall='0')then
              Instructionmem(3)<=Instructionmem(2);
              Instructionmem(2)<=Instructionmem(1);
              Instructionmem(1)<=Instructionmem(0);
              Instructionmem(0)<=single_instruction;
         else
              Instructionmem(3)<=Instructionmem(2);
              Instructionmem(2)<=Instructionmem(1);
              Instructionmem(1)<=Instructionmem(0);
              Instructionmem(0)<="0000000000000000000";
              
         end if;           
    
     if(instructionmem(0)(18 downto 16)="110" or instructionmem(0)(18 downto 16)="110")then --detecting control hazards
         stall<='1'; --stalling
     else
        stall<='0';    --continuing
    end if;    
end if;
end if;
end Process;
end Behavioral;
