local Boss = {}

local quadros = {}
local stage1 = {}
local stage2 = {}
local stage3 = {}
local retangulo1 = nil
local retangulo2 = nil
local Q = love.graphics.newQuad

ataque1sound = love.audio.newSource("uteis/sounds/BoosSoundEffect.wav", "static")
ataque1sound:setLooping(false)
ataque1sound:setVolume(0.1)

ataque2sound = love.audio.newSource("uteis/sounds/bossAtaque2.wav", "static")
ataque2sound:setLooping(false)
ataque2sound:setVolume(0.1)

damageSound = love.audio.newSource("uteis/sounds/bossDmg.wav", "static")
damageSound:setLooping(false)
damageSound:setVolume(0.5)

hc = require 'uteis/HC'
anim8 = require 'uteis/anim8'

function Boss.createBoss(gameState)

Boss.x = love.graphics.getWidth()/2 - 128
Boss.y = love.graphics.getHeight()/2 - 128

Boss.img = love.graphics.newImage('uteis/imgs/Boss/BossImage.png')
Boss.damageTimer = 0

quadros.quadros = 256
Boss.colisao = nil

Boss.frameTimer = 0.146
Boss.animationController = 'static'
Boss.animationControll = anim8.newGrid(quadros.quadros, quadros.quadros, Boss.img:getWidth(), Boss.img:getHeight())
Boss.animation = {}
Boss.animation['walkleft'] = anim8.newAnimation(Boss.animationControll('1-7', 4), Boss.frameTimer)
Boss.animation['walkright'] = anim8.newAnimation(Boss.animationControll('1-7', 5), Boss.frameTimer)
Boss.animation['attack'] = anim8.newAnimation(Boss.animationControll('1-12', 1), Boss.frameTimer)
Boss.animation['static'] = anim8.newAnimation(Boss.animationControll('1-6', 3), Boss.frameTimer)
Boss.animation['throw'] = anim8.newAnimation(Boss.animationControll('1-10', 2), Boss.frameTimer)
Boss.animation['damage'] = anim8.newAnimation(Boss.animationControll('1-3', 6), Boss.frameTimer)
Boss.frameTimerAttack = 0
Boss.frameTimerthrow = 0

stage1.start = false
stage1.timer = 0
stage1.shot = {width = 0, heigth = 0, x = Boss.x, y = Boss.y}

stage2.start = false
stage2.timer = 0
stage2.mov = true
stage2.cd = 0
stage2.speed = 1

stage3.start = false
stage3.timer = 0
stage3.throwQnt = 0
stage3.cd = 0

Boss.life = {}
Boss.vida = 900
Boss.maxVida = 900
Boss.dmg = 50

lifeMob.createLifeBoss(Boss.life, 20, 20, Boss.vida)

  love.graphics.setBackgroundColor(1, 1, 1)
  imgShot = love.graphics.newImage('uteis/imgs/Boss/cereja.png')
end

function Boss.criaColisao()
    retangulo1 = hc.rectangle(love.graphics.getWidth()/2 - 50 + 405, love.graphics.getHeight()/2 - 155, 100, 280)
    retangulo2 = hc.rectangle(love.graphics.getWidth()/2 - 50 - 415, love.graphics.getHeight()/2 - 50, 105, 220)
    Boss.colisao = hc.rectangle(Boss.x,Boss.y,quadros.quadros/3,quadros.quadros/3)
end


function Boss.draw()
  
  --love.graphics.setBackgroundColor(1, 1, 1)
  --love.graphics.setColor(1, 0, 0)
  lifeMob.draw(Boss.life)
  love.graphics.setColor(1,1,1,0)
  love.graphics.print('tempo stage 2: ' .. stage2.timer, 0, 15)
  love.graphics.print('X: ' .. Boss.x, 0, 45)
  love.graphics.print('Y: ' .. Boss.y, 0, 60)
  love.graphics.print('tempo stage 1: ' .. stage1.timer)
  love.graphics.print('tempo stage 3: ' .. stage3.timer, 0, 30)
  love.graphics.print('valor necessario x: ' .. 0 - (quadros.quadros/15), 0, 75)
  love.graphics.print('valor necessario y: ' .. 0 - (quadros.quadros/15), 0, 90)
  love.graphics.print('FPS: ' .. love.timer.getFPS(), 0, 120)
  love.graphics.setColor(1,1,1,1)

  if Boss.animationController == 'walkleft' then Boss.animation['walkleft']:draw(Boss.img, Boss.x, Boss.y, 0, 1, 1, 0, 0)
  elseif Boss.animationController == 'walkright' then Boss.animation['walkright']:draw(Boss.img, Boss.x, Boss.y, 0, 1, 1, 0, 0)
  elseif Boss.animationController == 'attack' then Boss.animation['attack']:draw(Boss.img, Boss.x, Boss.y, 0, 1, 1, 0, 0)
  elseif Boss.animationController == 'static' then Boss.animation['static']:draw(Boss.img, Boss.x, Boss.y, 0, 1, 1, 0, 0)
  elseif Boss.animationController == 'throw' then Boss.animation['throw']:draw(Boss.img, Boss.x, Boss.y, 0, 1, 1, 0, 0)
  elseif Boss.animationController == 'damage' then Boss.animation['damage']:draw(Boss.img, Boss.x, Boss.y, 0, 1, 1, 0, 0) end

  --Boss.colisao:draw()
  
  for i, newshots in ipairs(stage2) do
    love.graphics.draw(newshots.img, newshots.x, newshots.y, newshots.angle, 1, 1, newshots.width, newshots.heigth)
  end
  
  for i, newshots in ipairs(stage3) do
    love.graphics.draw(newshots.img, newshots.x, newshots.y, newshots.angle, 1, 1, newshots.width + 10, newshots.heigth)
  end
end

function Boss.getVida()
  return Boss.vida
end

function Boss.getMaxVida()
  return Boss.maxVida
end

function Boss.update(dt,player)

  Boss.colisao:moveTo(Boss.x + quadros.quadros / 2, Boss.y + quadros.quadros / 2)
  Boss.bossSkills(dt, player)

  if Boss.animationController == 'walkleft' then 
    Boss.animation['walkleft']:update(dt)
  elseif Boss.animationController == 'walkright' then
    Boss.animation['walkright']:update(dt)
  elseif Boss.animationController == 'attack' then
    Boss.animation['attack']:update(dt)
  elseif Boss.animationController == 'static' then
    Boss.animation['static']:update(dt)
  elseif Boss.animationController == 'throw' then
    Boss.animation['throw']:update(dt)
  elseif Boss.animationController == 'damage' then
    Boss.animation['damage']:update(dt)
  end
  
  if stage1.start then
    Boss.stageOne(dt,player)
    
  elseif stage2.start then
    if  Boss.x > (0 - (quadros.quadros/15)) and  Boss.y > (0 - (quadros.quadros/15)) then
      if Boss.x > (0 - (quadros.quadros/15)) then
        Boss.animationController = 'walkleft'
        Boss.x = Boss.x - 150 * dt
      end
      if Boss.y > (0 - (quadros.quadros/15)) then
        Boss.y = Boss.y - 110 * dt
      end
    else
      Boss.stageTwo(dt)
    end
   
  elseif stage3.start then
    if math.floor(Boss.x) ~= love.graphics.getWidth()/2 - quadros.quadros / 2 and math.floor(Boss.y) ~= love.graphics.getHeight() / 2 - quadros.quadros / 2 then
      if math.floor(Boss.x) > love.graphics.getWidth()/2 - quadros.quadros / 2 then
        if Boss.x < love.graphics.getWidth() / 2 - quadros.quadros / 2 then
          Boss.animationController = 'walkright'
        else Boss.animationController = 'walkleft' end
        Boss.x = Boss.x - 201 * dt
      else
        Boss.x = Boss.x + 201 * dt
      end
      if math.floor(Boss.y) < love.graphics.getHeight() / 2 - quadros.quadros / 2 then
        Boss.y = Boss.y + 150 * dt
      end
    else
      Boss.stageThree(dt)
    end
  end
  
end

-- Troca de fases do boss
-- Trocar para condição de vida
function love.keypressed(tecla)
  if tecla == "n" then
  elseif tecla == "m" then
  elseif tecla == "p" then
  end
end

function Boss.setStageOne()
  stage1.start = true
end
function Boss.setStageTwo()
  stage1.start = false
  stage2.start = true
end
function Boss.setStageThree()
  stage2.start = false
  stage3.start = true
end

function Boss.stageOne(dt,player)
  stage1.timer = stage1.timer + dt
  if stage1.timer > 3 then
    Boss.animationController = 'attack'
    Boss.frameTimerAttack = Boss.frameTimerAttack + dt

    if Boss.frameTimerAttack >= Boss.frameTimer * 10 and Boss.frameTimerAttack < Boss.frameTimer * 12 then
      stage1.shot.width = 200
      stage1.shot.heigth = 200
      ataque1sound:play()
      if(Boss.collider(player.getPosX(),player.getPosY(),player.getQuadro()/2,player.getQuadro()/2, stage1.shot.x,  stage1.shot.y, stage1.shot.width, stage1.shot.heigth)) then
        player.lifeBar().dano(Boss.dmg)
      end
    elseif Boss.frameTimerAttack >= Boss.frameTimer * 12 then
      Boss.animation['attack']:gotoFrame(1)
      stage1.shot.width = 0
      stage1.shot.heigth = 0
      Boss.frameTimerAttack = 0
      Boss.animationController = 'static'

      stage1.timer = 0
    end
  end
end

function Boss.stageTwo(dt)
  -- Movimentação
  if stage2.mov then
    if Boss.x > love.graphics.getWidth() - quadros.quadros then
      stage2.mov = false
    end
    
    Boss.animationController = 'walkright'
    Boss.x = Boss.x + stage2.speed
  end
  if stage2.mov == false then
    if Boss.x < 0 then
      stage2.mov = true
    end

    Boss.animationController = 'walkleft'
    Boss.x = Boss.x - stage2.speed
  end
  stage2.speed = stage2.speed + 0.008

  if stage2.timer > 2 then
    Boss.animationController = 'throw'
    Boss.frameTimerthrow = Boss.frameTimerthrow + dt

    if Boss.frameTimerthrow >= Boss.frameTimer * 9 and Boss.frameTimerthrow < Boss.frameTimer * 10 then
      if stage2.cd > 0.1 then
        newshots = {x = Boss.x, y = Boss.y + 100, img = imgShot, angle = 0, width = imgShot:getWidth() / 2, heigth = imgShot:getHeight() / 2}
        table.insert(stage2, newshots)
        ataque2sound:play()
        stage2.cd = 0
      end
    elseif Boss.frameTimerthrow >= Boss.frameTimer * 10 then
      Boss.animation['throw']:gotoFrame(1)
      Boss.frameTimerthrow = 0
      Boss.animationController = 'walkleft'
      stage2.timer = 0
    end
  end
  stage2.timer = stage2.timer + dt
  stage2.cd = stage2.cd + dt
end

function Boss.stageThree(dt)
  Boss.animationController = 'static'
  
  if stage3.timer > 5 then
    Boss.animationController = 'throw'
    Boss.frameTimerthrow = Boss.frameTimerthrow + dt

    if stage3.cd > 0.5 and Boss.frameTimerthrow >= Boss.frameTimer * 9 then
      newshots = {id = 0, x = Boss.x + (quadros.quadros - imgShot:getWidth()), y = Boss.y + quadros.quadros / 2, angle = 0, width = imgShot:getWidth(), heigth = imgShot:getHeight(), img = imgShot}
      table.insert(stage3, newshots)
      
      newshots = {id = 1, x = Boss.x + imgShot:getWidth(), y = Boss.y + quadros.quadros / 2, angle = 0, width = imgShot:getWidth(), heigth = imgShot:getHeight(), img = imgShot}
      table.insert(stage3, newshots)
      newshots = {id = 2, x = Boss.x + quadros.quadros / 2, y = Boss.y + imgShot:getHeight(), angle = 0, width = imgShot:getWidth(), heigth = imgShot:getHeight(), img = imgShot}
      table.insert(stage3, newshots)
      newshots = {id = 3, x = Boss.x + quadros.quadros / 2, y = Boss.y + (quadros.quadros - imgShot:getHeight()), angle = 0, width = imgShot:getWidth(), heigth = imgShot:getHeight(), img = imgShot}
      table.insert(stage3, newshots)
      newshots = {id = 4, x = Boss.x + (quadros.quadros - imgShot:getWidth()), y = Boss.y + (quadros.quadros - imgShot:getHeight()), angle = 0, width = imgShot:getWidth(), heigth = imgShot:getHeight(), img = imgShot}
      table.insert(stage3, newshots)
      newshots = {id = 5, x = Boss.x + imgShot:getWidth(), y = Boss.y + (quadros.quadros - imgShot:getHeight()), angle = 0, width = imgShot:getWidth(), heigth = imgShot:getHeight(), img = imgShot}
      table.insert(stage3, newshots)
      newshots = {id = 6, x = Boss.x + imgShot:getWidth(), y = Boss.y + imgShot:getHeight(), angle = 0, width = imgShot:getWidth(), heigth = imgShot:getHeight(), img = imgShot}
      table.insert(stage3, newshots)
      newshots = {id = 7, x = Boss.x + (quadros.quadros - imgShot:getWidth()), y = Boss.y + imgShot:getHeight(), angle = 0, width = imgShot:getWidth(), heigth = imgShot:getHeight(), img = imgShot}
      table.insert(stage3, newshots)
      ataque2sound:play()
      stage3.cd = 0
      stage3.throwQnt = stage3.throwQnt + 1
      if stage3.throwQnt >= 10 then
        stage3.timer = 0
        Boss.animation['throw']:gotoFrame(1)
        Boss.animationController = 'static'
        Boss.frameTimerthrow = 0
        stage3.throwQnt = 0
      end
    end
  end
  
  stage3.cd = stage3.cd + dt
  stage3.timer = stage3.timer + dt
end

function Boss.bossSkills(dt,player)
  for i, newshots in ipairs(stage2) do
    newshots.angle = newshots.angle + math.pi * dt
    newshots.y = newshots.y + (100 * dt)

    -- Teste de pilar
    if Boss.collider(love.graphics.getWidth()/2 - 50 + 405, love.graphics.getHeight()/2 - 155, 100, 280, newshots.x, newshots.y, newshots.width, newshots.heigth) then
      table.remove(stage2, i)
    end
    if Boss.collider(love.graphics.getWidth()/2 - 50 - 415, love.graphics.getHeight()/2 - 50, 105, 220, newshots.x, newshots.y, newshots.width, newshots.heigth) then
      table.remove(stage2, i)
    end
    if(Boss.collider(player.getPosX(),player.getPosY(),player.getQuadro()/2,player.getQuadro()/2,newshots.x, newshots.y, newshots.width, newshots.heigth)) then
        player.lifeBar().dano(Boss.dmg)
        table.remove(stage2, i)
    end
    -- /Teste de pilar
    if newshots.y > love.graphics.getHeight() + imgShot:getWidth() then
      table.remove(stage2, i)
    end
  end
  
  for i, newshots in ipairs(stage3) do
    if(Boss.collider(player.getPosX(),player.getPosY(),player.getQuadro()/2,player.getQuadro()/2,newshots.x, newshots.y, newshots.width, newshots.heigth)) then
        player.lifeBar().dano(Boss.dmg)
        table.remove(stage3, i)
    end
    newshots.angle = newshots.angle + math.pi * dt
    if newshots.id == 0 then
      if Boss.collider(love.graphics.getWidth()/2 - 50 + 405, love.graphics.getHeight()/2 - 155, 100, 280, newshots.x, newshots.y, newshots.width, newshots.heigth) then
        table.remove(stage3, i)
      end
      newshots.x = newshots.x + 100 * dt
    elseif newshots.id == 1 then
      if Boss.collider(love.graphics.getWidth()/2 - 50 - 415, love.graphics.getHeight()/2 - 50, 105, 220, newshots.x, newshots.y, newshots.width, newshots.heigth) then
        table.remove(stage3, i)
      end
      newshots.x = newshots.x - 100 * dt
    elseif newshots.id == 2 then
      newshots.y = newshots.y - 100 * dt
    elseif newshots.id == 3 then
      newshots.y = newshots.y + 100 * dt
    elseif newshots.id == 4 then
      newshots.x = newshots.x + 100 * dt
      newshots.y = newshots.y + 100 * dt
    elseif newshots.id == 5 then
      newshots.x = newshots.x - 100 * dt
      newshots.y = newshots.y + 100 * dt
    elseif newshots.id == 6 then
      newshots.x = newshots.x - 100 * dt
      newshots.y = newshots.y - 100 * dt
    elseif newshots.id == 7 then
      newshots.x = newshots.x + 100 * dt
      newshots.y = newshots.y - 100 * dt
    end
    if newshots.x > love.graphics.getWidth() - newshots.width and newshots.y > love.graphics.getHeight() - newshots.heigth then
      table.remove(stage3, i)
    end
  end
end

function Boss.collider(x1, y1, w1, h1, x2, y2, w2, h2)
  return x2 + w2 >= x1 and y2 + h2 >= y1 and x2 <= x1 + w1 and y2 <= y1 + h1
end

function Boss.dano(valor)
  
  if stage1.start or stage3.start and Boss.damageTimer > 5 then
    damageSound:play()
    Boss.animationController = 'damage'
    Boss.animation['throw']:gotoFrame(3)
    Boss.damageTimer = 0
    
  end
 
  -- monstro da tabela, dano
  if((Boss.vida - valor) <=0 ) then
    Boss.vida = 0
    lifeMob.setVida(Boss.life, Boss.vida)
    return false
  else
    Boss.vida = Boss.vida - valor
    lifeMob.setVida(Boss.life, Boss.vida)
    return true
  end
end

function Boss.ataque(player) 
  if(player.status == 'caminhando') then
    if((Boss.x < player.getPosX() + player.getQuadro()) and (Boss.x + quadros.quadros > player.getPosX()) and (Boss.y < player.getPosY() + player.getQuadro()) and (Boss.y + quadros.quadros > player.getPosY())) then
      player.posicaoAtaque()
      return true
    else 
      player.posicaoAtaque()
      return false
    end
  end
end

function Boss.vivo() 
  if(Boss.vida > 0) then
    return true
  else
    return false
  end
end

function Boss.isStage2Collision()
  return stage2.start
end

return Boss
