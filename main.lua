jogador = {}
mapa = {}
quadros = {}

function love.load()
  jogador.img = love.graphics.newImage("insumos/jogador.png");
  musicaFundo = love.audio.newSource("musics/fundo.ogg", "stream")
  
  musicaFundo:setLooping(true)
  musicaFundo:play()
end

function love.draw()

end

function love.update(dt)
  
end

function love.keypressed(keyPressed)
  if keyPressed == "kp-" or keyPressed == "kp+" then
    volumeAtual = musicaFundo:getVolume()
    if keyPressed == "kp-" then
      volumeAtual = volumeAtual - 0.1
    elseif keyPressed == "kp+" then
      volumeAtual = volumeAtual + 0.1
    end
    
    musicaFundo:setVolume(volumeAtual)
  end
end
