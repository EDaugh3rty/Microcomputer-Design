----------------------------------------------------------------------------------
-- Company: Letourneau University
-- Engineer: Ethan Daugherty
-- 
-- Create Date:    15:29:26 03/28/2023 
-- Design Name: Microcomputer Design
-- Module Name:    MCD_VHDL - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
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
use ieee.numeric_std.ALL;
use ieee.std_logic_unsigned.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity MCD_VHDL is
    Port ( IPL0 	: out  STD_LOGIC;
           IPL1 	: out  STD_LOGIC;
           IPL2 	: out  STD_LOGIC;
           FC0 	: in  STD_LOGIC;
           FC1 	: in  STD_LOGIC;
           FC2 	: in  STD_LOGIC;
           IACK 	: out  STD_LOGIC;
           AS 		: in  STD_LOGIC;
           UDS 	: in  STD_LOGIC;
           LDS 	: in  STD_LOGIC;
           RW 		: in  STD_LOGIC;
           INTR 	: in  STD_LOGIC;
           BERR 	: out  STD_LOGIC;
           RWDU	: out  STD_LOGIC;
           RESET	: in  STD_LOGIC;
           CPURES : out  STD_LOGIC;
           RESDU	: out  STD_LOGIC;
           HALT 	: out  STD_LOGIC;
           DTACK 	: out  STD_LOGIC;
           DDTACK : in  STD_LOGIC;
           CLK 	: in  STD_LOGIC;
           ADDR	: in	STD_LOGIC_VECTOR(2 downto 0);
           DUCS 	: out  STD_LOGIC;
           ROMCE1 : out  STD_LOGIC;
           ROMCE2 : out  STD_LOGIC;
           RAMCE1 : out  STD_LOGIC;
           RAMCE2 : out  STD_LOGIC;
           RAMWE1 : out  STD_LOGIC;
           RAMWE2 : out  STD_LOGIC;
           LED0 	: out  STD_LOGIC;
           LED1 	: out  STD_LOGIC;
           LED2 	: out  STD_LOGIC);
end MCD_VHDL;

architecture Behavioral of MCD_VHDL is
				
begin

	HALT <= '0' when(RESET = '0') else 'Z';--activates HALT when reset button is clicked
	CPURES <= '0' when(RESET = '0') else 'Z';--activates CPU Reset when reset button is clicked
	RESDU <= '0' when(RESET = '0') else 'Z';--activates DUART RESET when reset button is clicked
	
	ROMCE1 <= LDS when(ADDR = "000" and RW = '1' and AS = '0') else '1';--activates lower ROM chip
	ROMCE2 <= UDS when(ADDR = "000" and RW = '1' and AS = '0') else '1';--activates upper ROM chip
	
	RAMCE1 <= LDS when(ADDR = "001" and AS = '0') else '1';--activates lower RAM chip
	RAMCE2 <= UDS when(ADDR = "001" and AS = '0') else '1';--activates upper RAM chip
	RAMWE1 <= RW;--ties the CPU read and write pin to the lower RAM R/W pin
	RAMWE2 <= RW;--ties the CPU r/w pin to the upper RAM R/W pin
	
	RWDU <= RW;--ties R/W of CPU to the DUART R/W
	DUCS <= '0' when(ADDR = "010" and AS = '0' and LDS = '0') else '1';--activates DUART
	
	DTACK <= DDTACK when(ADDR = "010") else '0';--DTACK interacting with DUART
	
	--Setting signals to their deactive state
	BERR <= '1';
	IPL0 <= '1';
	IPL1 <= '1';
	IPL2 <= '1';
	IACK <= '1';
	
	--Function codes displayed on LEDS
	LED0 <= ADDR(0);
	LED1 <= ADDR(1);
	LED2 <= ADDR(2);
	
end Behavioral;