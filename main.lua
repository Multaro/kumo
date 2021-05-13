jogador = {}
mapa = {}
quadros = {}

function love.load()
  musicaFundo = love.audio.newSource("songs/fundo.ogg", "stream")
  efeitoJogadorAtingido = love.audio.newSource("songs/jogadorAtingido.mp3", "static")
  efeitoPegandoItem = love.audio.newSource("songs/pegandoItem.mp3", "static")
  
  -- Configurando as músicas e efeitos sonoros
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
