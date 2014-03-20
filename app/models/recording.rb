class Recording < ActiveRecord::Base
  def self.experiments()
    self.select(:experiment).distinct.collect{ |experiment|
      if experiment.experiment.nil?
        "Unidentified"
      else
        experiment.experiment
      end
    }
  end

  def self.experiment_sessions(experiment)
    if experiment == "Unidentified"
      self.where("experiment is null").select(:session).distinct.collect{ |session| session.session }
    else
      self.where(["experiment = ?", experiment]).select(:session).distinct.collect{ |session| session.session }
    end
  end

  def self.experiment_session_recordings(experiment, session)
    if experiment == "Unidentified"
      self.where(["experiment is null and session = ?", session]).order("updated_at")
    else
      self.where(["experiment = ? and session = ?", experiment, session]).order("updated_at")
    end

  end

end
