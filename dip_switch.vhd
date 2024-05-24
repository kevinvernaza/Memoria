LIBRARY IEEE;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY dip_switch IS
    PORT (
        en : IN  std_logic_vector(7 DOWNTO 0);
        display1, display2 : OUT std_logic_vector(6 DOWNTO 0)  
    );
END dip_switch;

ARCHITECTURE arch OF dip_switch IS

    FUNCTION to_7segment (hex : std_logic_vector(3 DOWNTO 0)) RETURN std_logic_vector IS
        VARIABLE seg : std_logic_vector(6 DOWNTO 0);
    BEGIN
        CASE hex IS
            WHEN "0000" => seg := "0000001"; -- 0
            WHEN "0001" => seg := "1001111"; -- 1
            WHEN "0010" => seg := "0010010"; -- 2
            WHEN "0011" => seg := "0000110"; -- 3
            WHEN "0100" => seg := "1001100"; -- 4
            WHEN "0101" => seg := "0100100"; -- 5
            WHEN "0110" => seg := "0100000"; -- 6
            WHEN "0111" => seg := "0001111"; -- 7
            WHEN "1000" => seg := "0000000"; -- 8
            WHEN "1001" => seg := "0000100"; -- 9
            WHEN "1010" => seg := "0001000"; -- A
            WHEN "1011" => seg := "1100000"; -- B
            WHEN "1100" => seg := "0110001"; -- C
            WHEN "1101" => seg := "1000010"; -- D
            WHEN "1110" => seg := "0110000"; -- E
            WHEN OTHERS => seg := "0111000"; -- F
        END CASE;
        RETURN seg;
    END FUNCTION;

    SIGNAL	 hex_value : std_logic_vector(7 DOWNTO 0);

BEGIN
    process(en)
    begin
        hex_value <= en; 

        display1 <= to_7segment(hex_value(7 DOWNTO 4));  -- Dígito más significativo
        display2 <= to_7segment(hex_value(3 DOWNTO 0));  -- Dígito menos significativo
    end process;

END arch;