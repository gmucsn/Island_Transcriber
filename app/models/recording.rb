class Recording < ActiveRecord::Base

  def self.find_unique_sessions
    return self.find_by_sql("select session, max(updated_at) as last_time from recordings group by session order by max(updated_at) desc")  
  end

  def self.find_session(session_name)
    return self.find_by_sql(["select * from recordings where session = ? order by updated_at", session_name])  
  end

end
