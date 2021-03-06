class PlansController < ApplicationController
  before_action :set_plan, only: [:show, :edit, :update, :destroy]

  # GET /plans
  # GET /plans.json
  def index
    @plans = Plan.all
    @list = current_user.lists.first.id
  end

  # GET /plans/1
  # GET /plans/1.json
  def show

  end

  # GET /plans/new
  def new
    @plan = Plan.new
    @list = current_user.lists.first.id
  end

  # GET /plans/1/edit
  def edit
  end

  # POST /plans
  # POST /plans.json
  def create
    @plan = Plan.new(plan_params)
    @plan.user_id = current_user.id
    @plan.list_id = current_user.lists.first.id

    respond_to do |format|
      if @plan.save
        format.html { redirect_to :back }
        format.json { render :show, status: :created, location: @plan }
      else
        format.html { redirect_to :back, notice: 'Cannot have empty entry' }
        format.json { render json: @plan.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /plans/1
  # PATCH/PUT /plans/1.json
  def update
    respond_to do |format|
      if @plan.update(plan_params)
        format.html { redirect_to @plan, notice: 'Plan was successfully updated.' }
        format.json { render :show, status: :ok, location: @plan }
      else
        format.html { render :edit }
        format.json { render json: @plan.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /plans/1
  # DELETE /plans/1.json
  def destroy
    @plan.destroy
    respond_to do |format|
      format.html { redirect_to plans_url, notice: 'Plan was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def completed
    @plan = Plan.find(params[:id])
    @plan.update(completion: true)
    redirect_to :back
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_plan
      @plan = Plan.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def plan_params
      params.require(:plan).permit(:title, :user_id, :list_id, :completion, :hours, :type_of_study)
    end
end
