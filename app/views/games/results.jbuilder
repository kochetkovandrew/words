json.words Hash[@uwords.zip(@viewer == 'player' ? @uresults_player : @uresults).shuffle]
grouped = @uresults.group_by(&:itself)
Rails.logger.debug grouped
json.results do
  json.red (grouped['red'] || []).length
  json.blue (grouped['blue'] || []).length
  if @game.teams == 3
    json.green (grouped['green'] || []).length
  end
  json.game_over ((grouped['black-done'] || []).length > 0)
end