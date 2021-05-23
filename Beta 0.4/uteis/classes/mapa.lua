-- Apelidos para as funções
local newQuad = love.graphics.newQuad

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



function mapa.criaMapa() 

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

function mapa.draw()
   
  
  
  for posicao, linha in ipairs(mapa.fases[proximaFase]) do
    for coluna, quadro in ipairs(linha) do
      if quadro ~= 0 then
          love.graphics.draw(mapa.img, quadrosMapa[quadro], (coluna - 1) * tamanhoQuadroMapa, (posicao - 1) * tamanhoQuadroMapa)
      end
    end
  end


  for x, quad in ipairs(quadrosIntransponiveis) do
    love.graphics.setColor(1,1,1,0)
    love.graphics.rectangle('fill',quad.x ,quad.y,quad.width,quad.height)
    love.graphics.setColor(1,1,1,1)
end
end

function mapa.colisao(player,playerPosX,playerPosY,direcao)
    colisaoPlayer = true
    
    for i, quadroColisao in ipairs(quadrosIntransponiveis) do
        if(quadroColisao.x + quadroColisao.width > player.getPosX() and quadroColisao.y + quadroColisao.height > player.getPosY() and quadroColisao.x < player.getPosX() + player.getQuadro()/2 and quadroColisao.y < player.getPosY() + player.getQuadro()/2) then
            colisaoPlayer = false
            if(direcao == 'up') then
                player.setPosY(math.floor(playerPosY + 20))
            
            elseif(direcao == 'down') then
                player.setPosY(math.floor(playerPosY - 20))
            
            elseif(direcao == 'left') then
                player.setPosX(math.floor(playerPosX + 20))
            
            elseif(direcao == 'right') then
                player.setPosX(math.floor(playerPosX - 20))
            end
           
           
        end
    end
    return colisaoPlayer
end




function mapa.correMapa()

    for posicao, linha in ipairs(mapa.fases[proximaFase]) do
        for coluna, quadro in ipairs(linha) do
          if quadro ~= 0 then
            if(quadro == 8) then
                quadroNovo = {x = (coluna - 1) * tamanhoQuadroMapa, y = (posicao - 1) * tamanhoQuadroMapa, width = tamanhoQuadroMapa, height = tamanhoQuadroMapa}
                table.insert(quadrosIntransponiveis,quadroNovo)
            end
          end
        end
      end

end

function mapa.trocaFase() 
    proximaFase = proximaFase + 1
    if(proximaFase > 2) then
        proximaFase = 2
    end
end


return mapa