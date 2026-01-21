-- /////////////////////////////////////////////////////////////
-- Stopwatch_main.vhd
-- Acest fișier reprezintă modulul principal (top-level) al proiectului.
-- Este responsabil cu logica generală de control a cronometrului, afișarea timpului
-- pe 7-segmente și evaluarea scorului pe baza timpului de reacție.
-- 
-- FUNCȚIONALITĂȚI:
-- • S1 (BTNR) → START
-- • S2 (BTNC) → STOP + salvează timpul și afișează scorul pe LED-uri 0-9
-- • S3 (BTNU) → Afișează timpul cel mai bun
-- • S4 (BTND) → Afișează timpul cel mai slab
-- • RST (BTNL) → RESET general
-- 
-- • Scorul este determinat în funcție de timpul măsurat în milisecunde.
-- • LED-urile 0-9 se aprind pentru 2 secunde corespunzător scorului (nota 1-10)
-- /////////////////////////////////////////////////////////////

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

-- Declarația entității principale cu porturile aferente
entity Stopwatch_main is
    port (
        CLK      : in  STD_LOGIC;
        RST      : in  STD_LOGIC;
        S1       : in  STD_LOGIC;
        S2       : in  STD_LOGIC;
        S3       : in  STD_LOGIC;
        S4       : in  STD_LOGIC;
        segments : out STD_LOGIC_VECTOR (6 downto 0);
        Anodes   : out STD_LOGIC_VECTOR (3 downto 0);
        DP       : out STD_LOGIC;
        LED      : out STD_LOGIC_VECTOR (9 downto 0)
    );
end Stopwatch_main;

architecture Behavioral of Stopwatch_main is
    -- Declarații pentru componente utilizate
    component ClkDivider
        port ( CLK : in STD_LOGIC;
               Divisor : in STD_LOGIC_VECTOR (31 downto 0);
               CLKOUT : out STD_LOGIC );
    end component;

    component SSDDriver
        port ( D0, D1, D2, D3 : in STD_LOGIC_VECTOR (3 downto 0);
               CLK : in STD_LOGIC;
               DP : out STD_LOGIC;
               Anodes, temp : out STD_LOGIC_VECTOR (3 downto 0) );
    end component;

    component Digits
        port ( S, RST, CLK : in STD_LOGIC;
               N : out STD_LOGIC;
               D : out STD_LOGIC_VECTOR (3 downto 0) );
    end component;

    component SevSegmentDisplayModule
        port ( digit : in STD_LOGIC_VECTOR (3 downto 0);
               Segs : out STD_LOGIC_VECTOR (6 downto 0) );
    end component;
    -- Semnale interne pentru clock-uri și control
    signal CLKINA, CLKIN0, S10, N0, N1, N2, N3 : STD_LOGIC := '0';
    signal temp, D0, D1, D2, D3 : STD_LOGIC_VECTOR (3 downto 0);
     -- Semnale pentru memorarea timpului minim și maxim
    signal best0, best1, best2, best3 : STD_LOGIC_VECTOR(3 downto 0) := (others => '1');
    signal worst0, worst1, worst2, worst3 : STD_LOGIC_VECTOR(3 downto 0) := (others => '0');
    signal last0, last1, last2, last3 : STD_LOGIC_VECTOR(3 downto 0);
    signal out0, out1, out2, out3 : STD_LOGIC_VECTOR(3 downto 0);
    -- Semnale pentru scor vizual
    signal score_leds : STD_LOGIC_VECTOR(9 downto 0) := (others => '0');
    signal score_timer : integer := 0;
    signal showing_score : boolean := false;

begin

    -- Proces principal care rulează la front crescător al semnalului CLKINA (clock divizat din 100 MHz)
   process (CLKINA)
   -- Variabile temporare pentru combinarea cifrelor într-un număr
    variable combined_time : unsigned(15 downto 0);
    variable score : integer := 0;
begin
    -- Execută totul la front crescător de ceas (divizat din 100 MHz)
    if rising_edge(CLKINA) then
        -- Resetare generală
        if RST = '1' then
            score_timer <= 0;
            score_leds <= (others => '0');
            showing_score <= false;
        end if;
        -- Start cronometrul (BTNR)
        if S1 = '1' then
            S10 <= '1'; -- Pornește incrementarea cifrelor
            -- Stop cronometrul (BTNC)
        elsif S2 = '1' then
            S10 <= '0'; -- Oprește incrementarea

            -- salveaza ultimul timp
            last0 <= D0;
            last1 <= D1;
            last2 <= D2;
            last3 <= D3;

            -- comparare best
            if (D3 & D2 & D1 & D0) < (best3 & best2 & best1 & best0) then
                best0 <= D0;
                best1 <= D1;
                best2 <= D2;
                best3 <= D3;
            end if;

            -- comparare worst
            if (D3 & D2 & D1 & D0) > (worst3 & worst2 & worst1 & worst0) then
                worst0 <= D0;
                worst1 <= D1;
                worst2 <= D2;
                worst3 <= D3;
            end if;

            -- calcul scor realist (unități în milisecunde)
            combined_time := unsigned(D3 & D2 & D1 & D0);
            if to_integer(combined_time) <= 50 then
                score := 10;
            elsif to_integer(combined_time) <= 100 then
                score := 9;
            elsif to_integer(combined_time) <= 150 then
                score := 8;
            elsif to_integer(combined_time) <= 200 then
                score := 7;
            elsif to_integer(combined_time) <= 300 then
                score := 6;
            elsif to_integer(combined_time) <= 350 then
                score := 5;
            elsif to_integer(combined_time) <= 400 then
                score := 4;
            elsif to_integer(combined_time) <= 450 then
                score := 3;
            elsif to_integer(combined_time) <= 500 then
                score := 2;
            else
                score := 1;
            end if;

            -- aprinde leduri conform scorului
            case score is
                when 1  => score_leds <= "0000000001";
                when 2  => score_leds <= "0000000011";
                when 3  => score_leds <= "0000000111";
                when 4  => score_leds <= "0000001111";
                when 5  => score_leds <= "0000011111";
                when 6  => score_leds <= "0000111111";
                when 7  => score_leds <= "0001111111";
                when 8  => score_leds <= "0011111111";
                when 9  => score_leds <= "0111111111";
                when 10 => score_leds <= "1111111111";
                when others => score_leds <= (others => '0');
            end case;

            score_timer <= 200000000; -- 2 secunde la 100 MHz
            showing_score <= true;

        elsif showing_score then
            if score_timer > 0 then
                score_timer <= score_timer - 1;
            else
                score_leds <= (others => '0');
                showing_score <= false;
            end if;
        end if;
    end if;
end process;

    ClkA : ClkDivider port map ( CLK => CLK, Divisor => x"000186A0", CLKOUT => CLKINA );
    Clk0 : ClkDivider port map ( CLK => CLK, Divisor => x"0007A120", CLKOUT => CLKIN0 );

    Digit0 : Digits port map ( CLK => CLKIN0, RST => RST, S => S10, D => D0, N => N1 );
    Digit1 : Digits port map ( CLK => N1, RST => RST, S => S10, D => D1, N => N2 );
    Digit2 : Digits port map ( CLK => N2, RST => RST, S => S10, D => D2, N => N3 );
    Digit3 : Digits port map ( CLK => N3, RST => RST, S => S10, D => D3, N => N0 );

    -- selectare ce afisam
    out0 <= best0 when S3 = '1' else worst0 when S4 = '1' else D0;
    out1 <= best1 when S3 = '1' else worst1 when S4 = '1' else D1;
    out2 <= best2 when S3 = '1' else worst2 when S4 = '1' else D2;
    out3 <= best3 when S3 = '1' else worst3 when S4 = '1' else D3;

    Driver : SSDDriver port map (
        D0 => out0, D1 => out1, D2 => out2, D3 => out3,
        CLK => CLKINA, DP => DP, Anodes => Anodes, temp => temp
    );

    Display : SevSegmentDisplayModule port map ( digit => temp, Segs => segments );

    LED <= score_leds;

end Behavioral;