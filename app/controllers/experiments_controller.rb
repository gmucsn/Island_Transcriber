class ExperimentsController < ApplicationController
  def list_experiments
    @experiments = Recording.experiments()
  end

  def list_experiment_sessions
    @experiment = params[:experiment]
    @sessions = Recording.experiment_sessions(@experiment)
  end

  def list_experiment_session_recordings
    @experiment = params[:experiment]
    @session = params[:session]
    @recordings = Recording.experiment_session_recordings(@experiment, @session)
  end

  def download_session_csv
    @experiment = params[:experiment]
    @session = params[:session]
    @record_csv = Recording.experiment_session_recordings_csv(@experiment, @session)

    filename = "#{@experiment}-#{@session}-#{DateTime.now().strftime("%Y-%m-%d")}.csv"
    send_data @record_csv, :filename => filename
  end

end
