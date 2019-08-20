class PeopleController < ApplicationController
  before_action :set_person, only: [:show, :destroy, :edit, :update]
  before_action :set_fullpage, only: [:index]

  def index
    @people = Person.all
  end

  def show
  end

  def destroy
    @person.destroy
    redirect_to people_url, notice: 'Person was successfully destroyed.'
  end

  def edit
  end

  def update
    if @person.update(person_params)
      redirect_to @person, notice: 'Person was successfully updated.'
    else
      render :edit
    end
  end

  def new
    @person = Person.new
  end

  def create
    @person = Person.new(person_params)
    if @person.save
      redirect_to @person, notice: 'Person was successfully created.'
    else
      render :new
    end
  end

  private

  def set_person
    @person = Person.find(params[:id])
  end

  def person_params
    params.require(:person).permit(:first_name, :last_name, :aliases)
  end
end
