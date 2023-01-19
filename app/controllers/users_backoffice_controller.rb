class UsersBackofficeController < ApplicationController
    UsersBackofficeController
    before_action :authenticate_user!
    layout 'users_backoffice'
end
