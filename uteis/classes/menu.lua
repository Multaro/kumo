
local personagem = {}
local quadro = 128
local Q = love.graphics.newQuad
local explosion = {}
local timeMenuController = 0
local gameState = 'intro'
local opacity = 0
local play = true
local menu = {}

function menu.load()
  personagem.qtdQuadrosX = 4
  personagem.qtdQuadrosY = 2
  personagem.qtdQuadros = personagem.qtdQuadrosY * personagem.qtdQuadrosX
  personagem.personImg = {}
  personagem.pos = 1
  personagem.sleepTime = 0
  personagem.personImg = love.graphics.newImage('uteis/imgs/menu/personagem.png')
   
  explosion.qtdQuadrosX = 12
  explosion.qtdQuadrosY = 1
  explosion.qtdQuadros = explosion.qtdQuadrosY * explosion.qtdQuadrosX
  explosion.explosionImg = {}
  explosion.pos = 1
  explosion.sleepTime = 0
  explosion.explosionImg = love.graphics.newImage('uteis/imgs/menu/explosion.png')
   
  ceu = love.graphics.newImage('uteis/imgs/menu/ceu.png')
  paisagem = love.graphics.newImage('uteis/imgs/menu/paisagem.png')
  imagem = love.graphics.newImage('uteis/imgs/menu/menuMicroWave.png')
  success = love.window.setMode( 960, 736 )
  sound = love.audio.newSource("uteis/sounds/microwave.wav", "static")
  music = love.audio.newSource("uteis/sounds/coisaLinda2.wav", "stream")
   
  personagem.cont = 1
  for y = 0, (personagem.qtdQuadrosY -1) do
    for x = 0, (personagem.qtdQuadrosX - 1) do
      personagem[personagem.cont] = Q((x * quadro), (y * quadro),quadro,quadro,personagem.personImg:getWidth(),personagem.personImg:getHeight())
      personagem.cont = personagem.cont + 1
    end
  end
  explosion.cont = 1
  for y = 0, (explosion.qtdQuadrosY -1) do
    for x = 0, (explosion.qtdQuadrosX - 1) do
      explosion[explosion.cont] = Q((x * quadro), (y * quadro),quadro,quadro,explosion.explosionImg:getWidth(),explosion.explosionImg:getHeight())
      explosion.cont = explosion.cont + 1
    end
  end  
end

function menu.draw(gameState,time,fonteWay)
  love.graphics.setBackgroundColor(1, 1, 1, 1)
    newFont = love.graphics.newFont(fonteWay,25)
    love.graphics.setFont(newFont)
  if(gameState == 'intro') then
    if play then
      sound:play()
      sound:setVolume(0.1)
      play = false
        
    end
    love.graphics.setColor(1, 1, 1, opacity)
    love.graphics.draw(imagem, 0, 0)
        
    if(math.ceil(time)>=10) then
      love.graphics.setColor(0, 0, 0, opacity)
      love.graphics.print("00:00", 810, 180)
      love.graphics.setColor(1, 1, 1, opacity)
  
    else
      love.graphics.setColor(0, 0, 0, opacity)
      love.graphics.print("00:0"..math.ceil(time), 810, 180)
      love.graphics.setColor(1,1,1,opacity)
    
    end
  end
    
  if(gameState == 'menu') then
    if(math.ceil(time)==1) then
      music:play()
      music:setVolume(0.1)
    end
    if(time > 0) then
      love.graphics.setColor(1, 1, 1, 1)
      love.graphics.rectangle('fill', 95, 190, 610, 355)
      love.graphics.setColor(1, 1, 1, 1)
      love.graphics.draw(imagem, 0, 0)
      love.graphics.setColor(0, 0, 0, opacity)
      love.graphics.print("00:0" .. math.ceil(time), 810, 180)
      love.graphics.setColor(1, 1, 1, opacity)
    else
      love.graphics.setColor(1, 1, 1, 1)
      love.graphics.rectangle('fill', 95, 190, 610, 355)
      love.graphics.setColor(1, 1, 1, 1)
      love.graphics.draw(ceu, 95, 190)
      love.graphics.draw(paisagem, 0, 400)
      love.graphics.push()
      love.graphics.scale(3, 3) 
      love.graphics.draw(explosion.explosionImg,explosion[explosion.pos], (love.graphics.getWidth()/2 - (quadro * 3.20)),50)
      love.graphics.pop()
      love.graphics.draw(personagem.personImg,personagem[personagem.pos], (love.graphics.getWidth()/2 - quadro),(love.graphics.getHeight()/2 + quadro/2))
      love.graphics.draw(imagem,0,0)
     
      love.graphics.setColor(0,0,0,opacity)
      love.graphics.print("00:0"..math.ceil(time),810,180)
      love.graphics.setColor(0,1,0,opacity)
      love.graphics.print("Press any button to Play",150,550)
      love.graphics.setColor(1,1,1,opacity)
    end
  end
  fonte = love.graphics.newFont(fonteWay,10)
  love.graphics.setFont(fonte)
end

function menu.update(dt,gameState,time)
  if(gameState == 'menu') then
    personagem.sleepTime = personagem.sleepTime + dt * 4
    if(personagem.sleepTime > 1) then
      personagem.pos = personagem.pos + 1
      personagem.sleepTime = 0
    end
    if (personagem.pos == personagem.qtdQuadros) then
      personagem.pos = 1
    end
    explosion.sleepTime = explosion.sleepTime + dt * 4
    if(explosion.sleepTime > 1) then
      explosion.pos = explosion.pos + 1
      explosion.sleepTime = 0
    end
    if (explosion.pos == explosion.qtdQuadros-5) then
      explosion.pos = 5
    end
  end
  if(gameState == 'intro') then
    opacity = opacity + dt/10
    if(opacity>=1) then
      opacity = 1
    end
  end
end

return menu
