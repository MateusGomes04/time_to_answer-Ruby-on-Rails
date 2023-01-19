namespace :dev do

  default_password = 123456

  desc "Configures the development envrioment"
  task setup: :environment do
   
    if Rails.env.development?

    show_spinner("Droping Database...") {%x(rails db:drop)}

    show_spinner("Creating Database...") {%x(rails db:create)}

    show_spinner("Migrating Database...") {%x(rails db:migrate)}

    show_spinner("Registering the Default Administrator...") {%x(rails dev:add_default_admin)}

    show_spinner("Registering the Default User...") {%x(rails dev:add_default_user)}


    else
      puts "You are not in the development envrioment to run this!!"
    end
  end

  desc "Adiciona o administrador padrão"
  task add_default_admin: :environment do
    Admin.create!(
      email: 'admin@admin.com',
      password: default_password,
      password_confirmation: default_password
    )
  end

  desc "Adiciona o usuário padrão"
  task add_default_user: :environment do
    User.create!(
       email: 'user@user.com',
       password: default_password,
       password_confirmation: default_password
    )
 end

  private
    def show_spinner(msg_start)
      spinner = TTY::Spinner.new("[:spinner] #{msg_start}")
      spinner.auto_spin
      yield
      spinner.success('(task completed!)')
    end

end