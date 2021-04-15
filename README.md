# **Kumo**


### **1. Introdução**
Kumo é um jogo roguelike / hack ’n’ slash / com visão isométrica e morte permanente, onde o jogador coleta comida, matando criaturas ou saqueando templos e castelos, para obter pontos e, quando obter a quantidade necessária, enfrentar um boss, que habita em um microondas, para validar esses pontos. Os pontos definem o score do jogador e, à medida que aumenta, seus adversários ganham mais força e melhorias, antes bloqueadas ou inacessíveis, podem ser adquiridas.

<<<<<<< HEAD
As batalhas são enfrentadas em tempo real, exigindo a habilidade, estratégia  e agilidade aguçadas do jogador.
=======
## **Informações**
Programação em Lua

## **Tasks Pendentes**
- [ ]
- [ ] 
- [ ] 
- [ ] 
>>>>>>> 88b61db4e59e2dd0351a74f1512948756ad24070

### **2. Contexto**
Seres extraterrestres, predestinados a dominar povos, caíram no mundo de Lumbis e trouxeram consigo objetos desconhecidos e malignos, distorcendo a percepção natural do planeta. Todas as criaturas que habitavam em Lumbis, de presas à predadores, tornaram-se hostis devido a influência extraterrestre, perdidas na escuridão, os afortunados passaram a venerar os novos seres divinos e seus objetos sagrados, originando uma série de ritos, dentre eles, tributos e cruéis sacrifícios. 

<<<<<<< HEAD
Apenas um lobo-dourado, conhecido como Kumo e aclamado como um herói pela comunidade, não caiu na tentação. Portanto, prometeu a todos e a si mesmo, salvar o mundo e torná-lo no que um dia já foi. Os inimigos são numerosos e com características diversas, pois seus compatriotas agora trabalham para os seres extraterrestres. Quanto maior o nível do jogador, maior a onda de inimigos. Mas há uma esperança para o herói solitário: sua confiança.
O boss é caracterizado por um monstro com aspectos físicos de uma comida exótica que vive dentro de um microondas desligado.
=======
## **Tasks Concluidas**
- [ ]
- [ ] 
- [ ] 
- [ ] 
>>>>>>> 88b61db4e59e2dd0351a74f1512948756ad24070

### **3. Objetos essenciais do jogo**
*  Personagens.

    O personagem principal, Kumo, controlado pelo usuário, é um lobo humanoide que pode andar sob duas patas.
    As criaturas do microondas são alimentos mutantes e agressivos que ganharam vida após a chegada dos seres extraterrestres, que também são comidas, porém as mais maléficas para os seres vivos. Os inimigos também podem ser animais humanoides, como: papagaio, lagartos, vacas e coelhos.

* Armas ou acessórios.

    Kumo poderá encontrar itens que ajudarão em sua jornada, tais como anéis e colares, que aumentam sua velocidade, força e vida.

    As estruturas de jogabilidade são o teclado e o mouse.

    O usuário receberá informações por texto em uma _chatbox_, que o auxiliará a interagir com os objetos encontrados no cenário, itens já encontrados e armazenados anteriormente, distinguir entre o dano causado ou recebido, receber dicas e treinamentos e informações em campos que exibem a quantidade de pontos, vida restante, etc.

### **4. Aspectos Psicológicos**
Apresentar os conflitos e soluções que envolvem o jogo em forma de desafios ao jogador e o desenvolvimento de interações relacionadas aos conflitos.

Após a queda dos microondas os seres do planeta não se controlam mais como antigamente, atacando nosso herói assim que o percebem, o único jeito de parar-los é destruindo os seres que vieram dentro do microondas.

O lobo irá dispor de espadas, lâminas e diversos outros objetos de ataque (corpo-a-corpo ou à distância), assim como objetos de defesa, à seu dispor para enfrentar os inimigos.

Determinados locais do cenário levam o jogador a labirintos, com armadilhas ou não, que o único objetivo é prender o jogador e dificultar sua chegada aos inimigos ou itens. O jogador deve encontrar a única saída deste labirinto.

Quando o jogador se encontra na etapa de validação dos pontos no microondas, o boss pode ligar o microondas por determinado tempo, tornando-se furioso e mais habilidoso. O jogador deve se esquivar dos ataques até que o tempo se esgote ou, se desejar, enfrentar o boss quando ele está furioso.

### **5. Características de Jogabilidade**

O jogo disponibilizará teclas de movimentação padrão WASD (W movimenta para cima, A para à esquerda, S para baixo e D para à direita), ataques, defesas, interações com o ambiente, atalhos para menus de navegação e utilização de habilidades.

Primeiramente, terá um menu para configuração (som e personalização de teclas) com um botão para o início do jogo. 

Ataques: o botão esquerdo do mouse aciona o ataque básico e o botão direito do mouse aciona o ataque especial (com um tempo de recarga maior que o ataque básico). O direcionamento de ambos ataques é ditado pela posição relativa do mouse dentro da tela. A força, velocidade e distância do ataque básico é com base no armamento que está em uso.

Defesas: haverá uma tecla que faz com que o jogador se desloque rapidamente para determinada direção (onde o mouse está localizado) por pixels suficientes para se esquivar de determinados ataques. Alguns itens de defesa como bloqueadores de ataques podem ser utilizados, quando determinada tecla for pressionada.

Muitos itens serão espalhados pelo mapa, a fim de instigar o instinto explorador do jogador. Os tipos de interação com esses itens e com o ambiente serão apresentados quando estiver em posse ou aos arredores e variam de item para item e de ambiente para ambiente.

Os únicos personagens controlados pelo computador serão os inimigos comuns e o boss. Os inimigos vão te atacar e, simultaneamente, proteger seus abrigos, quando se aproximar deles. O boss será agressivo e, assim que o jogador adentrar o microondas, ele atacará. Conforme os níveis são atingidos, os inimigos se tornam mais fortes (mais vida, velocidade, dano, etc…) e chegam em maior número, tornando a dificuldade visível.

O jogador deve tomar a melhor decisão, em tempo real e dinamicamente, para que consiga alcançar os níveis subsequentes.

### **6. Fluxo do jogo**
O jogo é dividido em duas etapas: coleta de alimentos e, com a quantidade necessária, um confronto com o defensor do microondas. A dificuldade do jogo aumenta e seus pontos são validados e adicionados ao score se o defensor do microondas for derrotado. Esse processo é repetido até a morte do personagem. Os pontos podem ser trocados por melhorias, porém a morte do jogador reinicia os pontos e rebaixa totalmente o nível alcançado, tornando um processo cíclico.

>Dificuldade = (rodadas no microondas * validação dos pontos na rodada) / 100

Exemplo: dificuldade padrão = 1, após o 1° nível, validado 100 pontos, a dificuldade passa a valer 1,01.


![alt text](/imgs/imageLikeEmbed.png "Estrutura de níveis e pontuação")

### **7. Cronograma**








   
|:               Abril              :|    |    |    |    |    |    |    |    |    |    |   |    |           |
|:----------------------------------|:---|:---|:---|:---|:---|:---|:---|:---|:---|:---|:---|:---|:----------|

| Tarefa/Semana                      | 1 | 2 | 3 | 4 | 1 | 2 | 3 | 4 | 1 | 2 | 3 | 4 | Progesso |
|:----------------------------------:|:---:|:---:|:---:|:---:|:---:|:---:|:---:|:---:|:---:|:---:|:---:|:---:|:----------:|
| Implementação do jogador           |   |   | X |   |   |   |   |   |   |   |   |   |          |
| Implementação dos Inimigos comuns  |   |   |   | X |   |   |   |   |   |   |   |   |          |
| Implementação de todos os _bosses_ |   |   |   |   | X |   |   |   |   |   |   |   |          |
| Implementação dos itens            |   |   |   |   |   | X |   |   |   |   |   |   |          |
| Implementação do cenário           |   |   |   |   |   |   | X |   |   |   |   |   |          |
| Dinâmica e ação                    |   |   |   |   |   |   |   | X |   |   |   |   |          |
| Lógica do jogo                     |   |   |   |   |   |   |   | X |   |   |   |   |          |
| Fluxo do jogo                      |   |   |   |   |   |   |   |   | X |   |   |   |          |
| Design  do  Jogador                |   |   |   | X |   |   |   |   |   |   |   |   |          |
| Design  dos inimigos               |   |   |   |   | X |   |   |   |   |   |   |   |          |
| Design dos boss                    |   |   |   |   |   | X |   |   |   |   |   |   |          |
| Design dos itens                   |   |   |   |   |   | X |   |   |   |   |   |   |          |
| Design do cenário                  |   |   |   |   |   |   | X |   |   |   |   |   |          |



|             |          Grouping            |
First Header  | Second Header | Third Header |
 ------------ | :-----------: | -----------: |
Content       |          *Long Cell*        ||
Content       |   **Cell**    |         Cell |

New section   |     More      |         Data |
And more      | With an escaped '\|'         ||  
