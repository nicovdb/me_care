class DailySymptomsController < ApplicationController
  def index
    define_table
    @daily_symptoms = policy_scope(DailySymptom).where('day >= ?', @first_day_of_month).where('day <= ?', @last_day_of_month)
    define_data
  end

  def new
    @daily_symptom = DailySymptom.new
    @day = params[:day].to_date
    authorize @daily_symptom
    manage_edit_new_next_prev_day
  end

  def create
    @daily_symptom = DailySymptom.new(daily_symptom_params)
    @daily_symptom.user = current_user
    authorize @daily_symptom
    if @daily_symptom.save
      redirect_to daily_symptoms_path
    else
      @day = @daily_symptom.day
      render :new
    end
  end

  def edit
    @daily_symptom = DailySymptom.find(params[:id])
    @day = @daily_symptom.day
    authorize @daily_symptom
    manage_edit_new_next_prev_day
  end

  def update
    @daily_symptom = DailySymptom.find(params[:id])
    authorize @daily_symptom
    if @daily_symptom.update(daily_symptom_params)
      redirect_to daily_symptoms_path
    else
      @day = @daily_symptom.day
      render :edit
    end
  end

  def show
  end

  private

  def manage_edit_new_next_prev_day
    @edit_prev_day = current_user.daily_symptoms.where(day: @day.prev_day).any?
    @previous_daily_symptom = current_user.daily_symptoms.find_by(day: @day.prev_day)
    @edit_next_day = current_user.daily_symptoms.where(day: @day.next_day).any?
    @next_daily_symptom = current_user.daily_symptoms.find_by(day: @day.next_day)
  end

  def define_table
    if params[:base_day].present?
      base_day = params[:base_day].to_date
    else
      base_day = Date.today
    end
    year = base_day.year
    month = base_day.month

    @first_day_of_month = Date.new(year, month, 1)
    @last_day_of_month = Date.new(year, month, -1)

    @first_day_number = @first_day_of_month.cwday
    @last_day_number = @last_day_of_month.cwday

    @start_empty_cells = @first_day_number - 1
    @end_empty_cells = 7 - @last_day_number

    @number_of_days_in_month = @last_day_of_month.day
  end

  def daily_symptom_params
    params.require(:daily_symptom).permit(:pain_level, :blood_level, :digestive_trouble_level, :stress_level, :insomnia_level, :sport, :emergency, :analgesic, :notes, :day)
  end

  def define_data
    day = @first_day_of_month
    @data = []

    @number_of_days_in_month.times do
      daily_symptom = @daily_symptoms.find_by(day: day)
      if daily_symptom
        @data << { day: day, daily_symptom: daily_symptom.id, symptoms: daily_symptom.symptoms_name_and_color }
      else
        @data << { day: day, daily_symptom: nil, symptoms: nil }
      end
      day += 1
    end
  end
end
