local Screen = {}

function Screen.load(game)
  Screen.game = game
  Screen.prompt = "Angle: "
  Screen.input = ""
  love.keyboard.setTextInput(true)
end

function Screen.update(dt) end

function Screen.draw()
  love.graphics.print(Screen.prompt .. Screen.input, 0, 0)
end

function Screen.textinput(text)
  Screen.input = Screen.input .. text
end

function Screen.keypressed(key)
  if key == "return" then
    if Screen.prompt == "Angle: " then
      Screen.game.angle = Screen.input + 0
      Screen.prompt = "Power: "
      Screen.input = ""
    else
      Screen.game.power = Screen.input + 0
      Screen.game.setScreen("play_screen")
      Screen.game = nil
    end
  end
end

return Screen
