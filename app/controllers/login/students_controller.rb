class Login::StudentsController < Login::ApplicationController
  before_action :set_student, only: [:edit, :update, :show, :destroy]

  def new
    @student = current_user.build_student
  end

  def show
  end

  def create
    @student = current_user.build_student(student_params)
    if @student.save
      redirect_to login_student_path(@student)
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @student.update(student_params)
      redirect_to login_student_path(@student)
    else
      render 'edit'
    end
  end

  def destroy
    @student.destroy
    redirect_to root_path
  end

  private

  def set_student
    @student = current_user.student
  end

  def student_params
    params[:student].permit(
      :name,
      :age,
      :primary_language,
      :description,
      :image
    )
  end

end