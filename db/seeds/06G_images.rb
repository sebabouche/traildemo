puts "> Creating images........"



Image.create!([
  {imageable_id: 1, imageable_type: "Offer", priority: nil, file_id: "2d9e65792adb12228efd09569eae379f759a98d84e7990d18992e6f90fc8"},
  {imageable_id: 2, imageable_type: "Offer", priority: nil, file_id: "370c1f0193e0b77d866242741c35f1a9e58e9cd57687560834dcf9bc5261"},
  {imageable_id: 3, imageable_type: "Offer", priority: nil, file_id: "b9feaedebb8244ad3c4d89fd7a6979d9bd9f5c017d419eae40a1c1ea1a9c"},
  {imageable_id: 3, imageable_type: "Offer", priority: nil, file_id: "82976f861e52d097c164b3c1264e5fc80f398c8c39c2ba6b9a08e8f5c5d5"}
])



puts "Images saved!"