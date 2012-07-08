class VisualizeController < ApplicationController
  before_filter :init_settings

  def index
    session[:text_to_render] = params[:text] if params[:text].present?
    @text_to_render = session[:text_to_render] || "Dies ist ein Standard Text" 
    @max_cubes_per_line = 0
    @lines = []
    @text_to_render.lines.each do |line|
      @max_cubes_per_line = line.length if line.length > @max_cubes_per_line
      @lines << line.split("")
    end
    puts @lines.inspect
  end


  private
  def init_settings
    @cube_size = Setting.for_key("cube_size", 50).to_i
    @cube_padding = Setting.for_key("cube_padding", 10).to_i
    @inner_width = Setting.for_key("inner_width", 800).to_i
    @inner_height = Setting.for_key("inner_height", 500).to_i
  end

end
