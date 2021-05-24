-- Classes ------------------------------------------------
local monster = require("uteis.classes.monster") -- Import dos monstros
local player = require("uteis.classes.player") -- Import player
local menu = require("uteis.classes.menu") -- Import Menu
local Boss = require("uteis.classes.Boss") -- Import Boss
local mapa = require("uteis.classes.mapa") -- Import Mapa

-- variaveis de controle ------------------------------------------------
local time = 13
local k = love.keyboard.isDown
local sleepTime = 0
local sleepTimeItem = 0-- Timer 
local timeMenuController = 0
local monstros = {} -- Tabela que vai armazenar os monstros
local fonteWay
local fonte
local delta
local medidaMoviemento = 64
local podeAtacar = false
local gameState = 'game'
local randomPosX
local randomPosY

-- Load ------------------------------------------------
function love.load()
 fonteWay = 'uteis/fonts/joystix/joystix.ttf'
 menu.load()
 fonte = love.graphics.newFont(fonteWay,10)
 love.graphics.setFont(fonte)
 
 player.createPlayer(500,500,'uteis/imgs/player/player.png',128)

 local mob = {}
 table.insert(monstros, monster.createMonster(mob,'Rinoceronte','uteis/imgs/monster/rino.png',128,500,100,10,100)) 
 if(gameState == 'boss') then
  Boss.createBoss(gameState)
 end
 Boss.createBoss(gameState)
 mapa.criaMapa()
end

-- Draw ------------------------------------------------
function love.draw()  
  -- Aqui conteudo do Menu
  if(gameState == 'intro' or gameState == 'menu') then
    love.graphics.setColor(0,0,0,1)
    menu.draw(gameState,time,fonteWay)
  end
  
  -- Aqui conteudo do Jogo
if(gameState == "game" or gameState == 'boss') then
  if(gameState == "game") then
    mapa.draw(gameState)
    love.graphics.setColor(1,1,1,1)
    player.draw()
    
    for i, mobs in ipairs(monstros) do
      monster.draw(mobs,fonte,delta) 
    end
   
  end
  if gameState == 'boss' then
    mapa.draw(gameState)
    Boss.draw()
    player.draw()
  end
end
-- Aqui conteudo do Boss


-- Aqui conteudo do Game Over
    if(gameState == "GameOver") then
      love.graphics.setBackgroundColor(0,0,0)
      love.graphics.setColor(1,0,0,1)
      thisfonte = love.graphics.setNewFont(fonteWay,72)
      local textOver = "Game Over"
      love.graphics.print(textOver,love.graphics.getWidth()/2 - thisfonte:getWidth(textOver)/2,love.graphics.getHeight()/2 - thisfonte:getHeight(textOver)/2)
      thisfonte = love.graphics.setNewFont(fonteWay,20)
      love.graphics.setColor(0,1,1,1)
      love.graphics.print("Pontuação: "..player.pontos,love.graphics.getWidth()/2 - thisfonte:getWidth("Pontuação: ")/2,love.graphics.getHeight()/2 +  thisfonte:getHeight("Pontuação: ") * 2)
  end
  
  if(gameState == 'vitoria') then
    love.graphics.setBackgroundColor(0,0,0)
    love.graphics.setColor(238/255,201/255,0/255,1)
    thisfonte = love.graphics.setNewFont(fonteWay,72)
    local textOver = "Vitoria"
    love.graphics.print(textOver,love.graphics.getWidth()/2 - thisfonte:getWidth(textOver)/2,love.graphics.getHeight()/2 - thisfonte:getHeight(textOver)/2)
    thisfonte = love.graphics.setNewFont(fonteWay,20)
    love.graphics.setColor(0,1,1,1)
    love.graphics.print("Pontuação: "..player.pontos,love.graphics.getWidth()/2 - thisfonte:getWidth("Pontuação: ")/2,love.graphics.getHeight()/2 +  thisfonte:getHeight("Pontuação: ") * 2)
  end
end

-- Update ------------------------------------------------
function love.update(dt)
  delta = dt
  controleStatusGame(dt)
  -- Aqui conteudo do menu
  if(gameState == "intro") then
  end
  if(gameState == "menu") then
end

-- Aqui conteudo do Jogo
  if(gameState == "game" or gameState == 'boss') then
    if(gameState == "game") then        
    -- Movimenta os Monstros e controla a visão/ataque dos mesmos assim como drop de itens
      if(player.getPontos() >= 10) then
        mapa.trocaFase() 
        Boss.criaColisao()
        gameState = 'boss'
      end
    monster.update(monstros,player,medidaMoviemento,dt,podeAtacar,player.lifeBar(),randomPosX,randomPosY)
   end
   
    if(gameState == 'boss') then
      mapa.update(dt)
    end
     -- Movimento do Player
    player.update(medidaMoviemento, dt, mapa,gameState)
  end
-- Aqui conteudo ???
end

-- Controlador de menu e tela Game Over ------------------------------------------------
function controleStatusGame(dt)
  if(gameState == 'intro' or gameState == 'menu') then
    if(gameState == 'intro') then
      timeMenuController = timeMenuController + dt
        if(timeMenuController > 10 ) then
          gameState = 'menu'
        end
      end
      menu.update(dt,gameState,time)
      time = time - dt * 1
      if(time <=0) then
        time = 0
      end
    end
  
    if(gameState == "game" or gameState == 'boss') then
      if(player.lifeBar().getValor() == 0) then
        gameState = 'GameOver' 
      end
    end
    if gameState == 'boss' then
      if(Boss.getVida() <= ((Boss.getMaxVida() / 100) * 100)) and (Boss.getVida() > ((Boss.getMaxVida() / 100) * 75)) then
        Boss.setStageOne()
      elseif (Boss.getVida() <= ((Boss.getMaxVida() / 100) * 75)) and (Boss.getVida() > ((Boss.getMaxVida() / 100) * 50)) then
        Boss.setStageTwo()
      elseif (Boss.getVida() <= ((Boss.getMaxVida() / 100)) * 50) then
        Boss.setStageThree()
      end
    if(Boss.vivo() == false) then
      gameState = 'vitoria'
    end
    Boss.update(dt,player)
  end
end
 
 -- Key ------------------------------------------------
function love.keyreleased(key)
  if gameState == 'game' or gameState == 'boss' then
    if gameState == 'game' then
      for i, monst in ipairs(monstros) do
        if key == 'd' and player.ataque(monst) and (player.usandoSkill() == false)then
          monster.dano(monst,player.getAtq())
        end
      end
      if key =='w' then
        player.lifeBar().imortal()
          if(player.skill()) then
            for i, monst in ipairs(monstros) do
              monster.dano(monst,player.getAtq() * 3)
            end
          end
        end
      end
  
      if gameState == 'boss' then
        if key == 'd' and Boss.ataque(player) and (player.usandoSkill() == false)then
          Boss.dano(player.getAtq())
        end
        if key =='w' then
          player.lifeBar().imortal()
        if(player.skill()) then
          Boss.dano(player.getAtq() * 3)
        end
      end
    end
  end
  
  if gameState == 'intro' or gameState == 'menu' then
    if key then
      gameState = 'game'
      music:stop()
      sound:stop()
    end
  end
  if gameState == 'GameOver' then
    if key == 'r' then
      love.load()
      gameState ='game'
    end
  end
  
  if gameState == 'boss' then
    if key == "n" then
      Boss.setStageOne()
    elseif key == "m" then
      Boss.setStageTwo()
    elseif key == "p" then
      Boss.setStageThree()
    end
  end
--[[ if key == "kp-" or keyPressed == "kp+" then
    volumeAtual = musicaFundo:getVolume()
    if keyPressed == "kp-" then
      volumeAtual = volumeAtual - 0.1
    elseif keyPressed == "kp+" then
      volumeAtual = volumeAtual + 0.1
    end
    
    musicaFundo:setVolume(volumeAtual)
  end --]]
end
