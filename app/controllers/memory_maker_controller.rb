class MemoryMakerController < ApplicationController
  def store_memory
    
    @memory = Memory.new()
    @memory.memory_key = params[:memory_key]
    @memory.memory_val= params[:memory_val]
    @memory.save
    render_text = "OK"
    render :text => render_text
  end

  def retrieve_memory
    @memory_key = params[:memory_key]
    @memory = Memory.find(:first, :conditions => ["memory_key = ?", @memory_key])
    render :text => @memory.memory_val
  end

end
