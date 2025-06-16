-- Insert Dutch supermarket stores
INSERT INTO stores (name, chain, address, city, postal_code, latitude, longitude) VALUES
  ('Albert Heijn Amsterdam Centrum', 'Albert Heijn', 'Nieuwezijds Voorburgwal 226', 'Amsterdam', '1012 RR', 52.3731, 4.8916),
  ('Albert Heijn Utrecht Centraal', 'Albert Heijn', 'Stationshal 7A', 'Utrecht', '3511 CE', 52.0907, 5.1106),
  ('Jumbo Rotterdam Centrum', 'Jumbo', 'Meent 111', 'Rotterdam', '3011 JG', 51.9244, 4.4777),
  ('Jumbo Den Haag Centrum', 'Jumbo', 'Turfmarkt 200', 'Den Haag', '2511 DP', 52.0769, 4.3096),
  ('Plus Amsterdam Zuid', 'Plus', 'Beethovenstraat 91', 'Amsterdam', '1077 HN', 52.3474, 4.8763),
  ('Plus Eindhoven', 'Plus', 'Woenselse Markt 21', 'Eindhoven', '5612 CP', 51.4507, 5.4801),
  ('Lidl Amsterdam Noord', 'Lidl', 'Mosveld 72', 'Amsterdam', '1032 KR', 52.3940, 4.9131),
  ('Lidl Rotterdam Zuid', 'Lidl', 'Zuidplein 452', 'Rotterdam', '3083 CW', 51.8818, 4.4885),
  ('ALDI Utrecht', 'ALDI', 'Kanaalstraat 119', 'Utrecht', '3531 CD', 52.0917, 5.1024),
  ('ALDI Den Haag', 'ALDI', 'Loosduinse Hoofdstraat 521', 'Den Haag', '2552 AD', 52.0530, 4.2353),
  ('Albert Heijn Groningen', 'Albert Heijn', 'Vismarkt 31', 'Groningen', '9711 KT', 53.2174, 6.5668),
  ('Jumbo Tilburg', 'Jumbo', 'Schouwburgring 90', 'Tilburg', '5038 TN', 51.5574, 5.0839),
  ('Plus Nijmegen', 'Plus', 'Molenstraat 96', 'Nijmegen', '6511 HN', 51.8458, 5.8645),
  ('Lidl Maastricht', 'Lidl', 'Brusselseweg 89', 'Maastricht', '6219 NZ', 50.8420, 5.7086);

-- Insert typical Dutch product suggestions
INSERT INTO product_suggestions (name, category, typical_price, unit) VALUES
  -- Brood & Gebak
  ('Volkoren brood', 'Brood & Gebak', 1.89, 'stuk'),
  ('Wit brood', 'Brood & Gebak', 1.49, 'stuk'),
  ('Croissants', 'Brood & Gebak', 2.49, '4 stuks'),
  ('Beschuit', 'Brood & Gebak', 1.19, 'pak'),
  
  -- Zuivel
  ('Melk halfvol', 'Zuivel', 1.29, 'liter'),
  ('Yoghurt naturel', 'Zuivel', 1.79, 'liter'),
  ('Kaas jong belegen', 'Zuivel', 4.99, '500g'),
  ('Boter', 'Zuivel', 2.49, '250g'),
  ('Karnemelk', 'Zuivel', 0.99, 'liter'),
  
  -- Groenten & Fruit
  ('Tomaten', 'Groenten & Fruit', 1.99, 'kg'),
  ('Bananen', 'Groenten & Fruit', 1.49, 'kg'),
  ('Appels', 'Groenten & Fruit', 2.49, 'kg'),
  ('Komkommer', 'Groenten & Fruit', 0.89, 'stuk'),
  ('Aardappelen', 'Groenten & Fruit', 2.99, '2.5kg'),
  ('Wortelen', 'Groenten & Fruit', 0.99, 'kg'),
  ('Ui', 'Groenten & Fruit', 1.29, 'kg'),
  ('Paprika', 'Groenten & Fruit', 1.99, 'stuk'),
  
  -- Vlees & Vis
  ('Kipfilet', 'Vlees & Vis', 7.99, 'kg'),
  ('Gehakt', 'Vlees & Vis', 4.99, '500g'),
  ('Rookworst', 'Vlees & Vis', 2.49, 'stuk'),
  ('Zalm', 'Vlees & Vis', 4.99, '200g'),
  ('Biefstuk', 'Vlees & Vis', 5.99, '200g'),
  
  -- Pasta & Rijst
  ('Spaghetti', 'Pasta & Rijst', 1.29, '500g'),
  ('Macaroni', 'Pasta & Rijst', 1.29, '500g'),
  ('Rijst', 'Pasta & Rijst', 1.99, 'kg'),
  ('Couscous', 'Pasta & Rijst', 1.79, '500g'),
  
  -- Conserven
  ('Tomatenpuree', 'Conserven', 0.59, 'blik'),
  ('Doperwten', 'Conserven', 1.29, 'pot'),
  ('Bruine bonen', 'Conserven', 1.19, 'pot'),
  ('Tonijn', 'Conserven', 1.89, 'blik'),
  
  -- Dranken
  ('Cola', 'Dranken', 1.49, '1.5L'),
  ('Sinaasappelsap', 'Dranken', 1.99, 'liter'),
  ('Koffie', 'Dranken', 3.99, '500g'),
  ('Thee', 'Dranken', 1.79, '20 zakjes'),
  ('Bier', 'Dranken', 12.99, 'krat'),
  
  -- Snacks & Snoep
  ('Chips paprika', 'Snacks & Snoep', 1.89, '200g'),
  ('Stroopwafels', 'Snacks & Snoep', 1.49, 'pak'),
  ('Drop', 'Snacks & Snoep', 1.29, 'zak'),
  ('Koekjes', 'Snacks & Snoep', 1.99, 'pak'),
  
  -- Huishouden
  ('Toiletpapier', 'Huishouden', 4.99, '8 rollen'),
  ('Keukenpapier', 'Huishouden', 2.99, '4 rollen'),
  ('Afwasmiddel', 'Huishouden', 1.49, 'fles'),
  ('Wasmiddel', 'Huishouden', 7.99, '2L'),
  ('Vuilniszakken', 'Huishouden', 2.49, '20 stuks'),
  
  -- Verzorging
  ('Shampoo', 'Verzorging', 2.99, 'fles'),
  ('Tandpasta', 'Verzorging', 1.99, 'tube'),
  ('Douchegel', 'Verzorging', 2.49, 'fles'),
  ('Deodorant', 'Verzorging', 2.99, 'stuk'),
  
  -- Diepvries
  ('Pizza margherita', 'Diepvries', 2.99, 'stuk'),
  ('IJsjes', 'Diepvries', 3.49, '6 stuks'),
  ('Frikandellen', 'Diepvries', 2.99, '20 stuks'),
  ('Spinazie', 'Diepvries', 1.29, '450g');