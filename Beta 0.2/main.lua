
local lifePersonagem = require("uteis.classes.lifePersonagem") -- Import barra de vida do player
local monster = require("uteis.classes.monster") -- Import dos monstros
local item = require("uteis.classes.itens") -- Import itens
local player = {} -- Instancia do Player
local k = love.keyboard.isDown
local sleepTime = 0
local sleepTimeItem = 0-- Timer 
local monstros = {} -- Tabela que vai armazenar os monstros
local drops = {} -- Tabela que ira armazenar os itens 
local addvida = 10 
local fonte
local delta
function love.load()
 fonte = love.graphics.newFont('uteis/fonts/joystix/joystix.ttf',10)
 love.graphics.setFont(fonte)
 lifePersonagem.lifePersonagemLoad()
 player.posx = 500
 player.posy = 500
 player.width = 50
 player.height = 50
  player.pontos = 0
 
 local mob = {}
 table.insert(monstros, monster.createMonster(mob,'Slime','uteis/imgs/monster/Slimey.png',4,4,16,500,100,10,100)) 
end
function love.draw()

lifePersonagem.lifePersonagemDraw()
 for i, mobs in ipairs(monstros) do
    monster.draw(mobs,fonte,delta) 
  end
  
  
  for i, itensDropados in ipairs(drops) do
      item.Draw(itensDropados,1,delta) 
  end

  
love.graphics.setColor(0,0,1,1)
love.graphics.rectangle('fill',player.posx,player.posy,player.width,player.height)
love.graphics.print("Pontos:" .. player.pontos,10,10)

end

function love.update(dt)
  delta = dt

  -- Movimenta os Monstros e controla a visão/ataque dos mesmos
  for i, monst in ipairs(monstros) do
    
    monster.movimenta(monst,player.posx,player.posy,player.width,player.height,100,dt)
      if(monster.ataque(monst,player.posx,player.posy,player.width,player.height)) then
        sleepTime = sleepTime + dt
        if(sleepTime > 2) then
          lifePersonagem.dano(monster.getAtq(monst))
          sleepTime = 0
        end
        
      end
    if monster.getVida(monst) == 0  then -- Se o monstro for morto, dropa o item
      table.remove(monstros, i)
      local dropComida = {}
      local dropMoeda = {}
      table.insert(drops, item.criaItem(dropComida,"uteis/imgs/itens/comida.png",5,2,32,monster.getPosX(monst),monster.getPosY(monst),'comida'))
      table.insert(drops, item.criaItem(dropMoeda,"uteis/imgs/itens/spr_coin_strip4.png",4,1,16,monster.getPosX(monst),monster.getPosY(monst) - 10,'moeda'))
    end
  end
  
  -- Controla os itens dropados
      for i, itensDropados in ipairs(drops) do
        if(item.Coleta(itensDropados,player.posx,player.posy,player.width,player.height)) then
          if(item.getUtilidade(itensDropados) == 'comida') then
             lifePersonagem.cura(50)
          elseif(item.getUtilidade(itensDropados) == 'moeda') then
              player.pontos = player.pontos + 10
          end
        
            table.remove(drops, i)
        end
      end
      
    
  
  -- Movimento do Player
       if k("down") and monster.colisaoBorda(player.posx,player.posy,player.width,player.height,"down") then
          player.posy = player.posy + 64 * dt
        elseif k("up") and monster.colisaoBorda(player.posx,player.posy,player.width,player.height,"up") then
          player.posy = player.posy - 64 * dt
        elseif k("right") and monster.colisaoBorda(player.posx,player.posy,player.width,player.height,"right") then
          player.posx = player.posx + 64 * dt
        elseif k("left") and monster.colisaoBorda(player.posx,player.posy,player.width,player.height,"left") then
          player.posx = player.posx - 64 * dt
       end
       
   
 
end

function love.keyreleased(key)
  for i, monst in ipairs(monstros) do
    if key == 'k' and monster.ataque(monst,player.posx,player.posy,player.width,player.height) then
      monster.dano(monst,10)
    end
  end
    if key == 'q' then
      local mob = {}
      
      table.insert(monstros, monster.createMonster(mob,'Slime','uteis/imgs/monster/Slimey.png',4,4,16,500,100,10,100+addvida))
      addvida = addvida + 10
    end
    
end

