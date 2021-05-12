-- Dados do jogador
jogador = {}

mapa = {}
quadros = {}

function love.load()
  -- Carregando dados sobre o jogador
  jogador.img = love.graphics.newImage("insumos/jogador.png")
  jogador.x = (love.graphics.getWidth() - jogador.img:getWidth()) / 2
  jogador.y = (love.graphics.getHeight() - jogador.img:getHeight()) / 2
  jogador.estaVivo = true
  
  musicaFundo = love.audio.newSource("songs/fundo.ogg", "stream")
  
  musicaFundo:setLooping(true)
  musicaFundo:play()
end

function love.draw()
  if jogador.estaVivo then
    love.graphics.draw(jogador.img, jogador.x, jogador.y)
  end
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
