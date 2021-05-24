local lifeMob = require("uteis.classes.lifeMob")
local hc = require 'HC'
local id = 0
local item = require("uteis.classes.itens") -- Import itens
local monster = {}
local Q = love.graphics.newQuad
local drops = {}

function monster.createMonster(mob,nome,img,quadro,posX,posY,atq,vida)
--monster.createMonster(mob da tabela, nome do monstro, caminho da imagem, posição x, posição Y, dano do monstro, vida do monstro)    
    id = id+1
    
    mob.status = 'caminhando'
    mob.sleepTimeVisao = 0
    mob.sleepMain = 0
    mob.item = {}
    mob.nome = nome
    mob.id = id
    mob.img = love.graphics.newImage(img)
    mob.atq = atq
    mob.vida = vida
    mob.posX = posX
    mob.posY = posY
    mob.life = {}
    mob.posMax = 0
    mob.sleepTime = 0
    mob.sleepTimePos = 0
    mob.pos = 1
    mob.img:setFilter("nearest","linear")
    mob.quadro = quadro -- tamanho quadro em px
    mob.qtdQuadrosX = mob.img:getWidth() / quadro
    mob.qtdQuadrosY = mob.img:getHeight() / quadro
      if(mob.qtdQuadrosX == 0) then
        mob.qtdQuadrosX = 1
      end
      if(mob.qtdQuadrosY == 0) then
        mob.qtdQuadrosX = 1
      end
    mob.Quadros = {}
    mob.direcao = 'down'
    mob.Quadros['up'] = {}
    mob.Quadros['down']= {}
    mob.Quadros['left'] = {}
    mob.Quadros['right'] = {}
    mob.Quadros['atqUp'] = {}
    mob.Quadros['atqDown']= {}
    mob.Quadros['atqLeft'] = {}
    mob.Quadros['atqRight'] = {}
    mob.qtdQuadros = mob.qtdQuadrosX * mob.qtdQuadrosY
    mob.hitBox = nil
    lifeMob.createLife(mob.life,posX,posY,vida,mob.img:getWidth())
    monster.setVisao(mob)



         
        local y = 0
        for x = 0, (mob.qtdQuadrosX - 2) do
          mob.Quadros['down'][x+1] = Q((x * mob.quadro), (y * mob.quadro),mob.quadro,mob.quadro,mob.img:getWidth(),mob.img:getHeight())
        end
        y = y+1
        for x = 0, (mob.qtdQuadrosX - 2) do
          mob.Quadros['right'][x+1] = Q((x * mob.quadro), (y * mob.quadro),mob.quadro,mob.quadro,mob.img:getWidth(),mob.img:getHeight())
        end
        y = y+1
        for x = 0, (mob.qtdQuadrosX - 2) do
          mob.Quadros['left'][x+1] = Q((x * mob.quadro), (y * mob.quadro),mob.quadro,mob.quadro,mob.img:getWidth(),mob.img:getHeight())
        end
        y = y+1
        for x = 0, (mob.qtdQuadrosX - 4) do
          mob.Quadros['up'][x+1] = Q((x * mob.quadro), (y * mob.quadro),mob.quadro,mob.quadro,mob.img:getWidth(),mob.img:getHeight())
        end
        y = y+1
        for x = 0, (mob.qtdQuadrosX - 2) do
          mob.Quadros['atqDown'][x+1] = Q((x * mob.quadro), (y * mob.quadro),mob.quadro,mob.quadro,mob.img:getWidth(),mob.img:getHeight())
        end
        y = y+1
        for x = 0, (mob.qtdQuadrosX - 1) do
          mob.Quadros['atqRight'][x+1] = Q((x * mob.quadro), (y * mob.quadro),mob.quadro,mob.quadro,mob.img:getWidth(),mob.img:getHeight())
        end
        y = y+1
        for x = 0, (mob.qtdQuadrosX - 1) do
          mob.Quadros['atqLeft'][x+1] = Q((x * mob.quadro), (y * mob.quadro),mob.quadro,mob.quadro,mob.img:getWidth(),mob.img:getHeight())
        end
        y = y+1
        for x = 0, (mob.qtdQuadrosX - 1) do
          mob.Quadros['atqUp'][x+1] = Q((x * mob.quadro), (y * mob.quadro),mob.quadro,mob.quadro,mob.img:getWidth(),mob.img:getHeight())
        end



         
  


    return mob
  end





  
  function monster.draw(mob,fonte,dt)
    
  -- monster.draw(mob da tabela,fonte para o nome do monstro)  
    nomeSizeX = fonte:getWidth(mob.nome) - mob.quadro
    nomeSizeX = mob.posX - (nomeSizeX / 2)
    lifeMob.draw(mob.life)
    love.graphics.setColor(2/255,218/255,125/255,1)
    nomePosY = lifeMob.getPosY(mob.life) - fonte:getHeight(mob.nome)
    love.graphics.print(mob.nome,nomeSizeX,nomePosY)
    lifeMob.updatePos(mob.life,mob.posX,mob.posY,mob.quadro)
    love.graphics.setColor(1,1,1,1)
    for i, itensDropados in ipairs(drops) do
      item.Draw(itensDropados,1,dt) 
    end
    
                love.graphics.draw(mob.img,mob.Quadros[mob.direcao][mob.pos],mob.posX,(mob.posY))



  

  end

  function monster.getColisaoX(mob) 
    return monster.getPosX(mob)+monster.getQuadro(mob)/4
   end
   function monster.getColisaoWidth(mob) 
    return monster.getQuadro(mob)/2
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
  function monster.getHitBox(mob)
    return mob.hitBox
  end
  function monster.setAtq(mob,atq)
    mob.atq = atq
  end
  
  function monster.getQuadro(mob)
    return mob.quadro
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
    monster.setVisao(mob)
  end
  
  function monster.getPosY(mob)
    return mob.posY
  end
  function monster.setPosY(mob,posY)
    mob.posY = posY
    monster.setVisao(mob)
  end

  function monster.criaColisao(mob)
     mob.hitBox = hc.rectangle(monster.getPosX(mob),monster.getPosY(mob),monster.getColisaoWidth(mob),monster.getQuadro(mob)/2)
  end



  function monster.setVisao(mob)
    mob.tamVisaoX = mob.quadro * 5
    mob.tamVisaoY = mob.quadro * 5
    if(mob.tamVisaoX < 200) then
      mob.tamVisaoX = 200
      mob.tamVisaoY = 200
    end

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
    if(mob.posX < (playerX + playerWidth) and ((mob.posX + mob.quadro/2) > playerX) and (mob.posY < (playerY + playerHeight)) and ((mob.posY + mob.quadro/2) > playerY)) then
       
        return true
    else
        return false
  end
  
  end

  function monster.movimenta(mob,playerX,playerY,playerWidth,playerHeight,medidaMoviemento,dt,podeAtacar)
if(mob.status == 'caminhando') then
 if(podeAtacar == true) then
-- mob da tabela, posição X do player, posição Y do player, largura, altura, velocidade, dt (update))
    if((monster.visaoMob(mob,playerX,playerY,playerWidth,playerHeight) == true)and(monster.colisaoMob(mob,playerX,playerY,playerWidth/2,playerHeight/2,dt) == false)) then
      mob.sleepTimeVisao = mob.sleepTimeVisao + dt
      if(mob.sleepTimeVisao > 0.2) then   

  
            if((( mob.posX - (medidaMoviemento * 10)* dt) < playerX) and (( mob.posX + (medidaMoviemento * 10)* dt) > playerX)) then
              if(mob.posY > playerY) then
                if(mob.direcao == 'up') then
                  mob.pos = mob.pos + 1
                  mob.posMax = 5
                  mob.posY = mob.posY - (medidaMoviemento * 10)* dt
                else
                  mob.pos = 1
                  mob.posMax = 5
                  mob.direcao = 'up'
                  mob.posY = mob.posY - (medidaMoviemento * 10)* dt
                end   
                
              elseif(mob.posY < playerY) then
                if(mob.direcao == 'down') then
                  mob.pos = mob.pos + 1
                  mob.posMax = 7
                  mob.posY = mob.posY + (medidaMoviemento * 10)* dt
                else
                  mob.pos = 1
                  mob.direcao = 'down'
                  mob.posMax = 7
                  mob.posY = mob.posY + (medidaMoviemento * 10)* dt
                end
              end
            

          elseif(mob.posX > playerX) then
            if(mob.direcao == 'left') then
              mob.pos = mob.pos + 1
              mob.posMax = 7
              mob.posX = mob.posX - (medidaMoviemento * 10)* dt
            else
              mob.pos = 1
              mob.posMax = 7
              mob.direcao = 'left'
              mob.posX = mob.posX - (medidaMoviemento * 10)* dt
            end
           
          elseif(mob.posX < playerX) then
            if(mob.direcao == 'right') then
              mob.pos = mob.pos + 1
              mob.posMax = 7
              mob.posX = mob.posX + (medidaMoviemento * 10)* dt
            else
              mob.pos = 1
              mob.direcao = 'right'  
              mob.posMax = 7
              mob.posX = mob.posX + (medidaMoviemento * 10)* dt
            end
            
         
          
        elseif(mob.posY > playerY) then
            if(mob.direcao == 'up') then
              mob.pos = mob.pos + 1
              mob.posMax = 5
              mob.posY = mob.posY - (medidaMoviemento * 10)* dt
            else
              mob.pos = 1
              mob.posMax = 5
              mob.direcao = 'up'
              mob.posY = mob.posY - (medidaMoviemento * 10)* dt
            end   
            
          elseif(mob.posY < playerY) then
            if(mob.direcao == 'down') then
              mob.pos = mob.pos + 1
              mob.posMax = 7
              mob.posY = mob.posY + (medidaMoviemento * 10)* dt
            else
              mob.pos = 1
              mob.direcao = 'down'
              mob.posMax = 7
              mob.posY = mob.posY + (medidaMoviemento * 10)* dt
            end
          end
          
          mob.sleepTimeVisao = 0
          end
    elseif(monster.colisaoMob(mob,playerX,playerY,playerWidth,playerHeight,dt) == false) then
      mob.sleepTime = mob.sleepTime + dt
      if(mob.sleepTime > 1) then
        randomNumber = love.math.random(1, 4)
          if(randomNumber == 1 and monster.colisaoBorda(mob.posX,mob.posY,mob.quadro,mob.quadro,"left")) then
            if(mob.direcao == 'left') then
              mob.pos = mob.pos + 1
              mob.posMax = 7
              mob.posX = mob.posX - (medidaMoviemento * 10)* dt
            else
              mob.pos = 1
              mob.direcao = 'left'
              mob.posMax = 7
              mob.posX = mob.posX - (medidaMoviemento * 10)* dt
            end

          end
                
          if(randomNumber == 2 and monster.colisaoBorda(mob.posX,mob.posY,mob.quadro,mob.quadro,"right")) then
                if(mob.direcao == 'right') then
                  mob.pos = mob.pos + 1
                  mob.posMax = 7
                  mob.posX = mob.posX + (medidaMoviemento * 10) * dt
                else
                  mob.pos = 1
                  mob.direcao = 'right'  
                  mob.posMax = 7
                  mob.posX = mob.posX + (medidaMoviemento * 10) * dt
                end
                
               

           end
                
          if(randomNumber == 3 and monster.colisaoBorda(mob.posX,mob.posY,mob.quadro,mob.quadro,"up")) then
              if(mob.direcao == 'up') then
                mob.pos = mob.pos + 1
                mob.posMax = 5
                mob.posY = mob.posY - (medidaMoviemento * 10) * dt
              else
                mob.pos = 1
                mob.direcao = 'up'
                mob.posMax = 5
                mob.posY = mob.posY - (medidaMoviemento * 10) * dt
              end   
        
           end
                
          if(randomNumber == 4 and monster.colisaoBorda(mob.posX,mob.posY,mob.quadro,mob.quadro,"down")) then
              if(mob.direcao == 'down') then
                mob.pos = mob.pos + 1
                mob.posMax = 7
                mob.posY = mob.posY + (medidaMoviemento * 10) * dt
              else
                mob.pos = 1
                mob.direcao = 'down'
                mob.posMax = 7
                mob.posY = mob.posY + (medidaMoviemento * 10) * dt
              end
            
            
                  
           end
              mob.sleepTime = 0
      end
    end

  end
end
          lifeMob.updatePos(mob.life,mob.posX,mob.posY,mob.quadro)
          monster.setVisao(mob)
      if(mob.pos ==  mob.posMax) then
        mob.pos = 1
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

  function monster.ataque(mob,posX,posY,width,height,podeAtacar) 
  -- verifica se o monstro pode ou não atacar
  -- monstro da tabela, posição X, posição Y, largura, altura
    if((mob.posX < posX + width/2) and (mob.posX + mob.quadro > posX) and (mob.posY < posY + height/2) and (mob.posY + mob.quadro > posY) and(podeAtacar == true)) then
      mob.status = 'ataque'
      if(mob.direcao == 'up' or mob.direcao == 'atqUp') then
        if(mob.direcao == 'up') then
          mob.direcao = 'atqUp'
          mob.pos = 1
        end
        mob.posMax = 8
        mob.pos = mob.pos + 1
      elseif(mob.direcao == 'down' or mob.direcao == 'atqDown') then
        if(mob.direcao == 'down') then
          mob.direcao = 'atqDown'
          mob.pos = 1
        end
        mob.posMax = 7
        mob.pos = mob.pos + 1
      elseif(mob.direcao == 'right' or mob.direcao == 'atqRight') then
        if(mob.direcao == 'right') then
          mob.direcao = 'atqRight'
          mob.pos = 1
        end
        mob.posMax = 8
        mob.pos = mob.pos + 1
      elseif(mob.direcao == 'left' or mob.direcao == 'atqLeft') then
        if(mob.direcao == 'left') then
          mob.direcao = 'atqLeft'
          mob.pos = 1
        end
        mob.posMax = 8
        mob.pos = mob.pos + 1
      end
      return true
      else 
        mob.status = 'caminhando'
      return false
    end
  end
  function monster.getMaxPos(mob) 
    return mob.posMax
  end
  function monster.getPos(mob) 
    return mob.pos
  end
  function monster.getSleepMain(mob) 
    return mob.sleepMain
  end
  function monster.setSleepMain(mob,value) 
    mob.sleepMain = value
  end


function monster.update(monstros,player,medidaMoviemento,dt,podeAtacar,lifePersonagem,randomPosX,randomPosY)

  
  podeAtacar = true
  
  for i, monst in ipairs(monstros) do
    monster.getHitBox(monst):moveTo(monster.getPosX(monst) + monster.getColisaoWidth(monst),monster.getPosY(monst)+monster.getColisaoWidth(monst))

  for i,quadrado in pairs(hc.collisions(monst.hitBox)) do
    monster.setPosX(monst,monster.getPosX(monst) + quadrado.x)
    monster.setPosY(monst,monster.getPosY(monst) + quadrado.y)
  end

    randomPosX = love.math.random(1, love.graphics.getWidth() - monster.getQuadro(monst))
    randomPosY = love.math.random(1, love.graphics.getHeight() - monster.getQuadro(monst))
    monster.movimenta(monst,player.getPosX(),player.getPosY(),player.getQuadro(),player.getQuadro(),medidaMoviemento,dt,podeAtacar)
       monster.setSleepMain(monst,monster.getSleepMain(monst) + dt)
        if(monster.getSleepMain(monst) > 0.1) then
          podeAtacar = true
          if(monster.ataque(monst,player.getPosX(),player.getPosY(),player.getQuadro(),player.getQuadro(),podeAtacar)) then
          monster.setSleepMain(monst,0)
          if(monster.getMaxPos(monst) == monster.getPos(monst)) then
             monst.status = 'caminhando'
             lifePersonagem.dano(monster.getAtq(monst))
             podeAtacar = false
            end
            
        end
        
       
      end
    if monster.getVida(monst) == 0  then -- Se o monstro for morto, dropa o item
      hc.remove(monster.getHitBox(monst))
      table.remove(monstros, i)
      
      player.addAtq(math.sqrt(player.pontos/100))
       local mob = {}
       addvida = 100 + player.getPontos() 
       addDano = monster.getAtq(monst) + (player.getPontos() / 10)
      table.insert(monstros, monster.createMonster(mob,'Rinoceronte','uteis/imgs/monster/rino.png',128,randomPosX,randomPosY,addDano,addvida))
      monster.criaColisao(mob)
      local dropComida = {}
      local dropMoeda = {}
      table.insert(drops, item.criaItem(dropComida,"uteis/imgs/itens/comida.png",5,2,32,monster.getPosX(monst),monster.getPosY(monst),'comida'))
      --table.insert(drops, item.criaItem(dropMoeda,"uteis/imgs/itens/spr_coin_strip4.png",4,1,16,monster.getPosX(monst),monster.getPosY(monst) - 10,'moeda'))
    end
    -- Controla os itens dropados
    for i, itensDropados in ipairs(drops) do
      if(item.Coleta(itensDropados,player.getPosX(),player.getPosY(),player.getQuadro(),player.getQuadro())) then
        if(item.getUtilidade(itensDropados) == 'comida') then
           lifePersonagem.cura(50)
           player.addPontos(10)
        --elseif(item.getUtilidade(itensDropados) == 'moeda') then
            
        end
      
          table.remove(drops, i)
      end
    end
  end
  
end
     
      




function monster.getDrops()
  return mob.drops
end

  return monster