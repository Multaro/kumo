img = love.graphics.newImage('uteis/imgs/player/lifebar.png')
local lifePersonagem = {}
local posDebugx = 500
local posDebugy = 500

-- Função que carrega todos os dados necessarios
function lifePersonagem.lifePersonagemLoad()
  love.graphics.setBackgroundColor(1,1,1)
  lifePersonagem.x = 10
  lifePersonagem.y = (love.graphics.getHeight() - img:getHeight()) * 2
  lifePersonagem.fillX = lifePersonagem.x + 10
  lifePersonagem.fillY = (lifePersonagem.y + img:getHeight()/4)/2 -2
  lifePersonagem.value = 195
  lifePersonagem.maxValue = lifePersonagem.value
end

--Função responsavel por desenhar a barra de lifePersonagem
function lifePersonagem.lifePersonagemDraw()
  love.graphics.push()
  love.graphics.setColor(1,0,0,1)
  love.graphics.rectangle("fill", lifePersonagem.fillX, lifePersonagem.fillY, lifePersonagem.value, 22)
  love.graphics.scale(0.5, 0.5) 
  love.graphics.draw(img,lifePersonagem.x,lifePersonagem.y)
  love.graphics.pop()

end


-- Função que retira o valor x da lifePersonagem.value. O valor é convertido em porcentagem 
-- tendo em mente que 195 (valor original de lifePersonagem.value) é 100.
function lifePersonagem.dano(valor)
  if(lifePersonagem.value - valor) < 0 then
      lifePersonagem.value = 0
  else
    valor = ((valor * 100)/195)
    lifePersonagem.value =  lifePersonagem.value - valor
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




function lifePersonagem.debugPosicao(valor)
  
    love.graphics.print(valor,posDebugx,posDebugy)
  
end



-- return necessario para utilizar a classe lifePersonagem
return lifePersonagem