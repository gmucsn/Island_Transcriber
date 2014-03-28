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

  def self.experiment_session_recordings_csv(experiment, session)
    data = nil
    if experiment == "Unidentified"
      data = self.where(["experiment is null and session = ?", session]).order("updated_at")
    else
      data = self.where(["experiment = ? and session = ?", experiment, session]).order("updated_at")
    end

    # now prepare the csv file
    file_string = ""
    header = "time,data\n"
    file_string << header

    data.each {|row|
      line_string = row.updated_at.to_s + "," + row.parameters + "\n"
      file_string << line_string
    }
    return file_string
  end

end
