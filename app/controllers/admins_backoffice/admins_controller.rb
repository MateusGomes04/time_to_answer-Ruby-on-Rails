class AdminsBackoffice::AdminsController < AdminsBackofficeController
  def index
    @admins = Admin.all
  end

  def new
     @admin = Admin.new
  end

  def create
    @admin = Admin.new(params_admin)
    if @admin.save
      redirect_to admins_backoffice_admins_path, notice: "Administrador cadastrado com sucesso!"
    else
      render :new
    end
  end
  def edit
   @admin = Admin.find(params[:id])
  end
  def update
    if params[:admin][:password].blank? && params[:admin][:password_confirmation].blank?
      params[:admin].extract!(:password, :password_confirmation)
    end  

    @admin = Admin.find(params[:id])
    params_admin = params.require(:admin).permit(:email, :password, :password_confirmation)

    if @admin.update(params_admin)
      redirect_to admins_backoffice_admins_path, notice: "Administrador atualizado com sucesso!"
    else
      render :edit
  end
end
private
  def params_admin
    params.require(:admin).permit(:email, :password, :password_confirmation)
  end
  def set_admin
    @admin = Admin.find(params[:id])
  end
  def verify_password
    if params[:admin][:password].blank? && params[:admin][:password_confirmation].blank?
      params[:admin].extract!(:password, :password_confirmation)
    end
  end
end