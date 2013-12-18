class ViewerController < ApplicationController

  def viewer
    @recordings = Recording.find(:all, :order => "updated_at desc", :limit => 25)
    
  end

  def view_sessions
    @recordings = Recording.find_unique_sessions    
  end

  def view_session
    @session_lines = Recording.find_session(params[:id])
    @session_name = @session_lines[0].session
    @last_recorded = @session_lines[-1].updated_at
  end

  def get_session_csv
    
  end

end
