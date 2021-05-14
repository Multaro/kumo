-- Apelidos para as funções
local newQuad = love.graphics.newQuad

-- Dados do jogador
local jogador = {}
local quadrosJogador = {}
local ataqueInicialJogador = 30
local velocidadeInicialJogador = 100
-- Controle e direção do jogador
local direcaoJogador = 'right'
local passoJogador = 1
local passoMaximo = 9
local status = true
local tempo = 0.1

-- Variáveis para personalizar dimensões do ladrilho do jogador
local quantidadeSpritesJogador = 9
local quadLargura = 32
local quadAltura = 32
local spriteLargura = 256
local spriteAltura = 32

mapa = {}
quadros = {}

function love.load()
  -- Carregando dados sobre o jogador
  jogador.imgdireita = love.graphics.newImage("insumos/jogador-dir.png")
  jogador.imgesquerda = love.graphics.newImage("insumos/jogador-esq.png")
  jogador.imgcima = love.graphics.newImage("insumos/jogador-cima.png")
  jogador.imgbaixo = love.graphics.newImage("insumos/jogador-baixo.png")
  jogador.x = (love.graphics.getWidth() - jogador.imgdireita:getWidth()) / 2
  jogador.y = (love.graphics.getHeight() - jogador.imgdireita:getHeight()) / 2
  jogador.estaVivo = true
  jogador.ataque = ataqueInicialJogador
  jogador.velocidade = velocidadeInicialJogador
  
  -- Definindo os quadros do sprite para o jogador
  quadrosJogador['right'] = {}
  quadrosJogador['left'] = {}
  quadrosJogador['up'] = {}
  quadrosJogador['down'] = {}
  
  for c = 1, quantidadeSpritesJogador do
    quadrosJogador['right'][c] = newQuad((c - 1) * quadLargura, 0, quadLargura, quadAltura, spriteLargura, spriteAltura)
    quadrosJogador['left'][c] = newQuad((c - 1) * quadLargura, 0, quadLargura, quadAltura, spriteLargura, spriteAltura)
    quadrosJogador['up'][c] = newQuad((c - 1) * quadLargura, 0, quadLargura, quadAltura, spriteLargura, spriteAltura)
    quadrosJogador['down'][c] = newQuad((c - 1) * quadLargura, 0, quadLargura, quadAltura, spriteLargura, spriteAltura)
  end
  
  -- Definindo as músicas e efeitos sonoros tocados no jogo
  musicaFundo = love.audio.newSource("songs/fundo.ogg", "stream")
  efeitoJogadorAtingido = love.audio.newSource("songs/jogadorAtingido.mp3", "static")
  efeitoPegandoItem = love.audio.newSource("songs/pegandoItem.mp3", "static")
  
  -- Configurando as músicas e efeitos sonoros
  musicaFundo:setLooping(true)
  musicaFundo:play()
end

function love.draw()
  if jogador.estaVivo then
    local imgJogadorDirecaoCorreta = definirImagemDirecaoJogador()
    love.graphics.draw(imgJogadorDirecaoCorreta, quadrosJogador[direcaoJogador][passoJogador], jogador.x, jogador.y)
  end
end

function love.update(dt)
  if jogador.estaVivo then
    if status == false then
      tempo = tempo + dt
      if tempo > 0.2 then
        tempo = 0.1
        passoJogador = passoJogador + 1
        if love.keyboard.isDown('right') then
          jogador.x = jogador.x + jogador.velocidade
        elseif love.keyboard.isDown('left') then
          jogador.x = jogador.x - jogador.velocidade
        elseif love.keyboard.isDown('up') then
          jogador.y = jogador.y - jogador.velocidade
        elseif love.keyboard.isDown('down') then
          jogador.y = jogador.y + jogador.velocidade
        end
        
        if passoJogador > passoMaximo then
          passoJogador = 1
        end
      end
    end
  end
end

function love.keypressed(keyPressed)
  if quadrosJogador[keyPressed] then
    direcaoJogador = keyPressed
    status = false
  end
  
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

function love.keyreleased(keyReleased)
  if quadrosJogador[keyReleased] then
    status = true
    passo = 1
  end
end

function definirImagemDirecaoJogador()
  if direcaoJogador == 'right' then
    return jogador.imgdireita
  elseif direcaoJogador == 'left' then
    return jogador.imgesquerda
  elseif direcaoJogador == 'up' then
    return jogador.imgcima
  elseif direcaoJogador == 'down' then
    return jogador.imgbaixo
  end
end