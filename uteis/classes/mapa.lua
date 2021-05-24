-- Apelidos para as funções
local newQuad = love.graphics.newQuad
local hc = require 'HC'

-- Dados do jogador
-- Controle e direção do jogador
-- Variáveis para personalizar dimensões do ladrilho do jogador

local mapa = {}
local quadrosMapa = {}
local tamanhoQuadroMapa = 32
local quantidadeQuadrosMapa = 6
local proximaFase
local quadrosIntransponiveis = {}
local colisaoPlayer = true
local direcao = ''

function mapa.criaMapa()
  mapa.angle = 0 
  circulo ={}
  circulo.x = 470
  circulo.y = 350
  circulo.radius = 350
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
  {6, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 3} -- 23
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
  {6, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 3} -- 23
}

faseBoss = {imgBack = love.graphics.newImage('uteis/imgs/Boss/microndas.png'),imgPrato = love.graphics.newImage('uteis/imgs/Boss/microndas2.png'),angle = 0}

  love.graphics.setBackgroundColor(0, 0, 0)
  --love.graphics.setFont(love.graphics.newFont(16))
  -- Carregando dados sobre o jogador

  -- Carregando informações sobre o mapa
  mapa.img = love.graphics.newImage("uteis/imgs/mapa/map.png")
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
  mapa.correMapa()
 
  -- Definindo as músicas e efeitos sonoros tocados no jogo
 -- musicaFundo = love.audio.newSource("songs/fundo.ogg", "stream")
  --efeitoJogadorAtingido = love.audio.newSource("songs/jogadorAtingido.mp3", "static")
 -- efeitoPegandoItem = love.audio.newSource("songs/pegandoItem.mp3", "static")
  
  -- Configurando as músicas e efeitos sonoros
 -- musicaFundo:setLooping(true)
 -- musicaFundo:play()
end

function mapa.draw(gameState)
  
  if(gameState =='game') then
    love.graphics.setBackgroundColor(0,0,0)
    for posicao, linha in ipairs(mapa.fases[proximaFase]) do
      for coluna, quadro in ipairs(linha) do
        if quadro ~= 0 then
          love.graphics.draw(mapa.img, quadrosMapa[quadro], (coluna - 1) * tamanhoQuadroMapa, (posicao - 1) * tamanhoQuadroMapa)
        end
      end
    end
  end

  --[[for i, quad in ipairs(quadrosIntransponiveis) do
    quad:draw()
  end--]]

  if(gameState =='boss') then
    mapa.resetaColisao()
    love.graphics.circle('fill', circulo.x, circulo.y, circulo.radius)
    love.graphics.draw(faseBoss.imgBack, 0, 0)
    
   love.graphics.push()
   love.graphics.translate(love.graphics.getWidth() / 2, love.graphics.getHeight() / 2)
   love.graphics.rotate(faseBoss.angle)
   love.graphics.translate(-love.graphics.getWidth() / 2, -love.graphics.getHeight() / 2)
   love.graphics.draw(faseBoss.imgPrato, 0, 0)
   love.graphics.pop()

   --love.graphics.draw(faseBoss.imgPrato,0,0, faseBoss.angle, faseBoss.imgPrato:getWidth()/2, faseBoss.imgPrato:getHeight()/2, faseBoss.imgPrato:getWidth(), faseBoss.imgPrato:getHeight())
  end
end

function mapa.update(dt)
  faseBoss.angle = faseBoss.angle + dt * math.pi / 2
	faseBoss.angle = faseBoss.angle % (2*math.pi)
end

function mapa.correMapa()
  for posicao, linha in ipairs(mapa.fases[proximaFase]) do
    for coluna, quadro in ipairs(linha) do
      if quadro ~= 0 then
        if(quadro == 8) then
          quadroNovo = hc.rectangle((coluna - 1) * tamanhoQuadroMapa, (posicao - 1) * tamanhoQuadroMapa,tamanhoQuadroMapa, tamanhoQuadroMapa)
          table.insert(quadrosIntransponiveis,quadroNovo)
        end
      end
    end
  end
end

function mapa.trocaFase() 
  proximaFase = proximaFase + 1
  mapa.resetaColisao()
  if(proximaFase > 2) then
    proximaFase = 2
  end
  mapa.correMapa()
end

function mapa.resetaColisao()
  for i, quad in ipairs(quadrosIntransponiveis) do
    hc.remove(quad)
  end
  quadrosIntransponiveis = {}
end

function mapa.circleAndRectangleOverlap(jogador)
  local circle_distance_x = math.abs(circulo.x - jogador.getPosX() - jogador.getQuadro()/2)
  local circle_distance_y = math.abs(circulo.y - jogador.getPosY() - jogador.getQuadro()/2)

  if circle_distance_x > (jogador.getQuadro()/2 + circulo.radius) or circle_distance_y > (jogador.getQuadro()/2 + circulo.radius) then
    return false
  elseif circle_distance_x <= (jogador.getQuadro()/2) or circle_distance_y <= (jogador.getQuadro()/2) then
    return true
  end
  return (math.pow(circle_distance_x - jogador.getQuadro() / 2, 2) + math.pow(circle_distance_y - jogador.getQuadro() / 2, 2)) <= math.pow(circulo.radius, 2)
end

function mapa.updateAngle(jogador) 
  mapa.angle = mapa.mathAngle(jogador.getPosX(), jogador.getPosY(), circulo.x + circulo.radius / 2, circulo.y + circulo.radius / 2)
  return  mapa.angle
end

function mapa.mathAngle(x1, y1, x2, y2)
  return math.deg(math.atan2(y1 - y2, x1 - x2))
end

return mapa
