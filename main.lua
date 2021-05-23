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

local mapa = {}
local quadrosMapa = {}
local tamanhoQuadroMapa = 32
local quantidadeQuadrosMapa = 6
local primeiraFase = {
-- 1  2  3  4  5  6  7  8  9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30
  {1, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 3}, -- 1
  {5, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 3}, -- 2
  {5, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 3}, -- 3
  {5, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 8, 8, 8, 8, 8, 8, 8, 4, 4, 4, 4, 4, 4, 3}, -- 4
  {5, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 3}, -- 5
  {5, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 3}, -- 6
  {5, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 3}, -- 7
  {5, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 3}, -- 8
  {5, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 3}, -- 9
  {5, 4, 4, 4, 8, 8, 8, 8, 8, 8, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 3}, -- 10
  {5, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 3}, -- 11
  {5, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 3}, -- 12
  {5, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 3}, -- 13
  {5, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 4, 4, 3}, -- 14
  {5, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 3}, -- 15
  {5, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 3}, -- 16
  {5, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 3}, -- 17
  {5, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 3}, -- 18
  {5, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 3}, -- 19
  {5, 4, 4, 4, 8, 8, 8, 8, 8, 8, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 3}, -- 20
  {5, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 3}, -- 21
  {5, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 3}, -- 22
  {6, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 3}, -- 23
}

local segundaFase = {
  -- 1  2  3  4  5  6  7  8  9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30
  {1, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 3}, -- 1
  {5, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 3}, -- 2
  {5, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 3}, -- 3
  {5, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 3}, -- 4
  {5, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 3}, -- 5
  {5, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 3}, -- 6
  {5, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 3}, -- 7
  {5, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 3}, -- 8
  {5, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 3}, -- 9
  {5, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 3}, -- 10
  {5, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 3}, -- 11
  {5, 4, 4, 4, 4, 4, 4, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 4, 4, 4, 4, 4, 4, 4, 3}, -- 12
  {5, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 3}, -- 13
  {5, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 3}, -- 14
  {5, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 3}, -- 15
  {5, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 3}, -- 16
  {5, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 3}, -- 17
  {5, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 3}, -- 18
  {5, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 3}, -- 19
  {5, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 3}, -- 20
  {5, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 3}, -- 21
  {5, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 3}, -- 22
  {6, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 3}, -- 23
}
local proximaFase

function love.load()
  love.graphics.setBackgroundColor(0, 0, 0)
  love.graphics.setFont(love.graphics.newFont(16))
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

  -- Carregando informações sobre o mapa
  mapa.img = love.graphics.newImage("insumos/map.png")
  mapa.fases = {}
  table.insert(mapa.fases, primeiraFase)
  table.insert(mapa.fases, segundaFase)
  
  quadrosMapa[1] = newQuad(1 * tamanhoQuadroMapa, 1 * tamanhoQuadroMapa, tamanhoQuadroMapa, tamanhoQuadroMapa, mapa.img:getWidth(), mapa.img:getHeight())
  quadrosMapa[2] = newQuad(2 * tamanhoQuadroMapa, 1 * tamanhoQuadroMapa, tamanhoQuadroMapa, tamanhoQuadroMapa, mapa.img:getWidth(), mapa.img:getHeight())
  quadrosMapa[3] = newQuad(3 * tamanhoQuadroMapa, 1 * tamanhoQuadroMapa, tamanhoQuadroMapa, tamanhoQuadroMapa, mapa.img:getWidth(), mapa.img:getHeight())
  quadrosMapa[4] = newQuad(2 * tamanhoQuadroMapa, 2 * tamanhoQuadroMapa, tamanhoQuadroMapa, tamanhoQuadroMapa, mapa.img:getWidth(), mapa.img:getHeight())
  quadrosMapa[5] = newQuad(1 * tamanhoQuadroMapa, 2 * tamanhoQuadroMapa, tamanhoQuadroMapa, tamanhoQuadroMapa, mapa.img:getWidth(), mapa.img:getHeight())
  quadrosMapa[6] = newQuad(1 * tamanhoQuadroMapa, 3 * tamanhoQuadroMapa, tamanhoQuadroMapa, tamanhoQuadroMapa, mapa.img:getWidth(), mapa.img:getHeight())
  quadrosMapa[7] = newQuad(2 * tamanhoQuadroMapa, 3 * tamanhoQuadroMapa, tamanhoQuadroMapa, tamanhoQuadroMapa, mapa.img:getWidth(), mapa.img:getHeight())
  quadrosMapa[8] = newQuad(1 * tamanhoQuadroMapa, 9 * tamanhoQuadroMapa - 2, tamanhoQuadroMapa, tamanhoQuadroMapa, mapa.img:getWidth(), mapa.img:getHeight())
  
  proximaFase = 1
  
  -- Definindo as músicas e efeitos sonoros tocados no jogo
  musicaFundo = love.audio.newSource("songs/fundo.ogg", "stream")
  efeitoJogadorAtingido = love.audio.newSource("songs/jogadorAtingido.mp3", "static")
  efeitoPegandoItem = love.audio.newSource("songs/pegandoItem.mp3", "static")
  
  -- Configurando as músicas e efeitos sonoros
  musicaFundo:setLooping(true)
  musicaFundo:play()
end

function love.draw()
  
  
  for posicao, linha in ipairs(mapa.fases[proximaFase]) do
    for coluna, quadro in ipairs(linha) do
      if quadro ~= 0 then
          love.graphics.draw(mapa.img, quadrosMapa[quadro], (coluna - 1) * tamanhoQuadroMapa, (posicao - 1) * tamanhoQuadroMapa)
      end
    end
  end
  
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
        local x = jogador.x
        local y = jogador.y
        
        tempo = 0.1
        passoJogador = passoJogador + 1
        if love.keyboard.isDown('right', 'd') then
          x = x + jogador.velocidade
        elseif love.keyboard.isDown('left', 'a') then
          x = x - jogador.velocidade
        elseif love.keyboard.isDown('up') then
          y = y - jogador.velocidade
        elseif love.keyboard.isDown('down') then
          y = y + jogador.velocidade
        end
        
        jogador.x = x
        jogador.y = y
        
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