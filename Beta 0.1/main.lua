
local lifePersonagem = require("uteis.classes.lifePersonagem")
local monster = require("uteis.classes.monster")
local player = {}
local k = love.keyboard.isDown
local velocidade = 100
local sleepTime = 0
local monstros = {}
local addvida = 10

function love.load()
 love.window.setMode(800,700)
 width, height = love.graphics.getDimensions()
 lifePersonagem.lifePersonagemLoad()
 player.posx = 500
 player.posy = 500
 player.width = 50
 player.height = 50
 local mob = {}
 table.insert(monstros, monster.createMonster(mob,'uteis/imgs/face.png',500,100,10,100))
end
function love.draw()

lifePersonagem.lifePersonagemDraw()
 for i, mobs in ipairs(monstros) do
    monster.draw(mobs)
  end
  
love.graphics.setColor(0,0,1,1)
love.graphics.rectangle('fill',player.posx,player.posy,player.width,player.height)


end

function love.update(dt)
  for i, monst in ipairs(monstros) do
    
    monster.movimenta(monst,player.posx,player.posy,player.width,player.height,100,dt)
      if(monster.ataque(monst,player.posx,player.posy,player.width,player.height)) then
        sleepTime = sleepTime + dt
        if(sleepTime > 2) then
          lifePersonagem.dano(monster.getAtq(monst))
          sleepTime = 0
        end
        
      end
    if monster.getVida(monst) == 0  then 
      table.remove(monstros, i)
    end
  end
      
    
  
  
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
      
      table.insert(monstros, monster.createMonster(mob,'uteis/imgs/face.png',500,100,10,100+addvida))
      addvida = addvida + 10
    end
    
end

