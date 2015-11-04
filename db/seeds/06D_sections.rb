puts "> Creating sections........"



Section.create!([
  {title: "Food", type: "Food", offer_id: 5, min_capacity: nil, max_capacity: nil, description: "", rank: 1, image_id: nil},
  {title: "Drinks", type: "Drink", offer_id: 5, min_capacity: nil, max_capacity: nil, description: "", rank: 2, image_id: nil},
  {title: "Les services", type: "Stuff", offer_id: 5, min_capacity: nil, max_capacity: nil, description: "", rank: 3, image_id: nil},
  {title: "La secret du room du Badaboum", type: "Place", offer_id: 2, min_capacity: nil, max_capacity: nil, description: "<div>Au premier étage du Badaboum découvrez un appartement pensé comme une garçonnière des années 70. Chambre d’adolescent sous les combles ou repaire d’un séducteur des années « Palace » la Secret Room est l’espace idéal pour se retrouver entre amis !</div><div><br></div><div>Trois formules au choix / Fête comme chez vous !</div><div>Inclus dans ces formules : un barman, un maître d'hôtel et un agent de sécu.<br></div>", rank: nil, image_id: nil},
  {title: "Un hot dog stand bien dressé", type: "Food", offer_id: 1, min_capacity: nil, max_capacity: nil, description: "Pour un devis minimum de 605 euros.&nbsp;<br>", rank: nil, image_id: "57ee59a8cc71e65ba0f664347b7674045d5495a6e27e3a258f418a944672"},
  {title: "Food", type: "Food", offer_id: 6, min_capacity: nil, max_capacity: nil, description: "<div>Cocktail en équivalence de 22 pièces, composé comme suit :</div><ul><li>Pièces salées</li><li>1 mini plat chaud (équivalence de 4 pièces),</li><li>Pièces sucrées.</li></ul>", rank: nil, image_id: nil},
  {title: "Un loft d'artiste inside and out", type: "Place", offer_id: 3, min_capacity: nil, max_capacity: nil, description: "<div>A votre disposition, le salon avec sa cuisine américaine de 60 m2 ainsi que sa terrasse de 60 m2 également jusqu'à 22h. Un espace vestiaire peut-être créé dans une pièce annexe. Vous pouvez apporter votre propre nourriture et vos propres boissons. Alors, intéressé ? Le loft se privatise sur une base de 8h de location entre 8h et 2h du matin. Merci d'indiquer les horaires souhaités dans le champs ci-dessous.</div><div><br>Une idée de combien vous serez ?<br></div>", rank: nil, image_id: nil},
  {title: "Les plateaux gourmands", type: "Food", offer_id: 4, min_capacity: nil, max_capacity: nil, description: "<div>Pièces de cocktails dressées sur plateaux noirs textura.</div><div>Tarifs par plateau.&nbsp;<br></div>", rank: nil, image_id: nil}
])

Drink.create!([
  {title: "Drinks", type: "Drink", offer_id: 5, min_capacity: nil, max_capacity: nil, description: "", rank: 2, image_id: nil}
])
Food.create!([
  {title: "Food", type: "Food", offer_id: 5, min_capacity: nil, max_capacity: nil, description: "", rank: 1, image_id: nil},
  {title: "Un hot dog stand bien dressé", type: "Food", offer_id: 1, min_capacity: nil, max_capacity: nil, description: "Pour un devis minimum de 605 euros.&nbsp;<br>", rank: nil, image_id: "57ee59a8cc71e65ba0f664347b7674045d5495a6e27e3a258f418a944672"},
  {title: "Les plateaux gourmands", type: "Food", offer_id: 4, min_capacity: nil, max_capacity: nil, description: "<div>Pièces de cocktails dressées sur plateaux noirs textura.</div><div>Tarifs par plateau.&nbsp;<br></div>", rank: nil, image_id: nil},
  {title: "Food", type: "Food", offer_id: 6, min_capacity: nil, max_capacity: nil, description: "<div>Cocktail en équivalence de 22 pièces, composé comme suit :</div><ul><li>Pièces salées</li><li>1 mini plat chaud (équivalence de 4 pièces),</li><li>Pièces sucrées.</li></ul>", rank: nil, image_id: nil}
])
Place.create!([
  {title: "Un loft d'artiste inside and out", type: "Place", offer_id: 3, min_capacity: nil, max_capacity: nil, description: "<div>A votre disposition, le salon avec sa cuisine américaine de 60 m2 ainsi que sa terrasse de 60 m2 également jusqu'à 22h. Un espace vestiaire peut-être créé dans une pièce annexe. Vous pouvez apporter votre propre nourriture et vos propres boissons. Alors, intéressé ? Le loft se privatise sur une base de 8h de location entre 8h et 2h du matin. Merci d'indiquer les horaires souhaités dans le champs ci-dessous.</div><div><br>Une idée de combien vous serez ?<br></div>", rank: nil, image_id: nil},
  {title: "La secret du room du Badaboum", type: "Place", offer_id: 2, min_capacity: nil, max_capacity: nil, description: "<div>Au premier étage du Badaboum découvrez un appartement pensé comme une garçonnière des années 70. Chambre d’adolescent sous les combles ou repaire d’un séducteur des années « Palace » la Secret Room est l’espace idéal pour se retrouver entre amis !</div><div><br></div><div>Trois formules au choix / Fête comme chez vous !</div><div>Inclus dans ces formules : un barman, un maître d'hôtel et un agent de sécu.<br></div>", rank: nil, image_id: nil}
])
Stuff.create!([
  {title: "Les services", type: "Stuff", offer_id: 5, min_capacity: nil, max_capacity: nil, description: "", rank: 3, image_id: nil}
])



puts "Sections saved!"