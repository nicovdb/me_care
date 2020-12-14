class DailySymptomsController < ApplicationController
  def index
    define_table
    @daily_symptoms = policy_scope(DailySymptom).where('day >= ?', @first_day_of_month).where('day <= ?', @last_day_of_month)
    define_agenda_data
  end

  def graph
    authorize :daily_symptom
    @daily_symptoms = policy_scope(DailySymptom)
    define_graph_data
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

  def define_agenda_data
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

  def define_graph_data
    # id"name", label"name", borderColor"#hex", data[array of values], suggestedMax 5 ou 10, stepSize 1 ou 2
    @pain_data = []
    @blood_data = []
    @digestive_trouble_data = []
    @stress_data = []
    @insomnia_data = []
    @sport_data = []

    if params[:base_period].present?
      if params[:base_period] == "month"
        monthly_graph_data
      elsif params[:base_period] == "week"
        weekly_graph_data
      elsif params[:base_period] == "trimester"
        trimester_graph_data
      elsif params[:base_period] == "year"
        year_graph_data
      else
        monthly_graph_data
      end
    else
      year_graph_data
    end

    @graphs = [
      {
        id: "painChart",
        labels: @labels,
        name: "Douleurs",
        img: "pain.svg",
        border_color: "#FDA55E",
        data: @pain_data,
        suggested_max: "10",
        step_size: "2"
      },
      {
        id: "bloodChart",
        labels: @labels,
        name: "Saignements",
        img: "blood.svg",
        border_color: "#DB9497",
        data: @blood_data,
        suggested_max: "5",
        step_size: "1"
      },
      {
        id: "digestiveTroubleChart",
        labels: @labels,
        name: "Troubles digestifs",
        img: "digestive_trouble.svg",
        border_color: "#8C97CF",
        data: @digestive_trouble_data,
        suggested_max: "5",
        step_size: "1"
      },
      {
        id: "stressChart",
        labels: @labels,
        name: "Stress",
        img: "stress.svg",
        border_color: "#B9B9B9",
        data: @stress_data,
        suggested_max: "5",
        step_size: "1"
      },
      {
        id: "insomniaChart",
        labels: @labels,
        name: "Insomnie",
        img: "insomnia.svg",
        border_color: "#FFF185",
        data: @insomnia_data,
        suggested_max: "5",
        step_size: "1"
      }
    ]
  end

  def weekly_graph_data
    @labels = ['Lu', 'Ma', 'Me', 'Je', 'Ve', 'Sa', 'Di']

    if params[:base_day].present?
      @monday = params[:base_day].to_date
    else
      @monday = Date.today - (Date.today.cwday - 1)
    end

    day = @monday
    7.times do
      daily_symptom = @daily_symptoms.find_by(day: day)
      if daily_symptom
        @pain_data << daily_symptom.pain_level
        @blood_data << daily_symptom.blood_level
        @digestive_trouble_data << daily_symptom.digestive_trouble_level
        @stress_data << daily_symptom.stress_level
        @insomnia_data << daily_symptom.insomnia_level
        @sport_data << daily_symptom.sport
      else
        @pain_data << 0
        @blood_data << 0
        @digestive_trouble_data << 0
        @stress_data << 0
        @insomnia_data << 0
        @sport_data << false
      end
      day += 1
    end
  end

  def trimester_graph_data
    if params[:base_day].present?
      base_day = params[:base_day].to_date
    else
      base_day = Date.today
    end

    @base_day = base_day.beginning_of_quarter
    month_first_day = @base_day
    @labels = []

    3.times do
      month_last_day = Date.new(month_first_day.year, month_first_day.month, -1)
      number_of_days_in_month = month_last_day.day.to_f

      month_daily_symptoms = @daily_symptoms.where('day >= ?', month_first_day).where('day <= ?', month_last_day)

      pain_total = month_daily_symptoms.map(&:pain_level)
      blood_total = month_daily_symptoms.map(&:blood_level)
      digestive_trouble_total = month_daily_symptoms.map(&:digestive_trouble_level)
      stress_total = month_daily_symptoms.map(&:stress_level)
      insomnia_total = month_daily_symptoms.map(&:blood_level)

      @pain_data << (pain_total.sum / number_of_days_in_month)
      @blood_data << (blood_total.sum / number_of_days_in_month)
      @digestive_trouble_data << (digestive_trouble_total.sum / number_of_days_in_month)
      @stress_data << (stress_total.sum / number_of_days_in_month)
      @insomnia_data << (insomnia_total.sum / number_of_days_in_month)

      @labels << l(month_first_day, format:"%B").capitalize
      month_first_day += 1.month
    end
  end

  def year_graph_data
    if params[:base_day].present?
      @base_day = params[:base_day].to_date
    else
      @base_day = Date.today
    end

    quarter_first_day = @base_day.beginning_of_year
    trimester = 1
    @labels = []

    4.times do
      quarter_last_day = Date.new(quarter_first_day.year, (quarter_first_day.month + 2), -1)
      number_of_days_in_quarter = (quarter_last_day - quarter_first_day).to_f

      quarter_daily_symptoms = @daily_symptoms.where('day >= ?', quarter_first_day).where('day <= ?', quarter_last_day)

      pain_total = quarter_daily_symptoms.map(&:pain_level)
      blood_total = quarter_daily_symptoms.map(&:blood_level)
      digestive_trouble_total = quarter_daily_symptoms.map(&:digestive_trouble_level)
      stress_total = quarter_daily_symptoms.map(&:stress_level)
      insomnia_total = quarter_daily_symptoms.map(&:blood_level)

      @pain_data << (pain_total.sum / number_of_days_in_quarter)
      @blood_data << (blood_total.sum / number_of_days_in_quarter)
      @digestive_trouble_data << (digestive_trouble_total.sum / number_of_days_in_quarter)
      @stress_data << (stress_total.sum / number_of_days_in_quarter)
      @insomnia_data << (insomnia_total.sum / number_of_days_in_quarter)

      @labels << "Trimestre #{trimester}"
      trimester += 1
      quarter_first_day += 3.month
    end
  end
end
