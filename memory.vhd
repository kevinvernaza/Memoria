library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity memory is
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
end memory;

architecture arch of memory is

	component rom_128x8_sync is
	port( address  : in  std_logic_vector(7 downto 0);
			clock    : in  std_logic;
			data_out : out std_logic_vector(7 downto 0));
	end component;

	component rw_96x8_sync is
		port( address   : in std_logic_vector(7 downto 0);
				data_in   : in std_logic_vector(7 downto 0);
				clock     : in  std_logic;
				writen    : in std_logic;
				data_out  : out std_logic_vector(7 downto 0));
	end component;

	component outputPorts is
	port( clock       : in std_logic;
			reset       : in std_logic;
			address     : in std_logic_vector(7 downto 0);
			data_in     : in std_logic_vector(7 downto 0);
			writen      : in std_logic;
			port_out_00 : out std_logic_vector(7 downto 0);
			port_out_01 : out std_logic_vector(7 downto 0) );
	end component;


	component dip_switch IS
		 PORT ( en                 : in  std_logic_vector(7 DOWNTO 0);
				  display1, display2 : out std_logic_vector(6 DOWNTO 0));
	end component;

signal rom_data_out : std_logic_vector(7 downto 0);
signal rw_data_out  : std_logic_vector(7 downto 0);


begin

rom_128x8 : rom_128x8_sync port map(address , clock   , rom_data_out );
rw_96x8   : rw_96x8_sync   port map(address , data_in , clock   , writen  , rw_data_out);
outputs   : outputPorts    port map(clock   , reset   , address , data_in , writen , port_out_00 , port_out_01);

	MUX1 : process ( address , rom_data_out , rw_data_out , port_in_00 , port_in_01 )
		begin
			if ( (to_integer(unsigned(address)) >= 0) and
				(to_integer(unsigned(address)) <= 127)) then
				data_out <= rom_data_out;
				
			elsif ( (to_integer(unsigned(address)) >= 128) and
				(to_integer(unsigned(address)) <= 223)) then
				data_out <= rw_data_out;
				elsif (address = x"F0") then data_out <= port_in_00;
				elsif (address = x"F1") then data_out <= port_in_01;
				else data_out <= x"00";
			end if;
	end process;

end arch;