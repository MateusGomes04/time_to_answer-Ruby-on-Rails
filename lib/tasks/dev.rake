namespace :dev do

  DEFAULT_PASSWORD = 123456
  DEFAULT_FILES_PATH = File.join(Rails.root, 'lib', 'tmp')

  desc "Configures the development envrioment"
  task setup: :environment do
   
    if Rails.env.development?

    show_spinner("Droping Database...") {%x(rails db:drop)}

    show_spinner("Creating Database...") {%x(rails db:create)}

    show_spinner("Migrating Database...") {%x(rails db:migrate)}

    show_spinner("Registering the Default Administrator...") {%x(rails dev:add_default_admin)}

    show_spinner("Registering extra administrators") {%x(rails dev:add_extra_admins)}

    show_spinner("Registering the Default User...") {%x(rails dev:add_default_user)}

    show_spinner("Registering standard subjects...") {%x(rails dev:add_subjects) }

    show_spinner("Registering questions and answers...") {%x(rails dev:add_answers_and_questions) }


    else
      puts "You are not in the development envrioment to run this!!"
    end
  end

  desc "Adiciona o administrador padrão"
  task add_default_admin: :environment do
    Admin.create!(
      email: 'admin@admin.com',
      password: DEFAULT_PASSWORD,
      password_confirmation: DEFAULT_PASSWORD
    )
  end

  desc "adiciona administradores extras"
  task add_extra_admins: :environment do
    10.times do |i|
    Admin.create!(
      email: Faker::Internet.email,
      password: DEFAULT_PASSWORD,
      password_confirmation: DEFAULT_PASSWORD
    )
  end
end

  desc "Adiciona o usuário padrão"
  task add_default_user: :environment do
    User.create!(
       email: 'user@user.com',
       password: DEFAULT_PASSWORD,
       password_confirmation: DEFAULT_PASSWORD
    )
 end
 
 desc "Adiciona assuntos padrão"
 task add_subjects: :environment do
    file_name = 'subjects1.txt'
    file_path = File.join(DEFAULT_FILES_PATH, file_name)
    
    File.open(file_path, 'r').each do |line|
      Subject.create!(description: line.strip)
  end
end

desc "Adiciona perguntas e respostas"
task add_answers_and_questions: :environment do
  Subject.all.each do |subject|
    rand(5..10).times do |i|
    Question.create!(
      description: "#{Faker::Lorem.paragraph} #{Faker::Lorem.question}",
      subject: subject
    )
    end
  end
end
  private
    def show_spinner(msg_start)
      spinner = TTY::Spinner.new("[:spinner] #{msg_start}")
      spinner.auto_spin
      yield
      spinner.success('(task completed!)')
    end

end