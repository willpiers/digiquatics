class ParticipantsController < ApplicationController
  before_action :set_participant, only: [:show, :edit, :update, :destroy]

  def show
  end

  def new
    @participant = Participant.new
  end

  def edit
  end

  def create
    @participant = Participant.new(participant_params)

    if @participant.save
      redirect_to @participant,
                  notice: 'Participant was successfully created.'
    else
      render action: 'new'
    end
  end

  def update
    if @participant.update(participant_params)
      redirect_to @participant,
                  notice: 'Participant was successfully updated.'
    else
      render action: 'edit'
    end
  end

  def destroy
    @participant.destroy
    redirect_to participants_url
  end

  private

  def set_participant
    @participant = participant.find(params[:id])
  end

  def participant_params
    params.require(:participant)
    .permit(:private_lesson_id, :first_name, :last_name, :sex, :age)
  end
end
