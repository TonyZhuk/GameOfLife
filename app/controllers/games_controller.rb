class GamesController < ApplicationController
  before_action :set_game, only: [:show, :edit, :update, :destroy]
  skip_before_action :verify_authenticity_token

  # GET /games
  # GET /games.json
  def index
    @lol = params[:active]
    game = Game.find(1)
    if params[:active] == "true"
      puts "TRUE:::!!!!!!!!!!!!!!" + game.current_gen.to_s
      gon.array = Game.next_step(game.current_gen)
      game.current_gen = Game.get_current_gen
      game.save
    elsif params[:active] == "false"
      gon.array = Game.reset_game
    else
      Game.generate_first_gen
      game.current_gen = Game.get_current_gen
      game.save
      gon.array = Game.to_view(game.current_gen)
    end
  end

  # GET /games/1
  # GET /games/1.json
  def show
    @lol = params[:active]
    game = Game.find(params[:id])
    if params[:active] == "true"
      puts "TRUE:::!!!!!!!!!!!!!!" + game.current_gen.to_s
      gon.array = Game.next_step(game.current_gen)
      game.current_gen = Game.get_current_gen
      game.save
    elsif params[:active] == "false"
      gon.array = Game.reset_game
    else
      puts "IN THE BEGINING!!!!" + game.current_gen.to_s
     Game.generate_first_gen_show(game.current_gen)
     # game.current_gen = Game.get_current_gen
      #game.save
      gon.array = Game.to_view(game.current_gen)
    end
  end

  # GET /games/new
  def new
    @game = Game.new
  end

  # GET /games/1/edit
  def edit
  end

  # POST /games
  # POST /games.json
  def create
    @game = Game.new(game_params)

    respond_to do |format|
      if @game.save
        format.html { redirect_to index, notice: 'Game was successfully created.' }
        format.json { render :show, status: :created, location: @game }
      else
        format.html { render :new }
        format.json { render json: @game.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /games/1
  # PATCH/PUT /games/1.json
  def update
    respond_to do |format|
      if @game.update(game_params)
        format.html { redirect_to @game, notice: 'Game was successfully updated.' }
        format.json { render :show, status: :ok, location: @game }
      else
        format.html { render :edit }
        format.json { render json: @game.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /games/1
  # DELETE /games/1.json
  def destroy
    @game.destroy
    respond_to do |format|
      format.html { redirect_to games_url, notice: 'Game was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_game
      @game = Game.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def game_params
      params[:game]
    end
end
