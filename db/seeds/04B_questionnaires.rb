puts "> Creating questionnaires........"




Questionnaire.create!([
  {title: "Questionnaire Happhapp number uno", description: "", published: nil}
])
QuestionnaireQuestion.create!([
  {questionnaire_id: 1, question_id: 2, rank: nil},
  {questionnaire_id: 1, question_id: 1, rank: nil},
  {questionnaire_id: 1, question_id: 4, rank: nil},
  {questionnaire_id: 1, question_id: 5, rank: nil},
  {questionnaire_id: 1, question_id: 3, rank: nil},
  {questionnaire_id: 1, question_id: 8, rank: nil},
  {questionnaire_id: 1, question_id: 9, rank: nil},
  {questionnaire_id: 1, question_id: 6, rank: nil},
  {questionnaire_id: 1, question_id: 4, rank: nil}
])



puts "Questionnaires saved!"