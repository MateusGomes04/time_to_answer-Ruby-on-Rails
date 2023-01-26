class AdminsBackoffice::SubjectsController < AdminsBackofficeController
    before_action :set_subject, only: [:edit, :update, :destroy]
    def index
      @subjects = Subject.all.page(params[:page])
    end
  
    def new
       @subject = Subject.new
    end
  
    def create
      @subject = Subject.new(params_subject)
      if @subject.save
        redirect_to admins_backoffice_subjects_path, notice: "Administrador cadastrado com sucesso!"
      else
        render :new
      end
    end
    def edit
     @subject = Subject.find(params[:id])
    end
    def update
      if params[:subject][:password].blank? && params[:subject][:password_confirmation].blank?
        params[:subject].extract!(:password, :password_confirmation)
      end  
  
      @subject = Subject.find(params[:id])
      params_subject = params.require(:subject).permit(:email, :password, :password_confirmation)
  
      if @subject.update(params_subject)
        redirect_to admins_backoffice_subjects_path, notice: "assunto/area atualizado com sucesso!"
      else
        render :edit
    end
  end
  
  def destroy
    if @subject.destroy
      redirect_to admins_backoffice_subjects_path, notice: "assunto/area apagado com sucesso!"
    else
      render :index
    end
  end
  private
    def params_subject
      params.require(:subject).permit(:description)
    end
    def set_subject
      @subject = Subject.find(params[:id])
    end
  end