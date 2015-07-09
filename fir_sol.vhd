library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
--use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use ieee.numeric_std.all;


library work;
use work.array_t.all;

entity fir_sol is
	Port ( 
	     	Reset : in  STD_LOGIC;
        Clk : in  STD_LOGIC;
        Input : in array32_t(0 to 9);
        Output : out  STD_LOGIC_VECTOR (31 downto 0)
	);
end fir_sol;

architecture Structural of fir_sol is
-- adding the components to the Design --
component adder 
  Port ( A : in  STD_LOGIC_VECTOR (31 downto 0);
         B : in  STD_LOGIC_VECTOR (31 downto 0);
         O : out  STD_LOGIC_VECTOR (31 downto 0));
end component;

component reg 
  Port ( Reset : in  STD_LOGIC;
         Clk : in  STD_LOGIC;
         Load : in  STD_LOGIC;
         Din : in  STD_LOGIC_VECTOR (31 downto 0);
         Dout : out  STD_LOGIC_VECTOR (31 downto 0));

end component; 


	signal mout : array32_t(0 to 30);-- just a big array i will use as much as i need from it , for the first one i will use from 0to 2 and for the second input i will use fro 3to 5 and like that a multiples of 3 
	signal aout : array32_t(0 to 25);

begin
-- the equivlant to multiplication of    X(0)*b(0) where b(0) = 3 which is 11 in binary that mean shift X(0) by two and add to X(0) 
--std_logic_vector(unsigned(inputA) srl to_integer(unsigned(inputB)));
	mout(1)<=std_logic_vector(unsigned(Input(0)) sll 1);
	add0: adder port map (
			A => mout(1),
			B => Input(0),
			O => aout(0)
		);	


-- the same for a(1)but with 23 = 11001 left shift by 3 and 4 and 0 
	mout(3)<=std_logic_vector(unsigned(Input(1)) sll 3);
	mout(4)<=std_logic_vector(unsigned(Input(1)) sll 4);
	add1: adder port map (
			A => mout(3),
			B => mout(4),
			O => mout(5)
		);	
	add2: adder port map (
			A => mout(5),
			B => Input(1),
			O => aout(1)
		);
 
 
-- the same for a(2)but with 96 = 110 0000 left shift by 5 and 6 
	mout(6)<=std_logic_vector(unsigned(Input(2)) sll 5);
	mout(7)<=std_logic_vector(unsigned(Input(2)) sll 6);
	add3: adder port map (
			A => mout(6),
			B => mout(7),
			O => aout(2)
		);	
	
	-- the same for a(3)but with 384 = 1 1000 0000   left  shift by 7 and 8 
	mout(9)<=std_logic_vector(unsigned(Input(3)) sll 7);
	mout(10)<=std_logic_vector(unsigned(Input(3)) sll 8);
	add4: adder port map (
			A => mout(9),
			B => mout(10),
			O => aout(3)
		);	
		
	-- the same for a(4)but with 3073 = 1100 0000 0001  left  shift by 10 and 11 and add a(4) 
	mout(12)<=std_logic_vector(unsigned(Input(4)) sll 10);
	mout(13)<=std_logic_vector(unsigned(Input(4)) sll 11);
	add5: adder port map (
			A => mout(12),
			B => mout(13),
			O => mout(14)
		);	
		
		add6: adder port map (
			A => mout(14),
			B => Input(4),
			O => aout(4)
		);
		
	-- the same for a(5)but with 3073 = 1100 0000 0001  left  shift by 10 and 11 and add a(5) 
	mout(15)<=std_logic_vector(unsigned(Input(5)) sll 10);
	mout(16)<=std_logic_vector(unsigned(Input(5)) sll 11);
	add7: adder port map (
			A => mout(15),
			B => mout(16),
			O => mout(17)
		);	
		
		add8: adder port map (
			A => mout(17),
			B => Input(5),
			O => aout(5)
		);
				
		-- the same for a(6)but with 384 = 1 1000 0000   left  shift by 7 and 8 
	mout(18)<=std_logic_vector(unsigned(Input(6)) sll 7);
	mout(19)<=std_logic_vector(unsigned(Input(6)) sll 8);
	add9: adder port map (
			A => mout(18),
			B => mout(19),
			O => aout(6)
		);	
		
-- the same for a(7)but with 96 = 110 0000 left shift by 5 and 6 
	mout(21)<=std_logic_vector(unsigned(Input(7)) sll 5);
	mout(22)<=std_logic_vector(unsigned(Input(7)) sll 6);
	add10: adder port map (
			A => mout(21),
			B => mout(22),
			O => aout(7)
		);	
		
	
-- the same for a(8)but with 25 = 11001 left shift by 3 and 4 and 0 
	mout(24)<=std_logic_vector(unsigned(Input(8)) sll 3);
	mout(25)<=std_logic_vector(unsigned(Input(8)) sll 4);
	add11: adder port map (
			A => mout(24),
			B => mout(25),
			O => mout(26)
		);	
	add112: adder port map (
			A => mout(26),
			B => Input(8),
			O => aout(8)
		);
-- the same for a(9)but with 3 = 11 left shift by 1 and  0 
	mout(27)<=std_logic_vector(unsigned(Input(9)) sll 1);
	add12: adder port map (
			A => mout(27),
			B => Input(9),
			O => aout(9)
		);	 	
		
		
		---adding the whole results 
		add13: adder port map (
			A => aout(0),
			B => aout(1),
			O => aout(10)
		);	 	
		
	
		  
		add14: adder port map (
			A => aout(2),
			B => aout(3),
			O => aout(11)
		);		
		add15: adder port map (
			A => aout(4),
			B => aout(5),
			O => aout(12) 
		);	
		
	
			add115: adder port map (
			A => aout(6),
			B => aout(7),
			O => aout(13)
		);

			add16:adder port map (
			A => aout(8),
			B => aout(9),
			O => aout(14)
			);
	
	add117: adder port map (
			A => aout(10),
			B => aout(11),
			O => aout(15)
		);
	add118: adder port map (
			A => aout(12),
			B => aout(13),
			O => aout(16)
		);

		  
		
			add17: adder port map (
			A => aout(15),
			B => aout(16),
			O => aout(17)
		);
		
			
		
			add18: adder port map (
			A => aout(14),
			B => aout(17),
			O => aout(18)
		);
		
	  reg3:reg  port map (
		    
		     Reset => Reset,
         Clk => Clk ,
         Load =>'1',
         Din => aout(18),
         Dout => aout(20)
		  );
Output<=aout(20);		
end Structural;

