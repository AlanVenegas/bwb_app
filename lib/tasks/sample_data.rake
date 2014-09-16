namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    User.create!(name: "Mr Example",
     email: "example@foobar.com",
     password: "foobar",
     password_confirmation: "foobar",
     admin: true)
    99.times do |n|
      name  = Faker::Name.name
      email = "example-#{n+1}@foobar.org"
      password  = "foobar"
      User.create!(name: name,
       email: email,
       password: password,
       password_confirmation: password)

    end
    users = User.all(limit: 6)
    50.times do
      title = Faker::Lorem.sentence
      content = Faker::Lorem.sentence(5)
      users.each { |user| user.questions.create!(title: title, content: content) }
    end

    questions = Question.all(limit: 80)
    3.times do
      content = Faker::Lorem.sentence(5)
      questions.each { |question| question.answers.create!(content: content, question_id: question, user_id: question.user_id)}
    end

  end
end
