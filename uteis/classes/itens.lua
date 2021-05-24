local Q = love.graphics.newQuad
local K = love.keyboard.isDown
local item = {} -- Timer 
local id = 0

math.randomseed(os.time())

function item.criaItem(i,qdImagem,qtdQuadrosX,qtdQuadrosY,quadro,posX,posY,utilidade)
 -- cria o item 
 --item da tabela, imagem(quad ou não), quantidade de quadros no eixo x,
 -- quantidade de quadros no eixo y, tamanho do quadro, posição x, posição y, utilidade('moeda' para pontos, 'comida' para curar) 
    i.pos = 1
    i.sleepTime = 0
    i.id = id
    i.posX = posX
    i.posY = posY - 20
    i.qdImagem = love.graphics.newImage(qdImagem)
    i.qdImagem:setFilter("nearest","linear")
    i.quadro = quadro -- tamanho quadro em px
    i.qtdQuadrosX = qtdQuadrosX -- quantidade de quadros na posição x
    i.qtdQuadrosY = qtdQuadrosY-- quantidade de quadros na posição y
    id = id + 1

    if(i.qtdQuadrosX == 0) then
        i.qtdQuadrosX = 1
    end
    if(i.qtdQuadrosY == 0) then
        i.qtdQuadrosX = 1
    end

    i.qtdQuadros =  i.qtdQuadrosY * i.qtdQuadrosX -- quantidade de quadros totais
    i.itemRandom = love.math.random(1,i.qtdQuadros)
    i.Quadros = {} 
    i.utilidade = utilidade

   -- Cria o os quadros
    local cont = 1
    for x = 0, (i.qtdQuadrosX - 1) do
        quadroPosx = x * i.quadro
        for y = 0, (i.qtdQuadrosY - 1) do 
            quadroPosY = y * i.quadro
            i.Quadros[cont] = Q((quadroPosx), (quadroPosY),i.quadro,i.quadro,i.qdImagem:getWidth(),i.qdImagem:getHeight())
            cont = cont + 1
        end
    end
    return i
end

function item.Draw(i,qtdItens,dt)
    --item.Draw(item da tabela, quantidade)
    love.graphics.setColor(1,1,1,1)
    for x = 0, (qtdItens - 1) do
        if(i.utilidade == 'comida') then
            love.graphics.draw(i.qdImagem,i.Quadros[i.itemRandom],i.posX,(i.posY))
        elseif(i.utilidade == 'moeda') then
            for x = 0, i.qtdQuadros do
                i.sleepTime = i.sleepTime + dt
                if(i.sleepTime > 1) then
                    love.graphics.draw(i.qdImagem,i.Quadros[i.pos],i.posX,(i.posY))
                    i.sleepTime = 0
                    i.pos = i.pos + 1
                else
                    love.graphics.draw(i.qdImagem,i.Quadros[i.pos],i.posX,(i.posY))
                end 
                if(i.pos == i.qtdQuadros) then
                    i.pos = 1
                end
            end
        end  
    end
end

function item.Coleta(i,playerX,playerY,playerWidth,playerHeight)
    -- verifica se o player tocou ou não no item
    -- colisão
    if(i.posX < (playerX + playerWidth) and ((i.posX + i.quadro) > playerX) and (i.posY < (playerY + playerHeight)) and ((i.posY + i.quadro) > playerY)) then    
        return true
    else
        return false
  end
end

function item.getUtilidade(i)
    return i.utilidade
end

return item
