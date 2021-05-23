local Boss = {}

local quadros = {}
local stage1 = {}
local stage2 = {}
local stage3 = {}
function Boss.createBoss()
Boss.x = love.graphics.getWidth()/2 - 128
Boss.y = love.graphics.getHeight()/2 - 128
Boss.pos = 0
Boss.cont = 0
Boss.quads = {}
Boss.walkleft = false
Boss.walkright = false
Boss.attack = false
Boss.static = true
Boss.throw = false


quadros.quadros = 256
quadros.timer = 0
quadros.row = 0
quadros.column = 0


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
stage3.cd = 0

Boss.life = {}
Boss.vida = 900
Boss.maxVida = 900
Boss.dmg = 50
Boss.animationController()
lifeMob.createLifeBoss(Boss.life, 20, 20, Boss.vida)

  love.graphics.setBackgroundColor(1, 1, 1)
  imgShot = love.graphics.newImage('uteis/imgs/Boss/cereja.png')
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
  love.graphics.print('quadros.timer: ' .. quadros.timer, 0, 105)
  love.graphics.print('FPS: ' .. love.timer.getFPS(), 0, 120)
  love.graphics.print('Cont: ' .. Boss.cont, 0, 135)
  love.graphics.print('Row: ' .. quadros.row, 0, 150)
  love.graphics.print('Column: ' .. quadros.column, 0, 165)
  love.graphics.print('Boss.pos: ' .. Boss.pos, 0, 180)
  love.graphics.setColor(1,1,1,1)
  love.graphics.draw(quadros.img, Boss.quads[Boss.pos], Boss.x, Boss.y)
  
  love.graphics.rectangle('line', stage1.shot.x - (stage1.shot.width / 2) + (quadros.quadros / 2), stage1.shot.y - (stage1.shot.heigth / 2) + (quadros.quadros / 2), stage1.shot.width, stage1.shot.heigth) -- hit box ataque stage1
  
  -- Pilar teste
  love.graphics.rectangle('fill', love.graphics.getWidth()/2 - 50 + 300, love.graphics.getHeight()/2 - 50, 100, 100)
  love.graphics.rectangle('fill', love.graphics.getWidth()/2 - 50 - 300, love.graphics.getHeight()/2 - 50, 100, 100)
  --/ Pilar teste
  
  for i, newshots in ipairs(stage2) do
    love.graphics.draw(newshots.img, newshots.x, newshots.y, newshots.angle, 1, 1, newshots.width, newshots.heigth)
  end
  
  for i, newshots in ipairs(stage3) do
    love.graphics.draw(newshots.img, newshots.x, newshots.y, newshots.angle, 1, 1, newshots.width, newshots.heigth)
  end
end


function Boss.getVida()
  return Boss.vida
end
function Boss.getMaxVida()
  return Boss.maxVida
end


function Boss.update(dt,player)
  Boss.animationController()
  Boss.bossSkills(dt,player)
  quadros.timer = quadros.timer + dt
  if quadros.timer > 0.15 then
    Boss.pos = Boss.pos + 1
    if Boss.pos == Boss.cont then
      Boss.pos = 0
    end
    quadros.timer = 0
  end
  
  
  if stage1.start then
    Boss.stageOne(dt,player)
    
  elseif stage2.start then
    if  Boss.x > (0 - (quadros.quadros/15)) and  Boss.y > (0 - (quadros.quadros/15)) then
      if Boss.x > (0 - (quadros.quadros/15)) then
        Boss.attack = false
        Boss.walkleft = true
        Boss.walkright = false
        Boss.static = false
        Boss.throw = false
        Boss.x = Boss.x - 150 * dt
      end
      if Boss.y > (0 - (quadros.quadros/15)) then
        Boss.y = Boss.y - 100 * dt
      end
    else
      Boss.stageTwo(dt)
    end
   
  elseif stage3.start then
    if math.floor(Boss.x) ~= love.graphics.getWidth()/2 - quadros.quadros / 2 and math.floor(Boss.y) ~= love.graphics.getHeight() / 2 - quadros.quadros / 2 then
      if math.floor(Boss.x) > love.graphics.getWidth()/2 - quadros.quadros / 2 then
        Boss.pos = 0
        Boss.attack = false
        Boss.walkleft = true
        Boss.walkright = false
        Boss.static = false
        Boss.throw = false
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
  
  if stage1.timer > 5 then
    Boss.attack = true
    Boss.walkleft = false
    Boss.walkright = false
    Boss.static = false
    Boss.throw = false
    
    if Boss.pos >= 10 then
      stage1.shot.width = 200
      stage1.shot.heigth = 200
      if(Boss.collider(player.getPosX(),player.getPosY(),player.getQuadro()/2,player.getQuadro()/2, stage1.shot.x,  stage1.shot.y, stage1.shot.width, stage1.shot.heigth)) then
        player.lifeBar().dano(Boss.dmg)
    end
    elseif Boss.pos == 0 then
      stage1.shot.width = 0
      stage1.shot.heigth = 0
      
      Boss.walkleft = false
      Boss.walkright = false
      Boss.throw = false
      Boss.static = true
      Boss.attack = false
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
    Boss.throw = false
    Boss.walkleft = false
    Boss.attack = false
    Boss.static = false
    Boss.walkright = true
    Boss.x = Boss.x + stage2.speed
  end
  if stage2.mov == false then
    if Boss.x < 0 then
      stage2.mov = true
    end
    Boss.throw = false
    Boss.walkleft = true
    Boss.static = false
    Boss.attack = false
    Boss.walkright = false
    Boss.x = Boss.x - stage2.speed
  end
  stage2.speed = stage2.speed + 0.008
  -- implementar se tomar hit stage2.speed = 1
  
  -- Ataques
  if stage2.timer > 5 then
    Boss.throw = true
    Boss.walkleft = false
    Boss.static = false
    Boss.attack = false
    Boss.walkright = false

    if Boss.pos == 9 then
      if stage2.cd > 0.1 then
        newshots = {x = Boss.x, y = Boss.y + 100, img = imgShot, angle = 0, width = imgShot:getWidth() / 2, heigth = imgShot:getHeight() / 2}
        table.insert(stage2, newshots)
        stage2.cd = 0
      end
    elseif Boss.pos == 0 then
      Boss.walkleft = true
      Boss.attack = false
      Boss.static = false
      Boss.throw = false
      Boss.walkright = false
      stage2.timer = 0
    end
  end
  stage2.timer = stage2.timer + dt
  stage2.cd = stage2.cd + dt
end

function Boss.stageThree(dt)
  if Boss.pos == 0 then
    Boss.throw = false
    Boss.walkleft = false
    Boss.attack = false
    Boss.static = true
    Boss.walkright = false
  end
  if stage3.timer > 5 and stage3.timer < 7 then
    Boss.throw = true
    Boss.walkleft = false
    Boss.attack = false
    Boss.static = false
    Boss.walkright = false
    if stage3.cd > 0.5 then
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
      stage3.cd = 0
    end
  elseif stage3.timer > 7 and Boss.pos == 0 then
    stage3.timer = 0
    Boss.throw = false
    Boss.walkleft = false
    Boss.attack = false
    Boss.static = true
    Boss.walkright = false
  end
  
  stage3.cd = stage3.cd + dt
  stage3.timer = stage3.timer + dt
end

function Boss.bossSkills(dt,player)
  for i, newshots in ipairs(stage2) do
    newshots.angle = newshots.angle + math.pi * dt
    newshots.y = newshots.y + (100 * dt)
    -- Teste de pilar
    if Boss.collider(love.graphics.getWidth()/2 + (300 - 50), love.graphics.getHeight()/2 - 50, 100, 100, newshots.x, newshots.y, newshots.width, newshots.heigth) then
      table.remove(stage2, i)
    end
    if Boss.collider(love.graphics.getWidth()/2 - (300 + 50), love.graphics.getHeight()/2 - 50, 100, 100, newshots.x, newshots.y, newshots.width, newshots.heigth) then
      table.remove(stage2, i)
    end
    if(Boss.collider(player.getPosX(),player.getPosY(),player.getQuadro()/2,player.getQuadro()/2,newshots.x, newshots.y, newshots.width, newshots.heigth)) then
        player.lifeBar().dano(Boss.dmg)
        table.remove(stage2, i)
    end
    -- /Teste de pilar
    if newshots.y > love.graphics.getHeight() + imgShot:getWidth() then -- tamanho do tiro
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
      if Boss.collider(love.graphics.getWidth()/2 + (300 - 50), love.graphics.getHeight()/2 - 50, 100, 100, newshots.x, newshots.y, newshots.width, newshots.heigth) then
        table.remove(stage3, i)
      end
      newshots.x = newshots.x + 100 * dt
    elseif newshots.id == 1 then
      if Boss.collider(love.graphics.getWidth()/2 - (300 + 50), love.graphics.getHeight()/2 - 50, 100, 100, newshots.x, newshots.y, newshots.width, newshots.heigth) then
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

function Boss.geraAnimacao(y, x, maxY, maxX, img)
  quadros.x = x
  quadros.y = y
  quadros.img = love.graphics.newImage(img)
  quadros.row = 0
  quadros.column = 0
  Boss.cont = 0
  
  for i = 0, quadros.y - 1 do
    quadros.row = i
    for l = 0, quadros.x - 1 do
      if l == maxX and i == maxY then
        break
      else
        Boss.quads[Boss.cont] = love.graphics.newQuad(l * quadros.quadros, i * quadros.quadros, quadros.quadros, quadros.quadros, quadros.img:getWidth(), quadros.img:getHeight())
      Boss.cont = Boss.cont + 1
      quadros.column = l
      end
    end
  end
end

function Boss.animationController()
  if Boss.walkleft == true and Boss.attack == false and Boss.throw == false and Boss.walkright == false and Boss.static == false then
    Boss.geraAnimacao(3, 3, 2, 1, 'uteis/imgs/Boss/bolo_walk_left.png')
  elseif Boss.walkleft == false and Boss.attack == false and Boss.throw == false and Boss.walkright == true and Boss.static == false then
    Boss.geraAnimacao(3, 3, 2, 1, 'uteis/imgs/Boss/bolo_walk_right.png')
  elseif Boss.throw == true and Boss.attack == false and Boss.walkleft == false and Boss.walkright == false and Boss.static == false then
    Boss.geraAnimacao(4, 3, 3, 1, 'uteis/imgs/Boss/bolo_atk_uma_cereja.png')
  elseif Boss.static == true and Boss.throw == false and Boss.attack == false and Boss.walkleft == false and Boss.walkright == false then
    Boss.geraAnimacao(3, 2, 3, 2, 'uteis/imgs/Boss/bolo_static.png')
  elseif Boss.attack == true and Boss.static == false and Boss.throw == false and Boss.walkleft == false and Boss.walkright == false then
    Boss.geraAnimacao(4, 3, 4, 3, 'uteis/imgs/Boss/bolo_atk_area.png')
  end
end

function Boss.collider(x1, y1, w1, h1, x2, y2, w2, h2)
  return x2 + w2 >= x1 and y2 + h2 >= y1 and x2 <= x1 + w1 and y2 <= y1 + h1
end
function Boss.dano(valor)
    -- monstro da tabela, dano
        if((Boss.vida - valor) <=0 ) then
          Boss.vida = 0
          lifeMob.setVida(Boss.life,Boss.vida)
          return false
        else
          Boss.vida = Boss.vida - valor
          lifeMob.setVida(Boss.life,Boss.vida)
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

return Boss