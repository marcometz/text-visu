class VisualizeController < ApplicationController
  before_filter :init_settings

  def index
    session[:navigation_3d] = params[:navigation_3d] if params[:navigation_3d].present?
    session[:show_grid] = params[:show_grid] if params[:show_grid].present?
    session[:text_to_render] = params[:text] if params[:text].present?
    session[:calculation] = params[:calculation] if params[:calculation].present?
    @navigation_3d = session[:navigation_3d]
    @show_grid = session[:show_grid]
    @text_to_render = session[:text_to_render].to_s.downcase || "Dies ist ein Standard Text" 
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
