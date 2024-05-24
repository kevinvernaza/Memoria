library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity memor_test is
port( clock      : in std_logic;
		reset      : in std_logic;
		address    : in std_logic_vector (7 downto 0);
		data_in    : in std_logic_vector (7 downto 0);
		writen     : in std_logic;
		port_in_00 : in std_logic_vector (7 downto 0);
		port_in_01 : in std_logic_vector (7 downto 0);
		port_out_00: out std_logic_vector(7 downto 0);
		port_out_01: out std_logic_vector(7 downto 0);
		address1   : out std_logic_vector(6 downto 0);
		address2   : out std_logic_vector(6 downto 0); 
		port_out1  : out std_logic_vector(6 downto 0); 
		port_out2  : out std_logic_vector(6 downto 0) );
end memor_test;

architecture arq of memor_test is

component memory is
	port( clock      : in std_logic;
			reset      : in std_logic;
			address    : in std_logic_vector(7 downto 0);
			data_in    : in std_logic_vector(7 downto 0);
			writen     : in std_logic;
			port_in_00 : in std_logic_vector(7 downto 0);
			port_in_01 : in std_logic_vector(7 downto 0);
			port_out_00: out std_logic_vector(7 downto 0);
			port_out_01: out std_logic_vector(7 downto 0);
			data_out   : out std_logic_vector(7 downto 0));
end component;

component dip_switch IS
	PORT ( en                 : in  std_logic_vector(7 DOWNTO 0);
			display1, display2 : out std_logic_vector(6 DOWNTO 0));
end component;

signal datao : std_logic_vector(7 downto 0);

begin

memoria : memory port map (clock , reset ,address , data_in , writen, port_in_00 , port_in_01 , port_out_00 , port_out_01 , datao);
dis1 : dip_switch port map(address , address1 , address2 );
dis2 : dip_switch port map(datao, port_out1 , port_out2);



end arq;