-- /////////////////////////////////////////////////////////////
-- SSDDriver.vhd
-- Acest modul realizează multiplexarea afișajului cu 4 cifre pe 7 segmente.
-- Afișează pe rând valorile D0-D3 prin activarea pe rând a anodurilor.
-- Utilizat pentru afișarea a 4 cifre într-un singur afișaj 7-segmente.
-- /////////////////////////////////////////////////////////////

-- SSDDriver.vhd

library IEEE;
use IEEE.STD_LOGIC_1164.ALL; 
use IEEE.NUMERIC_STD.ALL;

entity SSDDriver is
    Port ( D0 : in STD_LOGIC_VECTOR (3 downto 0); 
           D1 : in STD_LOGIC_VECTOR (3 downto 0);
           D2 : in STD_LOGIC_VECTOR (3 downto 0); 
           D3 : in STD_LOGIC_VECTOR (3 downto 0); 
           CLK : in STD_LOGIC; 
           DP : out STD_LOGIC; 
           Anodes : out STD_LOGIC_VECTOR (3 downto 0); 
           temp : out STD_LOGIC_VECTOR (3 downto 0)); 
end SSDDriver;

architecture Behavioral of SSDDriver is

begin
-- Proces de multiplexare - activează pe rând câte o cifră
    process (CLK) 
    
        variable SEL : unsigned (1 downto 0) := "00"; -- Selector pentru cifrele 0..3
        
    begin
    
        if (rising_edge(CLK)) then 
            case SEL is
            
                when "00" => temp <= D0; -- Selectează cifra D0 si trimite D0 la afisaj
                    Anodes <= "1110";    -- Activează anoda 0 (activ low)
                    DP <= '1';          -- Punctul zecimal inactiv
                    SEL := SEL + 1;     -- Trecem la cifra următoare
                    
                when "01" => temp <= D1; 
                    Anodes <= "1101"; 
                    DP <= '1'; 
                    SEL := SEL + 1; 
                        
                when "10" => temp <= D2; 
                    Anodes <= "1011"; 
                    DP <= '0'; 
                    SEL := SEL + 1; 
                    
                when others => temp <= D3; 
                    Anodes <= "0111"; 
                    DP <= '1'; 
                    SEL := "00"; 
            end case;
            
        end if;
        
    end process;

end Behavioral;

