-- /////////////////////////////////////////////////////////////
-- ClkDivider.vhd
-- Acest modul împarte frecvența unui ceas de intrare (ex: 100 MHz)
-- în funcție de un divizor variabil. Este folosit pentru a genera
-- ceasuri lente pentru afișaj sau alte componente.
-- /////////////////////////////////////////////////////////////

-- ClkDivider.vhd

library IEEE;
use IEEE.STD_LOGIC_1164.ALL; 
use IEEE.NUMERIC_STD.ALL;

-- Entitatea modulului ClkDivider
entity ClkDivider is
    Port ( CLK : in STD_LOGIC;    -- Intrare ceas (ex: 100 MHz)
           Divisor : in STD_LOGIC_VECTOR ( 31 downto 0 );   -- Valoare de divizare (în cicluri de CLK)
           CLKOUT : out STD_LOGIC );  -- Ieșire: semnal de ceas divizat
end ClkDivider;

-- Arhitectura comportamentală
architecture Behavioral of ClkDivider is

    signal CLKTOG : STD_LOGIC := '0'; -- Semnal intern care va fi toggled (întors) când se atinge divizorul

begin
    -- Procesul de divizare a ceasului
    process ( CLK )
        -- Contor pe 32 biți inițializat cu 0
        variable count : unsigned ( 31 downto 0 ) := x"00000000"; 
        
    begin
    
        if ( rising_edge ( CLK ) ) then   -- La fiecare front crescător al ceasului de sistem
            count := count + 1;           -- Incrementează contorul
            if ( STD_LOGIC_VECTOR ( count ) = Divisor ) then   -- Compară contorul cu divizorul dat
                CLKTOG <= NOT CLKTOG;    -- Inversează semnalul de ieșire (toggle)
                count := x"00000000";    -- Resetează contorul
                
            end if;
            
        end if;
        
    end process;
    -- Ieșirea finală CLKOUT este semnalul toggled
    CLKOUT <= CLKTOG; 
end Behavioral;