class VisualizeController < ApplicationController
  before_filter :init_settings

  def index
    session[:show_grid] = params[:show_grid] if params[:show_grid].present?
    session[:text_to_render] = params[:text] if params[:text].present?
    session[:calculation] = params[:calculation] if params[:calculation].present?
    @show_grid = session[:show_grid]
    @text_to_render = session[:text_to_render] || "Dies ist ein Standard Text" 
    @calculation = session[:calculation] || "char"
    @max_cubes_per_line = 0
    @lines = []
    @text_to_render.lines.each do |line|
      @max_cubes_per_line = line.length if line.length > @max_cubes_per_line
      @lines << line.split("").map{|a| {:count => @text_to_render.count(a), :char => a }}
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
