puts "> Creating prices........"


Price.create!([
  {item_id: 2, price_cents: 5000, price_pro_cents: 6000, quantify: false, unit: "installation du stand", optional: false, days: [1, 1, 1, 1, 1, 1, 1]},
  {item_id: 2, price_cents: 600, price_pro_cents: 600, quantify: false, unit: "1 hot dog", optional: true, days: [1, 1, 1, 1, 1, 1, 1]},
  {item_id: 6, price_cents: 85000, price_pro_cents: 105000, quantify: false, unit: "8h de location", optional: true, days: [1, 1, 1, 1, 1, 1, 1]},
  {item_id: 7, price_cents: 102500, price_pro_cents: 122500, quantify: false, unit: "8h de location", optional: true, days: [1, 1, 1, 1, 1, 1, 1]},
  {item_id: 8, price_cents: 4800, price_pro_cents: 4800, quantify: true, unit: "1 plateau", optional: true, days: [1, 1, 1, 1, 1, 1, 1]},
  {item_id: 9, price_cents: 5700, price_pro_cents: 5700, quantify: true, unit: "1 plateau", optional: true, days: [1, 1, 1, 1, 1, 1, 1]},
  {item_id: 10, price_cents: 8200, price_pro_cents: 8200, quantify: true, unit: "1 plateau", optional: true, days: [1, 1, 1, 1, 1, 1, 1]},
  {item_id: 11, price_cents: 8100, price_pro_cents: 8100, quantify: true, unit: "1 plateau", optional: true, days: [1, 1, 1, 1, 1, 1, 1]},
  {item_id: 12, price_cents: 8200, price_pro_cents: 8200, quantify: true, unit: "1 plateau", optional: true, days: [1, 1, 1, 1, 1, 1, 1]},
  {item_id: 13, price_cents: 2700, price_pro_cents: 2700, quantify: false, unit: "la livraison", optional: true, days: [1, 1, 1, 1, 1, 1, 1]},
  {item_id: 4, price_cents: 72000, price_pro_cents: 72000, quantify: false, unit: "la soirée", optional: true, days: [1, 1, 1, 0, 0, 0, 1]},
  {item_id: 4, price_cents: 120000, price_pro_cents: 120000, quantify: false, unit: "la soirée", optional: true, days: [0, 0, 0, 0, 1, 1, 0]},
  {item_id: 4, price_cents: 96000, price_pro_cents: 96000, quantify: false, unit: "la soirée", optional: true, days: [0, 0, 0, 1, 0, 0, 0]},
  {item_id: 5, price_cents: 3600, price_pro_cents: 3600, quantify: true, unit: "par personne", optional: true, days: [1, 1, 1, 0, 0, 0, 1]},
  {item_id: 5, price_cents: 4800, price_pro_cents: 4800, quantify: true, unit: "par personne", optional: true, days: [0, 0, 0, 1, 0, 0, 0]},
  {item_id: 5, price_cents: 6000, price_pro_cents: 6000, quantify: true, unit: "par personne", optional: true, days: [0, 0, 0, 0, 1, 1, 0]},
  {item_id: 3, price_cents: 24000, price_pro_cents: 24000, quantify: true, unit: "1 heure", optional: true, days: [1, 1, 1, 0, 0, 0, 1]},
  {item_id: 3, price_cents: 36000, price_pro_cents: 36000, quantify: true, unit: "1 heure", optional: true, days: [0, 0, 0, 1, 0, 0, 0]},
  {item_id: 3, price_cents: 48000, price_pro_cents: 48000, quantify: true, unit: "1 heure", optional: true, days: [0, 0, 0, 0, 1, 1, 0]},
  {item_id: 1, price_cents: 200, price_pro_cents: 200, quantify: true, unit: "1 cookie", optional: true, days: [1, 1, 1, 1, 1, 1, 1]},
  {item_id: 14, price_cents: 8100, price_pro_cents: 8100, quantify: true, unit: "par personne", optional: true, days: [1, 1, 1, 1, 1, 1, 1]},
  {item_id: 18, price_cents: 7400, price_pro_cents: 7400, quantify: true, unit: "par personne", optional: true, days: [1, 1, 1, 1, 1, 1, 1]}
])



DiscountPrice.create!([
  {price_id: 22, price_cents: 7000, price_pro_cents: 7000, starting: 100},
  {price_id: 23, price_cents: 6300, price_pro_cents: 6300, starting: 100}
])




puts "Prices saved!"