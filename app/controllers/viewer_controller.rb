class ViewerController < ApplicationController
  def index
    redirect_to :action => "view_most_recent"
  end

  def view_most_recent
    @recordings = Recording.order("updated_at desc").first(50)
  end

end
