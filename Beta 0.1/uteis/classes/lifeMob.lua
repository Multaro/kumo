lifeMob = {}

function lifeMob.createLife(life,x,y,value,size)
  life.x = x - value / 2 + size/2
  life.y = y - 25
  life.value = value
  life.vidaMaxima = value
  life.height = 16
  life.offsetBarX = life.x - 3
  life.offsetBarY =  life.y - 3
  life.offsetBarValue = life.value + 6
  life.offsetBarHeight = life.height + 6
end


function lifeMob.updatePos(life,x,y,size)
  life.x = x - life.vidaMaxima / 2 + size/2
  life.y = y - 25
  life.offsetBarX = life.x - 3
  life.offsetBarY =  life.y - 3
end

function lifeMob.dano(life,valor)
   if(life.value - valor) < 0 then
    life.value = 0
  else
    valor = ((valor * 100)/195)
    life.value =  life.value - valor
  end
end

function lifeMob.getVida(life)
    return life.value
end
function lifeMob.setVida(life,vida)
   life.value = vida
end

function lifeMob.draw(life)
  love.graphics.setColor(0,0,0,1)
  love.graphics.rectangle("line", life.offsetBarX, life.offsetBarY, life.offsetBarValue,life.offsetBarHeight )
  love.graphics.setColor(1,0,0,1)
  love.graphics.rectangle("fill", life.x, life.y, life.value, life.height)
end


return lifeMob