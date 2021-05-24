lifeMob = {}


function lifeMob.createLife(life,x,y,value,size)
-- cria a barra de vida do monstro
-- vida da tabela, posição x, posição y, valor, altura
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
function lifeMob.createLifeBoss(life,x,y,value)
  -- cria a barra de vida do monstro
  -- vida da tabela, posição x, posição y, valor, altura
    life.x = x 
    life.y = y 
    life.value = value
    life.vidaMaxima = value
    life.height = 16
    life.offsetBarX = life.x - 3
    life.offsetBarY =  life.y - 3
    life.offsetBarValue = life.value + 6
    life.offsetBarHeight = life.height + 6
  end

function lifeMob.getPosX(life)
  return life.offsetBarX
end

function lifeMob.getPosY(life)
  return life.offsetBarY
end

function lifeMob.setHeight(life,valor)
  life.y = (y - 25) - (life.height - valor)
  life.height = value
  life.offsetBarHeight = life.height + 6
  
end

function lifeMob.getHeight(life)
  return life.height
end


function lifeMob.updatePos(life,x,y,size)
  -- responsavel por atualizar a posição da barra de vida
  -- vida da tabela, posição x, posição y, valor, altura
  life.x = x - life.vidaMaxima / 2 + size/2
  life.y = y - 25
  life.offsetBarX = life.x - 3
  life.offsetBarY =  life.y - 3
end

function lifeMob.dano(life,valor)
-- calcula a vida que o mob perdeu e atualiza o tamanho da barra de vida
-- vida da tabela, valor(dano)
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