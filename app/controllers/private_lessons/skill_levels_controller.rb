class SkillLevelsController < ApplicationController
  before_action :set_skill_level, only: [:show, :edit, :update, :destroy]

  def index
    @skill_levels = SkillLevel.same_account_as(current_user)
  end

  def show
  end

  def new
    @skill_level = SkillLevel.new
  end

  def edit
  end

  def create
    @skill_level = SkillLevel.new(skill_level_params)
    @skill_level.account_id = current_user.account_id

    if @skill_level.save
      flash[:success] = 'Skill Level was successfully created.'
      redirect_to admin_dashboard_path
    else
      render 'new'
    end
  end

  def update
    if @skill_level.update(skill_level_params)
      flash[:info] = 'Skill Level was successfully updated.'
      redirect_to admin_dashboard_path
    else
      render 'edit'
    end
  end

  def destroy
    @skill_level.destroy
    redirect_to admin_dashboard_path
    flash[:error] = 'Skill Level was successfully deleted.'
  end

  private

  def set_skill_level
    @skill_level = SkillLevel.find(params[:id])
  end

  def skill_level_params
    params.require(:skill_level).permit(:name)
  end
end
