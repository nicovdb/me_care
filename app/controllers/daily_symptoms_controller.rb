class DailySymptomsController < ApplicationController
  def index
    @daily_symptoms = policy_scope(DailySymptom)
    define_table
  end

  def new
    raise
  end

  def show
  end

  private

  def define_table
    if params[:month].present?
      base_day = params[:month].to_date
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
end
