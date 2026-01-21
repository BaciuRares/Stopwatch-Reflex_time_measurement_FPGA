-- /////////////////////////////////////////////////////////////
-- Digits.vhd
-- Acest modul numără în mod controlat valori de la 0 la 9 (BCD)
-- și generează patru cifre care împreună formează un cronometru.
-- Semnalul `X` este folosit pentru a declanșa următoarea cifră.
-- /////////////////////////////////////////////////////////////

-- Digits.vhd

library IEEE;
use IEEE.STD_LOGIC_1164.ALL; 
use IEEE.NUMERIC_STD.ALL;

-- Entitate Digits: o cifră a cronometrului
entity Digits is
    Port ( S : in STD_LOGIC;     -- Semnal Start/Stop (permite incrementarea)
           RST : in STD_LOGIC;   -- Reset pentru contor
           CLK : in STD_LOGIC;   -- Ceas de incrementare (venit din divizor)
           N : out STD_LOGIC;   -- Semnal de tip "carry" pentru cifra următoare
           D : out STD_LOGIC_VECTOR ( 3 downto 0 ) );   -- Ieșirea BCD (valoarea cifrei 0..9)
end Digits;

architecture Behavioral of Digits is

    signal X : STD_LOGIC := '1';  -- Semnal intern pentru carry (declanșator pentru cifra următoare)

begin
    -- Procesul principal care incrementează cifra
    process ( S, CLK )
    
        variable count : unsigned ( 3 downto 0 ) := x"0"; 
    
    begin
        
        if RST = '1' then    -- La resetare
            count := x"0";   -- Resetează cifra la 0
            X <= '1';        -- Setează semnalul de carry la 1
        -- Când Start este activ și avem front crescător de ceas
        elsif ( S = '1' and rising_edge ( CLK ) ) then
            count := count + 1; --counting up
            -- Dacă s-a ajuns la 10 (0xA), revine la 0 și semnalizează următoarea cifră
            if ( STD_LOGIC_VECTOR ( count ) = x"A" ) then 
                count := x"0"; 
                X <= NOT X;  -- Inversează semnalul N (care va declanșa următoarea cifră)
             -- La mijlocul contorului (ex: 5), semnalul X este toggled (pentru control fin)        
            elsif ( STD_LOGIC_VECTOR ( count ) = x"5" ) then
                X <= NOT X; 
                    
            end if;
            
        end if;
        
        D <= STD_LOGIC_VECTOR ( count );  -- Ieșirea actuală a cifrei
        N <= X;         -- Trimite semnalul de tip carry (pentru cifrele superioare)
        
    end process;

end Behavioral;