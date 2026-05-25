-- Jobs pt_BR — ordem Untitled-1 (114 trabalhos)
-- Posição 1 = order 114; posição 114 = order 1 (sort DESC no frontend)
-- Idempotente: pode rodar mais de uma vez

-- Duplicata legada: "DEVS DE IMPACTO" e "DEVDAY EXCHANGE" compartilham legacy_id 8642631f...
-- Só DEVDAY EXCHANGE entra na grade (Untitled-1, posição 5). O outro fica fora da listagem.
UPDATE posts SET status = 'draft', meta_values = json_set(meta_values, '$.order', 0)
WHERE slug = 'devs-de-impacto-open-ai-pt-br' AND json_extract(meta_values, '$.posttype') = 'jobs';

-- 114 | Truco Masters (id=694)
UPDATE posts SET meta_values = json_set(meta_values, '$.order', 114) WHERE id = 694;
-- 113 | ABERTO AO PÚBLICO | GLOBO (id=314)
UPDATE posts SET meta_values = json_set(meta_values, '$.order', 113) WHERE id = 314;
-- 112 | PÍLULA DE FARINHA - O ESCÂNDALO QUE GEROU VIDAS (id=612)
UPDATE posts SET meta_values = json_set(meta_values, '$.order', 112) WHERE id = 612;
-- 111 | Do Que Riem? | Paramount+ (id=430)
UPDATE posts SET meta_values = json_set(meta_values, '$.order', 111) WHERE id = 430;
-- 110 | DEVDAY EXCHANGE | OPEN AI (slug=devday-exchange-open-ai-pt-br; ausente no CSV)
UPDATE posts SET meta_values = json_set(meta_values, '$.order', 110) WHERE slug = 'devday-exchange-open-ai-pt-br' AND json_extract(meta_values, '$.posttype') = 'jobs';
-- 109 | No Ritmo da Lore (id=562)
UPDATE posts SET meta_values = json_set(meta_values, '$.order', 109) WHERE id = 562;
-- 108 | ORGANIZAÇÃO PURA - NOVELA VERTICAL | BV FINANCEIRA (slug=organizacao-pura-novela-vertical-bv-financeira-pt-br; ausente no CSV)
UPDATE posts SET meta_values = json_set(meta_values, '$.order', 108) WHERE slug = 'organizacao-pura-novela-vertical-bv-financeira-pt-br' AND json_extract(meta_values, '$.posttype') = 'jobs';
-- 107 | Familhão | Domingão do Huck (id=452)
UPDATE posts SET meta_values = json_set(meta_values, '$.order', 107) WHERE id = 452;
-- 106 | Lançamento Lightyear | Disney (id=508)
UPDATE posts SET meta_values = json_set(meta_values, '$.order', 106) WHERE id = 508;
-- 105 | Toca Revela - O Reality | UOL (id=686)
UPDATE posts SET meta_values = json_set(meta_values, '$.order', 105) WHERE id = 686;
-- 104 | CONTROLE DE QUALIDADE com REGINA VOLPATO | PARAMOUNT + (id=372)
UPDATE posts SET meta_values = json_set(meta_values, '$.order', 104) WHERE id = 372;
-- 103 | RAFI (id=624)
UPDATE posts SET meta_values = json_set(meta_values, '$.order', 103) WHERE id = 624;
-- 102 | CAMPANHA DIGITAL - PÍLULA DE FARINHA | HBO MAX (slug=campanha-digital-pilula-de-farinha-hbo-max-pt-br; ausente no CSV)
UPDATE posts SET meta_values = json_set(meta_values, '$.order', 102) WHERE slug = 'campanha-digital-pilula-de-farinha-hbo-max-pt-br' AND json_extract(meta_values, '$.posttype') = 'jobs';
-- 101 | DIAS DAS MÃES DUDALINA COM MARIA FERNANDA CÂNDIDO (slug=dias-das-maes-dudalina-com-maria-fernanda-candido-pt-br; ausente no CSV)
UPDATE posts SET meta_values = json_set(meta_values, '$.order', 101) WHERE slug = 'dias-das-maes-dudalina-com-maria-fernanda-candido-pt-br' AND json_extract(meta_values, '$.posttype') = 'jobs';
-- 100 | Corrida de São Sylvester | Paramount+ (id=388)
UPDATE posts SET meta_values = json_set(meta_values, '$.order', 100) WHERE id = 388;
--  99 | O Poder da Escolha | Rennova (id=572)
UPDATE posts SET meta_values = json_set(meta_values, '$.order', 99) WHERE id = 572;
--  98 | Tati Folia 2025 (id=674)
UPDATE posts SET meta_values = json_set(meta_values, '$.order', 98) WHERE id = 674;
--  97 | Posso Mandar Áudio? | Globoplay (id=602)
UPDATE posts SET meta_values = json_set(meta_values, '$.order', 97) WHERE id = 602;
--  96 | Expedição Ultravioleta | Nubank (id=448)
UPDATE posts SET meta_values = json_set(meta_values, '$.order', 96) WHERE id = 448;
--  95 | Curso Livelo | Livelo (id=400)
UPDATE posts SET meta_values = json_set(meta_values, '$.order', 95) WHERE id = 400;
--  94 | CAMPANHA DIGITAL: ABERTO AO PÚBLICO TEMPORADA 1 E 2 | TVGLOBO (slug=campanha-digital-aberto-ao-publico-temporada-1-e-2-tvglobo-pt-br; ausente no CSV)
UPDATE posts SET meta_values = json_set(meta_values, '$.order', 94) WHERE slug = 'campanha-digital-aberto-ao-publico-temporada-1-e-2-tvglobo-pt-br' AND json_extract(meta_values, '$.posttype') = 'jobs';
--  93 | Knuckles | Paramount + (id=502)
UPDATE posts SET meta_values = json_set(meta_values, '$.order', 93) WHERE id = 502;
--  92 | Natal | Dudalina (id=552)
UPDATE posts SET meta_values = json_set(meta_values, '$.order', 92) WHERE id = 552;
--  91 | PIX | Itaú (id=582)
UPDATE posts SET meta_values = json_set(meta_values, '$.order', 91) WHERE id = 582;
--  90 | Super Live Black Friday | Shoptime (id=668)
UPDATE posts SET meta_values = json_set(meta_values, '$.order', 90) WHERE id = 668;
--  89 | Rock in Rio | TIM (id=652)
UPDATE posts SET meta_values = json_set(meta_values, '$.order', 89) WHERE id = 652;
--  88 | Dia dos Pais | Farfetch (id=422)
UPDATE posts SET meta_values = json_set(meta_values, '$.order', 88) WHERE id = 422;
--  87 | Projeto Upload | CNN BRASIL (id=610)
UPDATE posts SET meta_values = json_set(meta_values, '$.order', 87) WHERE id = 610;
--  86 | Lançamento Luca | Disney+ (id=510)
UPDATE posts SET meta_values = json_set(meta_values, '$.order', 86) WHERE id = 510;
--  85 | Dia das Mães | Dudalina (id=416)
UPDATE posts SET meta_values = json_set(meta_values, '$.order', 85) WHERE id = 416;
--  84 | Já fui Você | NATURA + MiBR (id=494)
UPDATE posts SET meta_values = json_set(meta_values, '$.order', 84) WHERE id = 494;
--  83 | Gastronomia Periférica | Continental (id=480)
UPDATE posts SET meta_values = json_set(meta_values, '$.order', 83) WHERE id = 480;
--  82 | Dia dos Pais | Dudalina (id=420)
UPDATE posts SET meta_values = json_set(meta_values, '$.order', 82) WHERE id = 420;
--  81 | Dia das Mães | Shein (id=418)
UPDATE posts SET meta_values = json_set(meta_values, '$.order', 81) WHERE id = 418;
--  80 | Boca a Boca | Live (id=336)
UPDATE posts SET meta_values = json_set(meta_values, '$.order', 80) WHERE id = 336;
--  79 | Especial Luca | Disney (id=446)
UPDATE posts SET meta_values = json_set(meta_values, '$.order', 79) WHERE id = 446;
--  78 | Palco Paramount CCXP23 | Paramount+ (id=580)
UPDATE posts SET meta_values = json_set(meta_values, '$.order', 78) WHERE id = 580;
--  77 | Live Oscar | Omelete (id=520)
UPDATE posts SET meta_values = json_set(meta_values, '$.order', 77) WHERE id = 520;
--  76 | Más Bueno. Más Breyers | Breyers (id=550)
UPDATE posts SET meta_values = json_set(meta_values, '$.order', 76) WHERE id = 550;
--  75 | Energia Verde | Heineken (id=440)
UPDATE posts SET meta_values = json_set(meta_values, '$.order', 75) WHERE id = 440;
--  74 | CCXP Worlds 2021 – Road to Artists’ Valley | Santander (id=352)
UPDATE posts SET meta_values = json_set(meta_values, '$.order', 74) WHERE id = 352;
--  73 | Foi Mau | RedeTV! (id=472)
UPDATE posts SET meta_values = json_set(meta_values, '$.order', 73) WHERE id = 472;
--  72 | Lançamento Um Cavaleiro em Moscou | Paramount + (id=512)
UPDATE posts SET meta_values = json_set(meta_values, '$.order', 72) WHERE id = 512;
--  71 | Foca em 2023 | Foquinha (id=468)
UPDATE posts SET meta_values = json_set(meta_values, '$.order', 71) WHERE id = 468;
--  70 | Supositório | Spotify (id=672)
UPDATE posts SET meta_values = json_set(meta_values, '$.order', 70) WHERE id = 672;
--  69 | Otalab | UOL (id=578)
UPDATE posts SET meta_values = json_set(meta_values, '$.order', 69) WHERE id = 578;
--  68 | Redes Sociais Últimas Férias | Star+ (id=634)
UPDATE posts SET meta_values = json_set(meta_values, '$.order', 68) WHERE id = 634;
--  67 | Vidente por Acidente | Cinema (id=704)
UPDATE posts SET meta_values = json_set(meta_values, '$.order', 67) WHERE id = 704;
--  66 | CCXP Worlds 2020 | Omelete (id=348)
UPDATE posts SET meta_values = json_set(meta_values, '$.order', 66) WHERE id = 348;
--  65 | Desejos S.A. | STAR+ (id=408)
UPDATE posts SET meta_values = json_set(meta_values, '$.order', 65) WHERE id = 408;
--  64 | Quadros Originais Redes | Luciano Huck (id=618)
UPDATE posts SET meta_values = json_set(meta_values, '$.order', 64) WHERE id = 618;
--  63 | Art Attack – Modo Desafio | Disney (id=324)
UPDATE posts SET meta_values = json_set(meta_values, '$.order', 63) WHERE id = 324;
--  62 | Foquinha Entrevista | Videocast (id=476)
UPDATE posts SET meta_values = json_set(meta_values, '$.order', 62) WHERE id = 476;
--  61 | CTRL SER + CTRL VER | UNIVERSA UOL (id=396)
UPDATE posts SET meta_values = json_set(meta_values, '$.order', 61) WHERE id = 396;
--  60 | Tá Voando | Itaú (id=700)
UPDATE posts SET meta_values = json_set(meta_values, '$.order', 60) WHERE id = 700;
--  59 | #LEGADO | Cannabis Thinking (id=302)
UPDATE posts SET meta_values = json_set(meta_values, '$.order', 59) WHERE id = 302;
--  58 | Lady Leste | Glória Groove (id=506)
UPDATE posts SET meta_values = json_set(meta_values, '$.order', 58) WHERE id = 506;
--  57 | Gato Galáctico e o Feitiço do Tempo | Cinema (id=484)
UPDATE posts SET meta_values = json_set(meta_values, '$.order', 57) WHERE id = 484;
--  56 | À Moda da Isa | Uol (id=708)
UPDATE posts SET meta_values = json_set(meta_values, '$.order', 56) WHERE id = 708;
--  55 | À moda da Isa – VERÃO | UOL (id=712)
UPDATE posts SET meta_values = json_set(meta_values, '$.order', 55) WHERE id = 712;
--  54 | Foca em 2021 | Tik Tok (id=464)
UPDATE posts SET meta_values = json_set(meta_values, '$.order', 54) WHERE id = 464;
--  53 | Podcasts Porta dos Fundos | Deezer (id=594)
UPDATE posts SET meta_values = json_set(meta_values, '$.order', 53) WHERE id = 594;
--  52 | Plantão | Liquida Shoptime (id=590)
UPDATE posts SET meta_values = json_set(meta_values, '$.order', 52) WHERE id = 590;
--  51 | Receitas de Fim de Semana | Nestlé (id=628)
UPDATE posts SET meta_values = json_set(meta_values, '$.order', 51) WHERE id = 628;
--  50 | Mais Vividas | Molico (id=526)
UPDATE posts SET meta_values = json_set(meta_values, '$.order', 50) WHERE id = 526;
--  49 | Põe Cremosidade Nisso | Nestlé (id=616)
UPDATE posts SET meta_values = json_set(meta_values, '$.order', 49) WHERE id = 616;
--  48 | Deu Ruim | Receitas Nestlé (id=412)
UPDATE posts SET meta_values = json_set(meta_values, '$.order', 48) WHERE id = 412;
--  47 | Nutri Ajuda | Nutren (id=566)
UPDATE posts SET meta_values = json_set(meta_values, '$.order', 47) WHERE id = 566;
--  46 | Chocolateria | Garoto (id=356)
UPDATE posts SET meta_values = json_set(meta_values, '$.order', 46) WHERE id = 356;
--  45 | Escolhas Certas | Maggi (id=444)
UPDATE posts SET meta_values = json_set(meta_values, '$.order', 45) WHERE id = 444;
--  44 | Brasil Sabores Mil | Receitas Nestlé (id=340)
UPDATE posts SET meta_values = json_set(meta_values, '$.order', 44) WHERE id = 340;
--  43 | Donos da Razão | Podcast (id=434)
UPDATE posts SET meta_values = json_set(meta_values, '$.order', 43) WHERE id = 434;
--  42 | Kiune Talks | Kiune (id=498)
UPDATE posts SET meta_values = json_set(meta_values, '$.order', 42) WHERE id = 498;
--  41 | Batalha dos Eliminados | Splash UOL (id=332)
UPDATE posts SET meta_values = json_set(meta_values, '$.order', 41) WHERE id = 332;
--  40 | #LogitechnaBGS | Logitech (id=306)
UPDATE posts SET meta_values = json_set(meta_values, '$.order', 40) WHERE id = 306;
--  39 | Compro Likes | Star+ (id=366)
UPDATE posts SET meta_values = json_set(meta_values, '$.order', 39) WHERE id = 366;
--  38 | ACUVUE | Redes Otaviano e Flávia Alessandra (id=318)
UPDATE posts SET meta_values = json_set(meta_values, '$.order', 38) WHERE id = 318;
--  37 | TODDY | Redes Otaviano Costa (id=688)
UPDATE posts SET meta_values = json_set(meta_values, '$.order', 37) WHERE id = 688;
--  36 | A Última Peça | Cinema (id=312)
UPDATE posts SET meta_values = json_set(meta_values, '$.order', 36) WHERE id = 312;
--  35 | Creators | Kwai (id=392)
UPDATE posts SET meta_values = json_set(meta_values, '$.order', 35) WHERE id = 392;
--  34 | Café com Late Show | Nescafé (id=344)
UPDATE posts SET meta_values = json_set(meta_values, '$.order', 34) WHERE id = 344;
--  33 | De Volta Para um Futuro Melhor | Nestlé (id=404)
UPDATE posts SET meta_values = json_set(meta_values, '$.order', 33) WHERE id = 404;
--  32 | Nestatueta de Ouro | Nescau (id=556)
UPDATE posts SET meta_values = json_set(meta_values, '$.order', 32) WHERE id = 556;
--  31 | Neston Chef | Neston (id=560)
UPDATE posts SET meta_values = json_set(meta_values, '$.order', 31) WHERE id = 560;
--  30 | Convenção Comercial | Nestlé (id=380)
UPDATE posts SET meta_values = json_set(meta_values, '$.order', 30) WHERE id = 380;
--  29 | Abertura Convenção | Nestlé (id=316)
UPDATE posts SET meta_values = json_set(meta_values, '$.order', 29) WHERE id = 316;
--  28 | Convenção | Starbucks (id=384)
UPDATE posts SET meta_values = json_set(meta_values, '$.order', 28) WHERE id = 384;
--  27 | Lançamento | STAR+ (id=514)
UPDATE posts SET meta_values = json_set(meta_values, '$.order', 27) WHERE id = 514;
--  26 | Mil e Uma Tretas | Videocast (id=538)
UPDATE posts SET meta_values = json_set(meta_values, '$.order', 26) WHERE id = 538;
--  25 | Terapia com Ex | Histórias de Terapia (id=678)
UPDATE posts SET meta_values = json_set(meta_values, '$.order', 25) WHERE id = 678;
--  24 | Monster Mansion | Fanta (id=542)
UPDATE posts SET meta_values = json_set(meta_values, '$.order', 24) WHERE id = 542;
--  23 | Planta Faz Isso? | Videocast (id=586)
UPDATE posts SET meta_values = json_set(meta_values, '$.order', 23) WHERE id = 586;
--  22 | Posso Explicar com Miá Mello | NatGeo (id=598)
UPDATE posts SET meta_values = json_set(meta_values, '$.order', 22) WHERE id = 598;
--  21 | Coach Nada | Laddy Nada (id=360)
UPDATE posts SET meta_values = json_set(meta_values, '$.order', 21) WHERE id = 360;
--  20 | MEME da Comédia | TNT (id=534)
UPDATE posts SET meta_values = json_set(meta_values, '$.order', 20) WHERE id = 534;
--  19 | Foca em 2020 | Live (id=460)
UPDATE posts SET meta_values = json_set(meta_values, '$.order', 19) WHERE id = 460;
--  18 | Prepare Seu Coração | Spotify (id=606)
UPDATE posts SET meta_values = json_set(meta_values, '$.order', 18) WHERE id = 606;
--  17 | Ascendente em Música | Spotify (id=328)
UPDATE posts SET meta_values = json_set(meta_values, '$.order', 17) WHERE id = 328;
--  16 | Roma | Netflix (id=656)
UPDATE posts SET meta_values = json_set(meta_values, '$.order', 16) WHERE id = 656;
--  15 | Conselho Fora de Classe | Videocast (id=370)
UPDATE posts SET meta_values = json_set(meta_values, '$.order', 15) WHERE id = 370;
--  14 | The Crown com Elza Soares | Netflix (id=682)
UPDATE posts SET meta_values = json_set(meta_values, '$.order', 14) WHERE id = 682;
--  13 | Diário do Olivier | GNT (id=426)
UPDATE posts SET meta_values = json_set(meta_values, '$.order', 13) WHERE id = 426;
--  12 | Interrogatório com Kevin - Elite | Netflix (id=490)
UPDATE posts SET meta_values = json_set(meta_values, '$.order', 12) WHERE id = 490;
--  11 | Resolvi Esperar com Sandy - La Casa de Papel |  Netflix (id=648)
UPDATE posts SET meta_values = json_set(meta_values, '$.order', 11) WHERE id = 648;
--  10 | Matilha | Francisco El Hombre (id=530)
UPDATE posts SET meta_values = json_set(meta_values, '$.order', 10) WHERE id = 530;
--   9 | El Camino com Mauricio Meirelles | Netflix (id=438)
UPDATE posts SET meta_values = json_set(meta_values, '$.order', 9) WHERE id = 438;
--   8 | Seus momentos sua vida | Canon (id=660)
UPDATE posts SET meta_values = json_set(meta_values, '$.order', 8) WHERE id = 660;
--   7 | O Maior Rótulo do Mundo | Heinz (id=570)
UPDATE posts SET meta_values = json_set(meta_values, '$.order', 7) WHERE id = 570;
--   6 | Quem viver, verão | Skol (id=622)
UPDATE posts SET meta_values = json_set(meta_values, '$.order', 6) WHERE id = 622;
--   5 | #ChegadeEstigma | Intimus / KOTEX (id=298)
UPDATE posts SET meta_values = json_set(meta_values, '$.order', 5) WHERE id = 298;
--   4 | #ReceitasdeumaPanelaSó | Rochedo (id=308)
UPDATE posts SET meta_values = json_set(meta_values, '$.order', 4) WHERE id = 308;
--   3 | Lançamentos | Netflix (id=516)
UPDATE posts SET meta_values = json_set(meta_values, '$.order', 3) WHERE id = 516;
--   2 | Convenção | Nestlé (id=382)
UPDATE posts SET meta_values = json_set(meta_values, '$.order', 2) WHERE id = 382;
--   1 | RECEITAS NESTLÉ | NESTLÉ (id=632)
UPDATE posts SET meta_values = json_set(meta_values, '$.order', 1) WHERE id = 632;
