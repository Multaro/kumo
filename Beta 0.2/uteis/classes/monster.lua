local lifeMob = require("uteis.classes.lifeMob")
local id = 0
local sleepTime = 0
local monster = {}


function monster.createMonster(mob,nome,img,posX,posY,atq,vida)
--monster.createMonster(mob da tabela, nome do monstro, caminho da imagem, posição x, posição Y, dano do monstro, vida do monstro)    
    id = id+1
    mob.item = {}
    mob.nome = nome
    mob.id = id
    mob.img = love.graphics.newImage(img)
    mob.atq = atq
    mob.vida = vida
    mob.posX = posX
    mob.posY = posY
    mob.life = {}
    lifeMob.createLife(mob.life,posX,posY,vida,mob.img:getWidth())
    monster.setVisao(mob)
    return mob
  end





  
  function monster.draw(mob,fonte)
  -- monster.draw(mob da tabela,fonte para o nome do monstro)  
    nomeSizeX = fonte:getWidth(mob.nome) - mob.img:getWidth()
    nomeSizeX = mob.posX - (nomeSizeX / 2)
    lifeMob.draw(mob.life)
    love.graphics.setColor(2/255,218/255,125/255,1)
    nomePosY = lifeMob.getPosY(mob.life) - fonte:getHeight(mob.nome)
    love.graphics.print(mob.nome,nomeSizeX,nomePosY)
    lifeMob.updatePos(mob.life,mob.posX,mob.posY,mob.img:getWidth())
    love.graphics.setColor(1,1,1,1)
    love.graphics.draw(mob.img, mob.posX, mob.posY)

  end

  function monster.getImage(mob)
    return mob.img
  end
  function monster.setImage(mob,caminho)
     mob.img = love.graphics.newImage(caminho)
  end
  
  function monster.getAtq(mob)
    return mob.atq
  end
  function monster.setAtq(mob,atq)
    mob.atq = atq
  end
  
  
  function monster.getVida(mob)
    return mob.vida
  end
  function monster.setVida(mob,vida)
    mob.vida = vida
    lifeMob.setVida(mob.life,vida)
  end
  
  function monster.getPosX(mob)
    return mob.posX
  end
  function monster.setPosX(mob,posX)
    mob.posX = posX
    mob.setVisao()
  end
  
  function monster.getPosY(mob)
    return mob.posY
  end
  function monster.setPosY(mob,posY)
    mob.posY = posY
    mob.setVisao()
  end

  function monster.setVisao(mob)
    mob.tamVisaoX = img:getWidth() * 5
    mob.tamVisaoY = img:getHeight() * 5
    mob.visaoPosX = mob.posX - (mob.tamVisaoX / 2)
    mob.visaoPosY = mob.posY - (mob.tamVisaoY / 2)
  end

  function monster.visaoMob(mob,playerX,playerY,playerWidth,playerHeight)
-- mob da tabela, posição X do player, posição Y do player, largura, altura, velocidade, dt (update))
    if((mob.visaoPosX < playerX + playerWidth) and (mob.visaoPosX + mob.tamVisaoX > playerX) and (mob.visaoPosY < playerY + playerHeight) and (mob.visaoPosY + mob.tamVisaoY > playerY)) then
        return true
      else
        return false
    end
  
  end

  function monster.colisaoMob(mob,playerX,playerY,playerWidth,playerHeight,dt)
-- mob da tabela, posição X do player, posição Y do player, largura, altura, velocidade, dt (update))    
    if(mob.posX < (playerX + playerWidth) and ((mob.posX + mob.img:getWidth()) > playerX) and (mob.posY < (playerY + playerHeight)) and ((mob.posY + mob.img:getHeight()) > playerY)) then
       
        return true
    else
        return false
  end
  
  end

  function monster.movimenta(mob,playerX,playerY,playerWidth,playerHeight,medidaMoviemento,dt)
-- mob da tabela, posição X do player, posição Y do player, largura, altura, velocidade, dt (update))
    if((monster.visaoMob(mob,playerX,playerY,playerWidth,playerHeight) == true)and(monster.colisaoMob(mob,playerX,playerY,playerWidth,playerHeight,dt) == false)) then
          if(mob.posX > playerX) then
            mob.posX = mob.posX - medidaMoviemento * dt
          elseif(mob.posX < playerX) then
            mob.posX = mob.posX + medidaMoviemento * dt
          end
          if(mob.posY > playerY) then
            mob.posY = mob.posY - medidaMoviemento * dt
          elseif(mob.posY < playerY) then
            mob.posY = mob.posY + medidaMoviemento * dt
          end
    elseif(monster.colisaoMob(mob,playerX,playerY,playerWidth,playerHeight,dt) == false) then
     sleepTime = sleepTime + dt
      if(sleepTime > 1) then
 
        randomNumber = love.math.random(1, 4)
          if(randomNumber == 1 and monster.colisaoBorda(mob.posX,mob.posY,mob.img:getWidth(),mob.img:getHeight(),"left")) then
                  mob.posX = mob.posX - (medidaMoviemento * 10)* dt

                end
                
          if(randomNumber == 2 and monster.colisaoBorda(mob.posX,mob.posY,mob.img:getWidth(),mob.img:getHeight(),"right")) then
                  mob.posX = mob.posX + (medidaMoviemento * 10) * dt

                end
                
          if(randomNumber == 3 and monster.colisaoBorda(mob.posX,mob.posY,mob.img:getWidth(),mob.img:getHeight(),"up")) then
                  mob.posY = mob.posY - (medidaMoviemento * 10) * dt
        
                end
                
          if(randomNumber == 4 and monster.colisaoBorda(mob.posX,mob.posY,mob.img:getWidth(),mob.img:getHeight(),"down")) then
                  mob.posY = mob.posY + (medidaMoviemento * 10) * dt
                  
                end
                sleepTime = 0
          end
          lifeMob.updatePos(mob.life,mob.posX,mob.posY,mob.img:getWidth())
          monster.setVisao(mob)
           
      end
      return false
      
  end

  function monster.colisaoBorda(posX,posY,width,height,direcao)
-- posição X do monstro, posição Y do monstro, largura, altura, direção)
    windowHeight = love.graphics.getHeight() 
    windowWidth = love.graphics.getWidth() 
     if((posX + width> windowWidth and direcao == "right") or ((posY + height > windowHeight) and direcao == "down") or ((posX < 0) and direcao == "left") or ((posY < 0) and direcao == "up")) then
          return false
    else 
      return true
  end
end

function monster.dano(mob,valor)
-- monstro da tabela, dano
    if((mob.vida - valor) <=0 ) then
      mob.vida = 0
      lifeMob.setVida(mob.life,mob.vida)
      return false
    else
      mob.vida = mob.vida - valor
      lifeMob.setVida(mob.life,mob.vida)
      return true
    end
  end

  function monster.ataque(mob,posX,posY,width,height) 
  -- verifica se o monstro pode ou não atacar
  -- monstro da tabela, posição X, posição Y, largura, altura
    if((mob.posX < posX + width) and (mob.posX + mob.img:getWidth() > posX) and (mob.posY < posY + height) and (mob.posY + mob.img:getHeight() > posY)) then
        return true
      else 
        return false
    end
  end

  return monster