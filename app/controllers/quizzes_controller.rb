class QuizzesController < ApplicationController
  before_action :set_quiz, only: [:show, :edit, :update, :destroy]
  before_action :confirm_login

  # GET /quizzes
  # GET /quizzes.json
  def index
    @quizzes = Quiz.all
  end

  # GET /quizzes/1
  # GET /quizzes/1.json
  def show
    response = QuizFormatter.new(params[:id]).call 
    quizzes = current_user.quizzes
    @quiz = quizzes.find(params[:id])
    respond_to do |format|
      format.html { @quiz }
      format.json { render json: response }
    end
  end

  # GET /quizzes/new
  def new
    @quiz = Quiz.new
  end

  # GET /quizzes/1/edit
  def edit
  end

  # POST /quizzes
  # POST /quizzes.json
  def create
    @quiz = Quiz.new(quiz_params)

    respond_to do |format|
      if @quiz.save
        format.html { redirect_to @quiz, notice: 'Quiz was successfully created.' }
        format.json { render :show, status: :created, location: @quiz }
      else
        format.html { render :new }
        format.json { render json: @quiz.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /quizzes/1
  # PATCH/PUT /quizzes/1.json
  def update
    respond_to do |format|
      if @quiz.update(quiz_params)
        format.html { redirect_to @quiz, notice: 'Quiz was successfully updated.' }
        format.json { render :show, status: :ok, location: @quiz }
      else
        format.html { render :edit }
        format.json { render json: @quiz.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /quizzes/1
  # DELETE /quizzes/1.json
  def destroy
    @quiz.destroy
    respond_to do |format|
      format.html { redirect_to quizzes_url, notice: 'Quiz was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_quiz
    @quiz ||= Quiz.find(params[:id])
  rescue ActiveRecord::RecordNotFound => e
    render json: { error: e.message }, status: 404
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def quiz_params
    params.require(:quiz).permit(:name)
  end

  def confirm_login
    unless current_user
      redirect_to root_path, alert: 'You must be logged in'
    end
  end
end

