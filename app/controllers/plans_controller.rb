class PlansController < ApplicationController
  before_action :set_plan, except: [:index, :new, :create]

  def index
    @plans = Plan.all
  end

  def show
  end

  def new
    @plan = Plan.new
  end

  def create
    @plan = Plan.new(plan_params)
    if @plan.save
      redirect_to plans_path
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @plan.update(plan_params)
      redirect_to plans_path
    else
      render 'edit'
    end
  end

  def destroy
    @plan.destroy
    redirect_to plans_path
  end

  private

  def set_plan
      @plan = Plan.find(params[:id])
  end

  def plan_params
    params[:plan].permit(:title, :study_aid, :plan_detail, :plan_goal, :status,
      :feedback_comment, :start_at, :end_at)
  end
end
