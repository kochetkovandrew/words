json.words Hash[@uwords.zip(@viewer == 'player' ? @uresults_player : @uresults).shuffle]
grouped = @uresults.group_by(&:itself)
json.results do
  json.red (grouped['red'] || []).length
  json.blue (grouped['blue'] || []).length
  if @game.teams == 3
    json.green (grouped['green'] || []).length
  end
  json.game_over ((grouped['black-done'] || []).length > 0)
end
if @game.timer_at.nil? || @game.timer_at < Time.current
  json.rest_time 0
else
  json.rest_time (@game.timer_at - Time.current).to_i
end
