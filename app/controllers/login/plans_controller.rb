class Login::PlansController < Login::ApplicationController
  before_action :set_plan, except: [:index, :new, :create]

  def index
    @plans = current_user.plans.by_date
  end

  def show
  end


  def new
    @plan = current_user.plans.build
  end

  def create
    @plan = current_user.plans.build(plan_params)
    if @plan.save
      redirect_to login_plans_path
    else
      render 'new'
    end
  end

  def edit
    render "edit_#{@plan.plan_status}"
  end

  def update
    if @plan.update(plan_params)
      redirect_to login_plans_path
    else
      render 'edit'
    end
  end

  def destroy
    @plan.destroy
    redirect_to login_plans_path
  end

  private

  def set_plan
    @plan = current_user.plans.find(params[:id])
  end

  def plan_params
    params[:plan].permit(:title, :study_aid, :plan_detail, :plan_goal, :status,
      :feedback_comment, :start_at, :end_at)
  end
end
