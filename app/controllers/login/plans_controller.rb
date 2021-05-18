class Login::PlansController < Login::ApplicationController
  before_action :set_plan, except: [:index, :new, :create, :export, :suggest]

  def index
    @q = current_user.plans.by_date.ransack(params[:q])
    @plans = @q.result(distinct: true)
  end

  def show
  end


  def new
    @plan = current_user.plans.build
  end

  def create
    @plan = current_user.plans.build(plan_params)
    if @plan.save
      NotificationMailer.notification_mail(@plan, current_user).deliver
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

  def export
    @plans = current_user.plans.ended
    @plan_export = PlanExport.new
    respond_to do |format|
      format.csv do
        render_csv
      end
    end
  end

  def suggest
    @plans = current_user.plans.where('title LIKE(?)', "%#{params[:title]}%")
    respond_to do |format|
      format.json { render json: @plans }
    end
  end

  private

  def set_plan
    @plan = current_user.plans.find(params[:id])
  end

  def plan_params
    params[:plan].permit(:title, :study_aid, :plan_detail, :plan_goal, :status,
      :feedback_comment, :start_at, :end_at)
  end

  def render_csv
    set_file_headers
    set_streaming_headers
    response.status = 200
    self.response_body = @plan_export.csv_rows(@plans)
  end

  def set_file_headers
    headers["Content-Type"] = "text/csv"
    headers["Content-disposition"] = "attachment; filename=\"#{@plan_export.filename}\""
  end

  def set_streaming_headers
    #nginx doc: Setting this to "no" will allow unbuffered responses suitable for Comet and HTTP streaming applications
    headers['X-Accel-Buffering'] = 'no'
    headers["Cache-Control"] ||= "no-cache"
    headers.delete("Content-Length")
  end

end
