img = love.graphics.newImage('uteis/imgs/player/lifebar.png')
ataqueImg = love.graphics.newImage('uteis/imgs/player/ataqueMenuImg.png')
skillImg = love.graphics.newImage('uteis/imgs/player/skillMenuImg.png')
local lifePersonagem = {}
local posDebugx = 500
local posDebugy = 500
skillPronta = true
ataquePronto = true
fonteWay = 'uteis/fonts/joystix/joystix.ttf'
contador = 9
-- Função que carrega todos os dados necessarios
function lifePersonagem.lifePersonagemLoad()
  love.graphics.setBackgroundColor(1,1,1)
  lifePersonagem.x = 10
  lifePersonagem.y = (love.graphics.getHeight() - img:getHeight()) * 2
  lifePersonagem.fillX = lifePersonagem.x + 10
  lifePersonagem.fillY = (lifePersonagem.y + img:getHeight()/4)/2 -2
  lifePersonagem.value = 195
  lifePersonagem.maxValue = lifePersonagem.value
  lifePersonagem.isImortal = false
end

--Função responsavel por desenhar a barra de lifePersonagem
function lifePersonagem.lifePersonagemDraw(skillPronta)
  love.graphics.push()
  love.graphics.setColor(1,0,0,1)
  love.graphics.rectangle("fill", lifePersonagem.fillX, lifePersonagem.fillY, lifePersonagem.value, 22)
  love.graphics.scale(0.5, 0.5) 
  love.graphics.draw(img,lifePersonagem.x,lifePersonagem.y)
  love.graphics.pop()

  if(ataquePronto == true) then
  love.graphics.setColor(1,1,1,0.2)
  love.graphics.circle('fill',lifePersonagem.x + lifePersonagem.maxValue + 80,lifePersonagem.y/2 + 20,25)
  love.graphics.draw(ataqueImg,lifePersonagem.x + lifePersonagem.maxValue + 80 - ataqueImg:getWidth()/2 , lifePersonagem.y/2 - 5)
  else
    love.graphics.setColor(1,0,0,1)
    love.graphics.circle('fill',lifePersonagem.x + lifePersonagem.maxValue + 80,lifePersonagem.y/2 + 20,25)
    love.graphics.draw(ataqueImg,lifePersonagem.x + lifePersonagem.maxValue + 80 - ataqueImg:getWidth()/2 , lifePersonagem.y/2 - 5)
  end

  if(skillPronta == true) then
  love.graphics.setColor(1,0,0,1)
  love.graphics.circle('fill',lifePersonagem.x + lifePersonagem.maxValue + 150,lifePersonagem.y/2 + 20,25)
  love.graphics.draw(skillImg,lifePersonagem.x + lifePersonagem.maxValue + 150 - skillImg:getWidth()/2 , lifePersonagem.y/2 - 7)
  else
    love.graphics.setColor(1,1,1,0.2)
    love.graphics.circle('fill',lifePersonagem.x + lifePersonagem.maxValue + 150,lifePersonagem.y/2 + 20,25)
    love.graphics.draw(skillImg,lifePersonagem.x + lifePersonagem.maxValue + 150 - skillImg:getWidth()/2 , lifePersonagem.y/2 - 7)
    fonte = love.graphics.newFont(fonteWay,18)
    love.graphics.setFont(fonte)
    love.graphics.setColor(10/255,10/255,10/255,1)
    if(contador >= 10) then
      love.graphics.print(math.floor(contador),lifePersonagem.x + lifePersonagem.maxValue + 135 ,lifePersonagem.y/2 + fonte:getHeight(math.floor(contador))/2)
    else
      love.graphics.print(math.floor(contador),lifePersonagem.x + lifePersonagem.maxValue + 142 ,lifePersonagem.y/2 + fonte:getHeight(math.floor(contador))/2)
    end
  end
  love.graphics.setColor(0,1,1,1)
  fonte = love.graphics.newFont(fonteWay,18)
  love.graphics.setFont(fonte)
  love.graphics.print("D",lifePersonagem.x + lifePersonagem.maxValue + 75,lifePersonagem.y/2 -30)
  love.graphics.print("W",lifePersonagem.x + lifePersonagem.maxValue + 145,lifePersonagem.y/2 -30)
  
  fonte = love.graphics.newFont(fonteWay,10)
  love.graphics.setFont(fonte)
  if(skillPronta) then
  love.graphics.setColor(0,1,1,1)

  
  
  end
end

-- Função que retira o valor x da lifePersonagem.value. O valor é convertido em porcentagem 
-- tendo em mente que 195 (valor original de lifePersonagem.value) é 100.
function lifePersonagem.dano(valor)
  if(lifePersonagem.isImortal) then
  else
    if(lifePersonagem.value - valor) < 0 then
      lifePersonagem.value = 0
    else
      valor = ((valor * 100)/195)
      lifePersonagem.value =  lifePersonagem.value - valor
    end
  end
end

function lifePersonagem.cura(valor)
  if(lifePersonagem.value + valor) > lifePersonagem.maxValue then
    lifePersonagem.value = lifePersonagem.maxValue
  else
    valor = ((valor * 100)/195)
    lifePersonagem.value =  lifePersonagem.value + valor
  end
end
function lifePersonagem.setX(valor)
  lifePersonagem.x = valor
  lifePersonagem.fillX = lifePersonagem.x/2 + 20  
end

function lifePersonagem.setY(valor)    
  lifePersonagem.y = valor
  lifePersonagem.fillY = (lifePersonagem.y + img:getHeight()/4)/2 -2
end

function lifePersonagem.getPosX()
  return lifePersonagem.x
end

function lifePersonagem.getPosY()
  return lifePersonagem.y
end

function lifePersonagem.getPosBarraX()
  return lifePersonagem.fillX
end

function lifePersonagem.getPosBarraY()
  return lifePersonagem.fillY
end

function lifePersonagem.getValor()
    return lifePersonagem.value
end

function lifePersonagem.imortal() 
  lifePersonagem.isImortal = true
end

function lifePersonagem.mortal() 
  lifePersonagem.isImortal = false
end

function lifePersonagem.debugPosicao(valor)
  love.graphics.print(valor,posDebugx,posDebugy)
end

function lifePersonagem.updateContador(cont)
    if cont ~= nil then
      contador = cont
    end
end


function lifePersonagem.setSkill()
  if(skillPronta == false) then
  skillPronta = true
  else
   skillPronta = false
  end
end
function lifePersonagem.setAtaque()
  if(ataquePronto == false) then
  ataquePronto = true
  else
    ataquePronto = false
  end

function lifePersonagem.getAtaquePronto()
  return ataquePronto
end

function lifePersonagem.getSkillPronta()
  return skillPronta
end

end


-- return necessario para utilizar a classe lifePersonagem
return lifePersonagem
