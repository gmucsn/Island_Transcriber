class RecorderController < ApplicationController
  protect_from_forgery except: :record
  def record
    render_text = "Boo"
    if params[:secret_key] == "KbBkRJnR"
      new_recording = Recording.new()
      new_recording.experiment = params[:experiment]
      new_recording.session = params[:session]
      if request.raw_post.strip != ""
        new_recording.parameters = request.raw_post.strip
      else
        new_recording.parameters = params.to_yaml
      end
      new_recording.save
      render_text = "OK"
    end
    render :text => render_text
  end

  def poll_record
    if params[:secret_key] == "KbBkRJnR"
      new_recording = Recording.new()
      new_recording.session = params[:session]
      uri = URI.parse('http://gmu.metaverseworlds.com:9000/lslhttp/62fc886b-a479-47b9-b064-3b6b14a26fdf/')
      http = Net::HTTP.new(uri.host, uri.port)
      request = Net::HTTP::Post.new(uri.request_uri)
      request.set_form_data({"email_login" => "user@email.com", "password_login" => "password"})
      response = http.request(request)
      uri = URI.parse('http://gmu.metaverseworlds.com:9000/lslhttp/5af276ce-f984-4466-8082-618b948e8abb/')
      http = Net::HTTP.new(uri.host, uri.port)
      request = Net::HTTP::Post.new(uri.request_uri)
      request.set_form_data({"password_login" => "NOPE"})
      response = http.request(request)
    end
  end

end
