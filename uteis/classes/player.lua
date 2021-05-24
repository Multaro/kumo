local Q = love.graphics.newQuad
local k = love.keyboard.isDown
local hc = require 'HC'
local mapa = require("uteis.classes.mapa")
local Boss = require("uteis.classes.Boss")
local monster = require("uteis.classes.monster")
local lifePersonagem = require("uteis.classes.lifePersonagem") -- Import barra de vida do player
local maxPosAtaque = 6
local maxPosicaoCorrida = 8
local player = {}
local skill = {}


function player.createPlayer(posX,posY,img,quadro)
  player.posX = posX
  player.posY = posY
  player.pontos = 0
  player.atq = 15
  player.img = love.graphics.newImage(img)
  player.quadro = quadro -- tamanho quadro em px
  player.qtdQuadrosX = player.img:getWidth() / quadro
  player.qtdQuadrosY = player.img:getHeight() / quadro
  if(player.qtdQuadrosX == 0) then
    player.qtdQuadrosX = 1
  end
  if(player.qtdQuadrosY == 0) then
    player.qtdQuadrosX = 1
  end
    
  player.posMax = 0
  player.sleepTime = 0
  player.sleepTimePos = 0
  player.pos = 1
  player.status = 'caminhando'
  player.img:setFilter("nearest","linear")
  player.Quadros = {}
  player.direcao = 'down'
  player.Quadros['up'] = {}
  player.Quadros['down']= {}
  player.Quadros['left'] = {}
  player.Quadros['right'] = {}
  player.Quadros['atqUp'] = {}
  player.Quadros['atqDown']= {}
  player.Quadros['atqLeft'] = {}
  player.Quadros['atqRight'] = {}
  player.qtdQuadros = player.qtdQuadrosX * player.qtdQuadrosY
  player.hitBox = hc.rectangle(player.getPosX(),player.getPosY(),player.getColisaoWidth(),player.getQuadro())
      
  skill.img = love.graphics.newImage('uteis/imgs/player/playerSkillEfect2.png')
  skill.img:setFilter("nearest","linear")
  skill.pos = 1
  skill.maxPos = 12
  skill.quadro = 64
  skill.qtdQuadrosX = skill.img:getWidth() / skill.quadro
  skill.qtdQuadrosY = skill.img:getHeight() / skill.quadro
  skill.Quadros = {}
  skill.ativo = false
  skill.cd = 10
  skill.tempoCd = 10
  skill.time = 0
  skill.cdImageAtaque = 0
  skill.imgAtaque = false
  skill.imgGarra = love.graphics.newImage('uteis/imgs/player/playerSkillEfect3.png')
  lifePersonagem.lifePersonagemLoad()
  local y = 0

  for x = 0, (player.qtdQuadrosX - 1) do
    player.Quadros['down'][x+1] = Q((x * player.quadro), (y * player.quadro),player.quadro,player.quadro,player.img:getWidth(),player.img:getHeight())
  end

  y = y+1
  for x = 0, (player.qtdQuadrosX - 1) do
    player.Quadros['up'][x+1] = Q((x * player.quadro), (y * player.quadro),player.quadro,player.quadro,player.img:getWidth(),player.img:getHeight())
  end
  y = y+1

  for x = 0, (player.qtdQuadrosX - 1) do
    player.Quadros['left'][x+1] = Q((x * player.quadro), (y * player.quadro),player.quadro,player.quadro,player.img:getWidth(),player.img:getHeight())
  end
  y = y+1

  for x = 0, (player.qtdQuadrosX - 1) do
    player.Quadros['right'][x+1] = Q((x * player.quadro), (y * player.quadro),player.quadro,player.quadro,player.img:getWidth(),player.img:getHeight())
  end
  y = y+1

  for x = 0, (player.qtdQuadrosX - 3) do
    player.Quadros['atqDown'][x+1] = Q((x * player.quadro), (y * player.quadro),player.quadro,player.quadro,player.img:getWidth(),player.img:getHeight())
  end
  y = y+1

  for x = 0, (player.qtdQuadrosX - 3) do
    player.Quadros['atqUp'][x+1] = Q((x * player.quadro), (y * player.quadro),player.quadro,player.quadro,player.img:getWidth(),player.img:getHeight())
  end
  y = y+1

  for x = 0, (player.qtdQuadrosX - 3) do
    player.Quadros['atqLeft'][x+1] = Q((x * player.quadro), (y * player.quadro),player.quadro,player.quadro,player.img:getWidth(),player.img:getHeight())
  end
  y = y+1

  for x = 0, (player.qtdQuadrosX - 3) do
    player.Quadros['atqRight'][x+1] = Q((x * player.quadro), (y * player.quadro),player.quadro,player.quadro,player.img:getWidth(),player.img:getHeight())
  end

  local cont = 1

  for y = 0, (skill.qtdQuadrosY - 1) do
    for x = 0, (skill.qtdQuadrosX - 1) do
      skill.Quadros[cont] = Q((x * skill.quadro), (y * skill.quadro),skill.quadro,skill.quadro,skill.img:getWidth(),skill.img:getHeight())
      cont = cont + 1
    end
  end
end

function player.getPosX()
    return player.posX
end

function player.getPosY()
    return player.posY
end

function player.getWidth()
    return player.quadro
end

function player.getHeight()
    return player.quadro
end

function player.setPosX(value)
    player.posX = value
end

function player.setPosY(value)
    player.posY = value
end

function player.getQuadro()
  return player.quadro
end

function player.getPontos()
  return player.pontos
end

function player.addPontos(pontos)
   player.pontos = player.pontos + pontos
end

function player.getAtq()
  return player.atq
end

function player.addAtq(ataque)
  player.atq = player.atq + ataque
end

function player.getColisaoX() 
  return player.getPosX()+player.getQuadro()/4
end

function player.getColisaoWidth() 
  return player.getQuadro()/2
end

function player.draw()

    -- love.graphics.print(player.getPosX(),10,40)
    --  love.graphics.print(player.getPosY(),10,50)
    --love.graphics.rectangle('fill',player.getPosX()+player.getQuadro()/4,player.getPosY(),player.getQuadro()/2,player.getQuadro())
    --love.graphics.print(player.getColisaoX(),10,60)

   -- player.hitBox:draw()
  lifePersonagem.lifePersonagemDraw(player.skillPronta())
  love.graphics.setColor(1, 1, 1, 1)
  if(skill.ativo == false) then
    love.graphics.draw(player.img,player.Quadros[player.direcao][player.pos],player.posX,(player.posY))
  else
  love.graphics.draw(skill.img,skill.Quadros[skill.pos],(player.posX + (player.quadro / 4)),((player.posY + player.quadro/4)))
    if(skill.imgAtaque) then
      love.graphics.draw(skill.imgGarra,(love.graphics.getWidth()/2 - skill.imgGarra:getWidth()/2),(love.graphics.getHeight()/2 - skill.imgGarra:getHeight()/2))
    end
  end  
end

function player.lifeBar()
  return lifePersonagem
end

function player.posicaoAtaque()
  player.status = 'atacando'
  if(player.direcao == 'up' or player.direcao == 'atqUp') then
    if(player.direcao == 'up') then
      player.direcao = 'atqUp'
      player.pos = 1
    end
    player.posMax = maxPosAtaque
    player.pos = player.pos + 1
  elseif(player.direcao == 'down' or player.direcao == 'atqDown') then
    if(player.direcao == 'down') then
      player.direcao = 'atqDown'
      player.pos = 1
    end
    player.posMax = maxPosAtaque
    player.pos = player.pos + 1
  elseif(player.direcao == 'right' or player.direcao == 'atqRight') then
    if(player.direcao == 'right') then
      player.direcao = 'atqRight'
      player.pos = 1
    end
    player.posMax = maxPosAtaque
    player.pos = player.pos + 1
  elseif(player.direcao == 'left' or player.direcao == 'atqLeft') then
    if(player.direcao == 'left') then
      player.direcao = 'atqLeft'
      player.pos = 1
    end
    player.posMax = maxPosAtaque
    player.pos = player.pos + 1
  end
end

function player.ataque(monstro) 
  if(player.status == 'caminhando') then
    if((monster.getPosX(monstro) < player.posX + player.quadro) and (monster.getPosX(monstro) + monster.getQuadro(monstro) > player.posX) and (monster.getPosY(monstro) < player.posY + player.quadro) and (monster.getPosY(monstro) + monster.getQuadro(monstro) > player.posY)) then
      player.posicaoAtaque()
      return true
    else 
      player.posicaoAtaque()
      return false
    end
  end
end

function player.movimenta(medidaMoviemento, dt, mapa,gameState)
  velocidade = (medidaMoviemento * 10)* dt
  player.controlaCdSkill(dt)
  playerPosX = player.getPosX()
  playerPosY = player.getPosY()
  if(player.status == 'caminhando') then
    player.sleepTime = player.sleepTime + dt * 3
    if(player.sleepTime > 0.1) then   
      if k("down") and player.colisaoBorda("down")then
        if(player.direcao == 'down') then
          player.pos = player.pos + 1
          player.posMax = maxPosicaoCorrida
          player.setPosY(math.floor(player.getPosY() + velocidade))
        else
          player.pos = 1
          player.direcao = 'down'
          player.posMax = maxPosicaoCorrida
          player.setPosY(math.floor(player.getPosY() + velocidade))
        end

      elseif k("up") and player.colisaoBorda("up") then
        if(player.direcao == 'up') then
          player.pos = player.pos + 1
          player.posMax = maxPosicaoCorrida
          player.setPosY(math.floor(player.getPosY() - velocidade))
        else
          player.pos = 1
          player.direcao = 'up'
          player.posMax = maxPosicaoCorrida
          player.setPosY(math.floor(player.getPosY() - velocidade))
        end
      elseif k("right") and player.colisaoBorda("right") then
        if(player.direcao == 'right') then
          player.pos = player.pos + 1
          player.posMax = maxPosicaoCorrida
          player.setPosX(math.floor(player.getPosX() + velocidade))
        else
          player.pos = 1
          player.direcao = 'right'
          player.posMax = maxPosicaoCorrida
          player.setPosX(math.floor(player.getPosX() + velocidade))
        end

      elseif k("left") and player.colisaoBorda("left") then        
        if(player.direcao == 'left') then
          player.pos = player.pos + 1
          player.posMax = maxPosicaoCorrida
          player.setPosX(math.floor(player.getPosX() - (medidaMoviemento * 10)* dt))
        else
          player.pos = 1
          player.direcao = 'left'
          player.posMax = maxPosicaoCorrida
          player.setPosX(math.floor(player.getPosX() - (medidaMoviemento * 10)* dt))
        end
      else   
    end
    player.sleepTime = 0
  end
    if(player.pos ==  player.posMax) then
      player.pos = 1
    end

  end
    if(gameState == 'boss') then
      if(mapa.circleAndRectangleOverlap(player)) then
         player.moveJogador(dt)
      end
    end
end

function player.colisaoBorda(direcao)
  -- posição X do monstro, posição Y do monstro, largura, altura, direção)
  windowHeight = love.graphics.getHeight() 
  windowWidth = love.graphics.getWidth() 
  if((player.getPosX() + player.getQuadro() > windowWidth and direcao == "right") or ((player.getPosY() + player.getQuadro() > windowHeight) and direcao == "down") or ((player.getPosX() < 0) and direcao == "left") or ((player.getPosY() < 0) and direcao == "up")) then
    return false
  else 
    return true
  end
end

function player.atualizaQuadros(dt)
  if(player.status == 'atacando') then
    player.sleepTimePos = player.sleepTimePos + dt * 3
    if(player.sleepTimePos > 0.2) then
      player.pos = player.pos + 1
      if(player.pos ==  player.posMax + 1) then
        player.pos = 1
        if(player.direcao == 'atqUp') then
          player.direcao = 'up'
        end
        if(player.direcao == 'atqDown') then
          player.direcao = 'down'
        end
        if(player.direcao == 'atqLeft') then
          player.direcao = 'left'
        end
        if(player.direcao == 'atqRight') then
          player.direcao = 'right'
        end
        player.status = 'caminhando'
      end
      player.sleepTimePos = 0
    end
  end
end

function player.podeAtacar()
  if(player.status == 'atacando') then
    return false
  else
    return true
  end
end

function player.usandoSkill()
  if(skill.ativo == false) then
    return false
  else
    return true
  end
end

function player.skill()
  if(skill.cd == 0) then
    skill.ativo = true
    skill.cd = skill.tempoCd
    return true
  else
    return false
  end
end

function player.controlaCdSkill(dt) 
  skill.cd = skill.cd - dt
  if(skill.cd <= 0) then
    skill.cd = 0
  end
end

function player.controlaQuadrosSkill(dt) 

  if(skill.ativo == true) then
    if(skill.pos == (skill.maxPos/2) + 1) then
      skill.imgAtaque = true
      skill.cdImageAtaque = skill.cdImageAtaque + dt
        if(skill.cdImageAtaque >= 1) then
          skill.imgAtaque = false
          skill.pos = skill.pos + 1
          skill.cdImageAtaque = 0
        end
    else
      skill.time = skill.time + dt * 2
      if( skill.time > 0.1) then
        skill.pos = skill.pos + 1
        skill.time = 0
        if(skill.pos == skill.maxPos + 1) then
          skill.ativo = false
          skill.pos = 1
        end
      end
    end
  end
end

function player.skillPronta() 
  if(skill.cd == 0) then
    return true
  else
    return false
  end
end

function player.update(medidaMoviemento, dt, mapa,gameState)
  player.hitBox:moveTo(player.getPosX() + player.getColisaoWidth(),player.getPosY()+player.getColisaoWidth())

  for i,quadrado in pairs(hc.collisions(player.hitBox)) do
    player.setPosX(player.getPosX() + quadrado.x)
    player.setPosY(player.getPosY() + quadrado.y)
  end

  if(gameState == 'boss') then
    for i,boss in pairs(hc.collisions(Boss.colisao)) do
      if(Boss.isStage2Collision()) then
        player.lifeBar().dano(0.5)
      end
    end
  end
  
  player.movimenta(medidaMoviemento, dt, mapa,gameState)
  player.controlaQuadrosSkill(dt)
  player.atualizaQuadros(dt)

  if(player.usandoSkill() == false) then
    lifePersonagem.mortal()
  end     
end

function player.moveJogador(dt)
  angle = mapa.updateAngle(player)
  if angle >= -45 and angle < 0 then 
    player.setPosX(player.getPosX() + 50 * dt)
    player.setPosY(player.getPosY() + 50 * dt)
  end
  if angle >= -90 and angle < -45 then 
    player.setPosX(player.getPosX() + math.pi * dt)
    player.setPosY(player.getPosY() + 50 * dt)
  end
  if angle >= -135 and angle < -90 then 
    player.setPosX(player.getPosX() + math.pi * dt)
    player.setPosY(player.getPosY() - 50 * dt)
  end
  if angle <= 180 and angle < -135 then 
    player.setPosX(player.getPosX() + math.pi * dt)
    player.setPosY(player.getPosY() - 50 * dt)
  end
  if angle <= 180 and angle > 90 then 
    player.setPosX(player.getPosX() - math.pi * dt)
    player.setPosY(player.getPosY()- 50 * dt)
  end
  if angle <= 90 and angle > 45 then 
    player.setPosX(player.getPosX() - 50 * dt)
    player.setPosY(player.getPosY() + math.pi * dt)
  end
  if angle <= 45 and angle > 0 then 
    player.setPosX(player.getPosX() - math.pi * dt)
    player.setPosY(player.getPosY() + 50 * dt)
  end
end

return player
