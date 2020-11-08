class GamesController < ApplicationController


  def new
    @game = Game.new
  end

  def create
    @game = Game.new
    case params[:field_size]
    when '5x6'
      @game.y = 6
      @game.x = 5
    when '6x6'
      @game.y = 6
      @game.x = 6
    else
      @game.y = 5
      @game.x = 5
    end
    length = @game.y * @game.x
    @game.words = @game.all_words.sample(length).to_json
    if params[:teams].to_i == 3
      @game.teams = 3
      Rails.logger.debug length/4 + 1
      Rails.logger.debug length/4
      Rails.logger.debug length/4 - 1
      players = ['red', 'blue', 'green'].shuffle!
      results = [players[0]] * (length/4 + 1)
      results += [players[1]] * (length/4)
      results += [players[2]] * (length/4 - 1)
      results += ['black']
      results += ['white'] * (length - 3*(length/4) - 1)
      Rails.logger.debug results
    else
      @game.teams = 2
      players = ['red', 'blue'].shuffle!
      results = [players[0]] * (length/3 + 1)
      results += [players[1]] * (length/3)
      results += ['black']
      results += ['white'] * (length - 2*(length/3) - 2)
    end
    Rails.logger.debug 'RESULTS'
    Rails.logger.debug results.length
    results.shuffle!
    @game.results = results.to_json
    @game.save
    respond_to do |format|
      format.html { redirect_to @game }
    end
  end

  def show
    @game = Game.find(params[:id])
  end

  def field
    @game = Game.find(params[:id])
    @viewer = params[:viewer]
    Rails.logger.debug @viewer
    respond_to do |format|
      format.html { render "games/field" }
      format.json do
        @uwords = @game.uwords
        @uresults = @game.uresults
        Rails.logger.debug @uresults
        if @viewer == 'player'
          @uresults_player = @uresults.collect do |result|
            ['red', 'blue', 'green', 'black', 'white'].include?(result) ? 'white' : result
          end
        end
        render 'results'
      end
    end
  end

  def update
    @game = Game.find(params[:id])
    @viewer = params[:viewer]
    word = params[:word]
    @uwords = @game.uwords
    idx = @uwords.index(word)
    @uresults = @game.uresults
    if idx && @uresults[idx].in?(['red', 'blue', 'green', 'white', 'black'])
      @uresults[idx] = @uresults[idx] + '-done'
    end
    @game.results = @uresults.to_json
    @game.save
    if @viewer == 'player'
      @uresults_player = @uresults.collect do |result|
        ['red', 'blue', 'green', 'black', 'white'].include?(result) ? 'white' : result
      end
    end
    respond_to do |format|
      format.json { render 'results' }
    end
  end

end