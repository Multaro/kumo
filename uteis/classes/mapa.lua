-- Apelidos para as funções
local newQuad = love.graphics.newQuad
local hc = require 'uteis/HC'

-- Dados do jogador
-- Controle e direção do jogador
-- Variáveis para personalizar dimensões do ladrilho do jogador

local mapa = {}
local mapaTimer = 0
local animationCont = 1
animationFrame = 0
local quadrosMapa = {}
local quadrosDetailColision = {}
local quadrosDetails = {}
local quadrosSob = {}
local tamanhoQuadroMapa = 32
local quantidadeQuadrosMapa = 6
local proximaFase
local quadrosIntransponiveis = {}
local colisaoPlayer = true
local direcao = ''

function mapa.criaMapa()
  mapa.angle = 0 
  circulo ={}
  circulo.x = 470
  circulo.y = 350
  circulo.radius = 350

  local primeiraFase = {
    -- 1  2  3  4  5  6  7  8  9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30
      {1, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 3}, -- 1
      {7, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 9}, -- 2
      {7, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 9}, -- 3
      {7, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 9}, -- 4
      {7, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 9}, -- 5
      {7, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 9}, -- 6
      {7, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 9}, -- 7
      {7, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 9}, -- 8
      {7, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 9}, -- 9
      {7, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 9}, -- 10
      {7, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 9}, -- 11
      {7, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 9}, -- 12
      {7, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 9}, -- 13
      {7, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 9}, -- 14
      {7, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 9}, -- 15
      {7, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 9}, -- 16
      {7, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 9}, -- 17
      {7, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 9}, -- 18
      {7, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 9}, -- 19
      {7, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 9}, -- 20
      {7, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 9}, -- 21
      {4, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 6}, -- 22
      {8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8} -- 23
    }

  local detailColisions = {
    -- 1  2  3  4  5  6  7  8  9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30
      {10, 11, 10, 11, 10, 11, 10, 11, 10, 11, 15, 18, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}, -- 1
      {11, 10, 11, 10, 11, 10, 11, 10, 11, 10, 14, 19, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}, -- 2
      {10, 11, 10, 11, 10, 11, 10, 11, 10, 11, 15, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 2, 0, 0, 0, 0}, -- 3
      {12, 13, 12, 13, 12, 13, 12, 13, 12, 13, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3, 4, 0, 0, 0, 0}, -- 4
      {0, 0, 0, 0, 24, 0, 17, 16, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 17, 16, 0, 0, 0}, -- 5
      {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}, -- 6
      {0, 1, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 2, 0, 0, 0, 0, 0, 1, 2, 0, 0, 0, 0}, -- 7
      {0, 3, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3, 4, 0, 0, 0, 0, 0, 3, 4, 0, 0, 0, 0}, -- 8
      {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}, -- 9
      {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 18}, -- 10
      {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 19}, -- 11
      {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}, -- 12
      {33, 33, 33, 29, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7, 9, 9, 9, 9, 9, 9, 9, 9}, -- 13
      {34, 34, 34, 30, 0, 0, 0, 0, 0, 0, 0, 0, 20, 21, 0, 0, 0, 0, 0, 0, 0, 25, 0, 0, 0, 0, 0, 0, 0, 0}, -- 14
      {34, 34, 34, 30, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}, -- 15
      {34, 34, 34, 30, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 22, 0, 0, 0, 0}, -- 16
      {34, 34, 34, 30, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 23, 0, 0, 0, 0}, -- 17
      {34, 34, 34, 30, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}, -- 18
      {32, 32, 32, 31, 20, 21, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 20, 21, 0, 0, 0, 0, 0, 0, 0, 20, 21, 0}, -- 19
      {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 26, 0, 0, 0, 0, 0, 0, 0, 0}, -- 20
      {12, 13, 12, 13, 12, 13, 12, 13, 12, 13, 18, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 8, 9, 9, 9, 9, 9, 9, 9, 9}, -- 21
      {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 19, 0, 0, 0, 0, 0, 0, 27, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}, -- 22
      {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 28, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0} -- 23
    }

  local details = {
    {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 9, 11, 13, 0, 0, 0, 0, 0, 0, 0, 0}, -- 1
    {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 7, 0, 0, 9, 11, 13, 0, 0, 0, 0, 0, 21, 0, 0}, -- 2
    {0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 21, 0, 0, 0, 0, 2, 9, 11, 13, 0, 0, 1, 0, 0, 0, 0, 0}, -- 3
    {0, 0, 0, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 1, 0, 0, 9, 11, 13, 6, 0, 0, 0, 6, 0, 0, 0}, -- 4
    {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 1, 0, 0, 0, 0, 0, 9, 11, 13, 0, 0, 0, 2, 0, 0, 21, 0}, -- 5
    {0, 2, 0, 0, 20, 0, 0, 0, 0, 3, 0, 0, 7, 0, 0, 0, 3, 0, 0, 9, 11, 13, 0, 22, 0, 0, 0, 0, 0, 0}, -- 6
    {0, 0, 0, 7, 0, 0, 0, 22, 0, 0, 4, 0, 0, 0, 2, 0, 0, 0, 0, 9, 11, 13, 0, 0, 0, 0, 4, 0, 0, 0}, -- 7
    {0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 22, 0, 0, 0, 0, 0, 9, 11, 13, 0, 0, 3, 0, 0, 0, 0, 0}, -- 8
    {0, 0, 0, 0, 0, 0, 6, 0, 0, 0, 0, 0, 2, 0, 0, 0, 7, 0, 0, 9, 11, 13, 0, 0, 0, 0, 0, 0, 0, 0}, -- 9
    {10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 11, 11, 11, 10, 10, 10, 10, 10, 10, 10, 10}, -- 10
    {11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11}, -- 11
    {12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12}, -- 12
    {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 6, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 14, 15, 15, 15, 15, 15, 15, 15, 15}, -- 13
    {0, 0, 1, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 4, 0, 0, 0, 0, 0, 5, 0, 16, 19, 19, 19, 19, 19, 19, 19, 19}, -- 14
    {0, 0, 0, 0, 0, 0, 0, 0, 21, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 16, 19, 19, 19, 19, 19, 19, 19, 19}, -- 15
    {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 6, 16, 19, 19, 19, 19, 19, 19, 19, 19}, -- 16
    {0, 0, 0, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 16, 19, 19, 19, 19, 19, 19, 19, 19}, -- 17
    {0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 4, 0, 0, 4, 0, 2, 0, 0, 0, 0, 16, 19, 19, 19, 19, 19, 19, 19, 19}, -- 18
    {0, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 2, 16, 19, 19, 19, 19, 19, 19, 19, 19}, -- 19
    {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 16, 19, 19, 19, 19, 19, 19, 19, 19}, -- 20
    {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 22, 0, 0, 4, 1, 0, 17, 18, 18, 18, 18, 18, 18, 18, 18}, -- 21
    {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}, -- 22
    {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}, -- 23
  }

  local sob = {
    {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}, -- 1
    {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}, -- 2
    {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}, -- 3
    {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}, -- 4
    {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}, -- 5
    {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}, -- 6
    {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}, -- 7
    {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}, -- 8
    {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}, -- 9
    {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}, -- 10
    {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}, -- 11
    {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}, -- 12
    {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}, -- 13
    {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}, -- 14
    {8, 8, 8, 5, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}, -- 15
    {9, 9, 9, 6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}, -- 16
    {10, 10, 10, 7, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}, -- 17
    {0, 0, 0, 0, 3, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3, 4, 0, 0, 0, 0, 0, 0, 0, 3, 4, 0}, -- 18
    {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}, -- 19
    {1, 2, 1, 2, 1, 2, 1, 2, 1, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}, -- 20
    {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}, -- 21
    {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}, -- 22
    {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0} -- 23
  }

  faseBoss = {imgBack = love.graphics.newImage('uteis/imgs/Boss/microndas.png'),imgPrato = love.graphics.newImage('uteis/imgs/Boss/microndas2.png'),angle = 0}

  love.graphics.setBackgroundColor(0, 0, 0)
  --love.graphics.setFont(love.graphics.newFont(16))
  -- Carregando dados sobre o jogador

  -- Carregando informações sobre o mapa
  mapa.water = love.graphics.newImage("uteis/imgs/mapa/[A]Water1_pipo.png")
  mapa.img = love.graphics.newImage("uteis/imgs/mapa/[Base]BaseChip_pipo.png")

  mapa.fases = {}

  table.insert(mapa.fases, primeiraFase)
  table.insert(mapa.fases, detailColisions)
  table.insert(mapa.fases, details)
  table.insert(mapa.fases, sob)

  table.insert(mapa.fases, segundaFase)
  
  quadrosMapa[0] = newQuad(0 * tamanhoQuadroMapa, 0 * tamanhoQuadroMapa, tamanhoQuadroMapa, tamanhoQuadroMapa, mapa.img:getWidth(), mapa.img:getHeight())
  quadrosMapa[1] = newQuad(0 * tamanhoQuadroMapa, 9 * tamanhoQuadroMapa, tamanhoQuadroMapa, tamanhoQuadroMapa, mapa.img:getWidth(), mapa.img:getHeight())
  quadrosMapa[2] = newQuad(1 * tamanhoQuadroMapa, 9 * tamanhoQuadroMapa, tamanhoQuadroMapa, tamanhoQuadroMapa, mapa.img:getWidth(), mapa.img:getHeight())
  quadrosMapa[3] = newQuad(2 * tamanhoQuadroMapa, 9 * tamanhoQuadroMapa, tamanhoQuadroMapa, tamanhoQuadroMapa, mapa.img:getWidth(), mapa.img:getHeight())
  quadrosMapa[4] = newQuad(0 * tamanhoQuadroMapa, 11 * tamanhoQuadroMapa, tamanhoQuadroMapa, tamanhoQuadroMapa, mapa.img:getWidth(), mapa.img:getHeight())
  quadrosMapa[5] = newQuad(1 * tamanhoQuadroMapa, 11 * tamanhoQuadroMapa, tamanhoQuadroMapa, tamanhoQuadroMapa, mapa.img:getWidth(), mapa.img:getHeight())
  quadrosMapa[6] = newQuad(2 * tamanhoQuadroMapa, 11 * tamanhoQuadroMapa, tamanhoQuadroMapa, tamanhoQuadroMapa, mapa.img:getWidth(), mapa.img:getHeight())
  quadrosMapa[7] = newQuad(0 * tamanhoQuadroMapa, 10 * tamanhoQuadroMapa, tamanhoQuadroMapa, tamanhoQuadroMapa, mapa.img:getWidth(), mapa.img:getHeight())
  quadrosMapa[8] = newQuad(0 * tamanhoQuadroMapa, 12 * tamanhoQuadroMapa, tamanhoQuadroMapa, tamanhoQuadroMapa, mapa.img:getWidth(), mapa.img:getHeight())
  quadrosMapa[9] = newQuad(2 * tamanhoQuadroMapa, 10 * tamanhoQuadroMapa, tamanhoQuadroMapa, tamanhoQuadroMapa, mapa.img:getWidth(), mapa.img:getHeight())
  quadrosMapa[10] = newQuad(2 * tamanhoQuadroMapa, 10 * tamanhoQuadroMapa, tamanhoQuadroMapa, tamanhoQuadroMapa, mapa.img:getWidth(), mapa.img:getHeight())
  
  quadrosDetailColision[1] = newQuad(6 * tamanhoQuadroMapa, 1 * tamanhoQuadroMapa, tamanhoQuadroMapa, tamanhoQuadroMapa, mapa.img:getWidth(), mapa.img:getHeight())
  quadrosDetailColision[2] = newQuad(7 * tamanhoQuadroMapa, 1 * tamanhoQuadroMapa, tamanhoQuadroMapa, tamanhoQuadroMapa, mapa.img:getWidth(), mapa.img:getHeight())
  quadrosDetailColision[3] = newQuad(6 * tamanhoQuadroMapa, 2 * tamanhoQuadroMapa, tamanhoQuadroMapa, tamanhoQuadroMapa, mapa.img:getWidth(), mapa.img:getHeight())
  quadrosDetailColision[4] = newQuad(7 * tamanhoQuadroMapa, 2 * tamanhoQuadroMapa, tamanhoQuadroMapa, tamanhoQuadroMapa, mapa.img:getWidth(), mapa.img:getHeight())
  quadrosDetailColision[7] = newQuad(2 * tamanhoQuadroMapa, 22 * tamanhoQuadroMapa, tamanhoQuadroMapa, tamanhoQuadroMapa, mapa.img:getWidth(), mapa.img:getHeight())
  quadrosDetailColision[8] = newQuad(2 * tamanhoQuadroMapa, 23 * tamanhoQuadroMapa, tamanhoQuadroMapa, tamanhoQuadroMapa, mapa.img:getWidth(), mapa.img:getHeight())
  quadrosDetailColision[9] = newQuad(0 * tamanhoQuadroMapa, 23 * tamanhoQuadroMapa, tamanhoQuadroMapa, tamanhoQuadroMapa, mapa.img:getWidth(), mapa.img:getHeight())
  quadrosDetailColision[10] = newQuad(0 * tamanhoQuadroMapa, 4 * tamanhoQuadroMapa, tamanhoQuadroMapa, tamanhoQuadroMapa, mapa.img:getWidth(), mapa.img:getHeight())
  quadrosDetailColision[11] = newQuad(1 * tamanhoQuadroMapa, 4 * tamanhoQuadroMapa, tamanhoQuadroMapa, tamanhoQuadroMapa, mapa.img:getWidth(), mapa.img:getHeight())
  quadrosDetailColision[12] = newQuad(0 * tamanhoQuadroMapa, 2 * tamanhoQuadroMapa, tamanhoQuadroMapa, tamanhoQuadroMapa, mapa.img:getWidth(), mapa.img:getHeight())
  quadrosDetailColision[13] = newQuad(1 * tamanhoQuadroMapa, 2 * tamanhoQuadroMapa, tamanhoQuadroMapa, tamanhoQuadroMapa, mapa.img:getWidth(), mapa.img:getHeight())
  quadrosDetailColision[14] = newQuad(1 * tamanhoQuadroMapa, 1 * tamanhoQuadroMapa, tamanhoQuadroMapa, tamanhoQuadroMapa, mapa.img:getWidth(), mapa.img:getHeight())
  quadrosDetailColision[15] = newQuad(1 * tamanhoQuadroMapa, 2 * tamanhoQuadroMapa, tamanhoQuadroMapa, tamanhoQuadroMapa, mapa.img:getWidth(), mapa.img:getHeight())
  quadrosDetailColision[16] = newQuad(7 * tamanhoQuadroMapa, 5 * tamanhoQuadroMapa, tamanhoQuadroMapa, tamanhoQuadroMapa, mapa.img:getWidth(), mapa.img:getHeight())
  quadrosDetailColision[17] = newQuad(6 * tamanhoQuadroMapa, 5 * tamanhoQuadroMapa, tamanhoQuadroMapa, tamanhoQuadroMapa, mapa.img:getWidth(), mapa.img:getHeight())
  quadrosDetailColision[18] = newQuad(7 * tamanhoQuadroMapa, 7 * tamanhoQuadroMapa, tamanhoQuadroMapa, tamanhoQuadroMapa, mapa.img:getWidth(), mapa.img:getHeight())
  quadrosDetailColision[19] = newQuad(7 * tamanhoQuadroMapa, 8 * tamanhoQuadroMapa, tamanhoQuadroMapa, tamanhoQuadroMapa, mapa.img:getWidth(), mapa.img:getHeight())
  quadrosDetailColision[20] = newQuad(4 * tamanhoQuadroMapa, 2 * tamanhoQuadroMapa, tamanhoQuadroMapa, tamanhoQuadroMapa, mapa.img:getWidth(), mapa.img:getHeight())
  quadrosDetailColision[21] = newQuad(5 * tamanhoQuadroMapa, 2 * tamanhoQuadroMapa, tamanhoQuadroMapa, tamanhoQuadroMapa, mapa.img:getWidth(), mapa.img:getHeight())
  quadrosDetailColision[22] = newQuad(3 * tamanhoQuadroMapa, 19 * tamanhoQuadroMapa, tamanhoQuadroMapa, tamanhoQuadroMapa, mapa.img:getWidth(), mapa.img:getHeight())
  quadrosDetailColision[23] = newQuad(3 * tamanhoQuadroMapa, 20 * tamanhoQuadroMapa, tamanhoQuadroMapa, tamanhoQuadroMapa, mapa.img:getWidth(), mapa.img:getHeight())
  quadrosDetailColision[24] = newQuad(3 * tamanhoQuadroMapa, 8 * tamanhoQuadroMapa, tamanhoQuadroMapa, tamanhoQuadroMapa, mapa.img:getWidth(), mapa.img:getHeight())
  quadrosDetailColision[25] = newQuad(1 * tamanhoQuadroMapa, 23 * tamanhoQuadroMapa, tamanhoQuadroMapa, tamanhoQuadroMapa, mapa.img:getWidth(), mapa.img:getHeight())
  quadrosDetailColision[26] = newQuad(1 * tamanhoQuadroMapa, 22 * tamanhoQuadroMapa, tamanhoQuadroMapa, tamanhoQuadroMapa, mapa.img:getWidth(), mapa.img:getHeight())
  quadrosDetailColision[27] = newQuad(5 * tamanhoQuadroMapa, 16 * tamanhoQuadroMapa, tamanhoQuadroMapa, tamanhoQuadroMapa, mapa.img:getWidth(), mapa.img:getHeight())
  quadrosDetailColision[28] = newQuad(5 * tamanhoQuadroMapa, 17 * tamanhoQuadroMapa, tamanhoQuadroMapa, tamanhoQuadroMapa, mapa.img:getWidth(), mapa.img:getHeight())
  quadrosDetailColision[29] = newQuad(7 * tamanhoQuadroMapa, 0 * tamanhoQuadroMapa, tamanhoQuadroMapa, tamanhoQuadroMapa, mapa.water:getWidth(), mapa.water:getHeight())
  quadrosDetailColision[30] = newQuad(7 * tamanhoQuadroMapa, 1 * tamanhoQuadroMapa, tamanhoQuadroMapa, tamanhoQuadroMapa, mapa.water:getWidth(), mapa.water:getHeight())
  quadrosDetailColision[31] = newQuad(7 * tamanhoQuadroMapa, 2 * tamanhoQuadroMapa, tamanhoQuadroMapa, tamanhoQuadroMapa, mapa.water:getWidth(), mapa.water:getHeight())
  quadrosDetailColision[32] = newQuad(6 * tamanhoQuadroMapa, 2 * tamanhoQuadroMapa, tamanhoQuadroMapa, tamanhoQuadroMapa, mapa.water:getWidth(), mapa.water:getHeight())
  quadrosDetailColision[33] = newQuad(6 * tamanhoQuadroMapa, 0 * tamanhoQuadroMapa, tamanhoQuadroMapa, tamanhoQuadroMapa, mapa.water:getWidth(), mapa.water:getHeight())
  quadrosDetailColision[34] = newQuad(6 * tamanhoQuadroMapa, 1 * tamanhoQuadroMapa, tamanhoQuadroMapa, tamanhoQuadroMapa, mapa.water:getWidth(), mapa.water:getHeight())

  quadrosDetails[1] = newQuad(0 * tamanhoQuadroMapa, 6 * tamanhoQuadroMapa, tamanhoQuadroMapa, tamanhoQuadroMapa, mapa.img:getWidth(), mapa.img:getHeight())
  quadrosDetails[2] = newQuad(1 * tamanhoQuadroMapa, 6 * tamanhoQuadroMapa, tamanhoQuadroMapa, tamanhoQuadroMapa, mapa.img:getWidth(), mapa.img:getHeight())
  quadrosDetails[3] = newQuad(2 * tamanhoQuadroMapa, 6 * tamanhoQuadroMapa, tamanhoQuadroMapa, tamanhoQuadroMapa, mapa.img:getWidth(), mapa.img:getHeight())
  quadrosDetails[4] = newQuad(3 * tamanhoQuadroMapa, 6 * tamanhoQuadroMapa, tamanhoQuadroMapa, tamanhoQuadroMapa, mapa.img:getWidth(), mapa.img:getHeight())
  quadrosDetails[5] = newQuad(4 * tamanhoQuadroMapa, 6 * tamanhoQuadroMapa, tamanhoQuadroMapa, tamanhoQuadroMapa, mapa.img:getWidth(), mapa.img:getHeight())
  quadrosDetails[6] = newQuad(5 * tamanhoQuadroMapa, 6 * tamanhoQuadroMapa, tamanhoQuadroMapa, tamanhoQuadroMapa, mapa.img:getWidth(), mapa.img:getHeight())
  quadrosDetails[7] = newQuad(6 * tamanhoQuadroMapa, 6 * tamanhoQuadroMapa, tamanhoQuadroMapa, tamanhoQuadroMapa, mapa.img:getWidth(), mapa.img:getHeight())
  quadrosDetails[8] = newQuad(7 * tamanhoQuadroMapa, 6 * tamanhoQuadroMapa, tamanhoQuadroMapa, tamanhoQuadroMapa, mapa.img:getWidth(), mapa.img:getHeight())
  quadrosDetails[9] = newQuad(0 * tamanhoQuadroMapa, 15 * tamanhoQuadroMapa, tamanhoQuadroMapa, tamanhoQuadroMapa, mapa.img:getWidth(), mapa.img:getHeight())
  quadrosDetails[10] = newQuad(1 * tamanhoQuadroMapa, 14 * tamanhoQuadroMapa, tamanhoQuadroMapa, tamanhoQuadroMapa, mapa.img:getWidth(), mapa.img:getHeight())
  quadrosDetails[11] = newQuad(5 * tamanhoQuadroMapa, 0 * tamanhoQuadroMapa, tamanhoQuadroMapa, tamanhoQuadroMapa, mapa.img:getWidth(), mapa.img:getHeight())
  quadrosDetails[12] = newQuad(1 * tamanhoQuadroMapa, 16 * tamanhoQuadroMapa, tamanhoQuadroMapa, tamanhoQuadroMapa, mapa.img:getWidth(), mapa.img:getHeight())
  quadrosDetails[13] = newQuad(2 * tamanhoQuadroMapa, 15 * tamanhoQuadroMapa, tamanhoQuadroMapa, tamanhoQuadroMapa, mapa.img:getWidth(), mapa.img:getHeight())
  quadrosDetails[14] = newQuad(0 * tamanhoQuadroMapa, 19 * tamanhoQuadroMapa, tamanhoQuadroMapa, tamanhoQuadroMapa, mapa.img:getWidth(), mapa.img:getHeight())
  quadrosDetails[15] = newQuad(1 * tamanhoQuadroMapa, 19 * tamanhoQuadroMapa, tamanhoQuadroMapa, tamanhoQuadroMapa, mapa.img:getWidth(), mapa.img:getHeight())
  quadrosDetails[16] = newQuad(0 * tamanhoQuadroMapa, 20 * tamanhoQuadroMapa, tamanhoQuadroMapa, tamanhoQuadroMapa, mapa.img:getWidth(), mapa.img:getHeight())
  quadrosDetails[17] = newQuad(0 * tamanhoQuadroMapa, 21 * tamanhoQuadroMapa, tamanhoQuadroMapa, tamanhoQuadroMapa, mapa.img:getWidth(), mapa.img:getHeight())
  quadrosDetails[18] = newQuad(1 * tamanhoQuadroMapa, 21 * tamanhoQuadroMapa, tamanhoQuadroMapa, tamanhoQuadroMapa, mapa.img:getWidth(), mapa.img:getHeight())
  quadrosDetails[19] = newQuad(1 * tamanhoQuadroMapa, 20 * tamanhoQuadroMapa, tamanhoQuadroMapa, tamanhoQuadroMapa, mapa.img:getWidth(), mapa.img:getHeight())
  quadrosDetails[20] = newQuad(6 * tamanhoQuadroMapa, 8 * tamanhoQuadroMapa, tamanhoQuadroMapa, tamanhoQuadroMapa, mapa.img:getWidth(), mapa.img:getHeight())
  quadrosDetails[21] = newQuad(0 * tamanhoQuadroMapa, 8 * tamanhoQuadroMapa, tamanhoQuadroMapa, tamanhoQuadroMapa, mapa.img:getWidth(), mapa.img:getHeight())
  quadrosDetails[22] = newQuad(1 * tamanhoQuadroMapa, 8 * tamanhoQuadroMapa, tamanhoQuadroMapa, tamanhoQuadroMapa, mapa.img:getWidth(), mapa.img:getHeight())
  
  quadrosSob[1] = newQuad(0 * tamanhoQuadroMapa, 1 * tamanhoQuadroMapa, tamanhoQuadroMapa, tamanhoQuadroMapa, mapa.img:getWidth(), mapa.img:getHeight())
  quadrosSob[2] = newQuad(1 * tamanhoQuadroMapa, 1 * tamanhoQuadroMapa, tamanhoQuadroMapa, tamanhoQuadroMapa, mapa.img:getWidth(), mapa.img:getHeight())
  quadrosSob[3] = newQuad(4 * tamanhoQuadroMapa, 1 * tamanhoQuadroMapa, tamanhoQuadroMapa, tamanhoQuadroMapa, mapa.img:getWidth(), mapa.img:getHeight())
  quadrosSob[4] = newQuad(5 * tamanhoQuadroMapa, 1 * tamanhoQuadroMapa, tamanhoQuadroMapa, tamanhoQuadroMapa, mapa.img:getWidth(), mapa.img:getHeight())
  quadrosSob[5] = newQuad(2 * tamanhoQuadroMapa, 33 * tamanhoQuadroMapa, tamanhoQuadroMapa, tamanhoQuadroMapa, mapa.img:getWidth(), mapa.img:getHeight())
  quadrosSob[6] = newQuad(2 * tamanhoQuadroMapa, 34 * tamanhoQuadroMapa, tamanhoQuadroMapa, tamanhoQuadroMapa, mapa.img:getWidth(), mapa.img:getHeight())
  quadrosSob[7] = newQuad(2 * tamanhoQuadroMapa, 35 * tamanhoQuadroMapa, tamanhoQuadroMapa, tamanhoQuadroMapa, mapa.img:getWidth(), mapa.img:getHeight())
  quadrosSob[8] = newQuad(1 * tamanhoQuadroMapa, 33 * tamanhoQuadroMapa, tamanhoQuadroMapa, tamanhoQuadroMapa, mapa.img:getWidth(), mapa.img:getHeight())
  quadrosSob[9] = newQuad(1 * tamanhoQuadroMapa, 34 * tamanhoQuadroMapa, tamanhoQuadroMapa, tamanhoQuadroMapa, mapa.img:getWidth(), mapa.img:getHeight())
  quadrosSob[10] = newQuad(1 * tamanhoQuadroMapa, 35 * tamanhoQuadroMapa, tamanhoQuadroMapa, tamanhoQuadroMapa, mapa.img:getWidth(), mapa.img:getHeight())

  proximaFase = 1
  mapa.correMapa()
 
  -- Definindo as músicas e efeitos sonoros tocados no jogo
  -- musicaFundo = love.audio.newSource("songs/fundo.ogg", "stream")
  --efeitoJogadorAtingido = love.audio.newSource("songs/jogadorAtingido.mp3", "static")
  -- efeitoPegandoItem = love.audio.newSource("songs/pegandoItem.mp3", "static")
  
  -- Configurando as músicas e efeitos sonoros
  -- musicaFundo:setLooping(true)
  -- musicaFundo:play()
end

function mapa.draw(gameState)
  if (gameState =='game') then
    love.graphics.setBackgroundColor(0, 0, 0)

    for posicao, linha in ipairs(mapa.fases[1]) do
      for coluna, quadro in ipairs(linha) do
        love.graphics.draw(mapa.img, quadrosMapa[quadro], (coluna - 1) * tamanhoQuadroMapa, (posicao - 1) * tamanhoQuadroMapa)
      end
    end

    for posicao, linha in ipairs(mapa.fases[3]) do
      for coluna, quadro in ipairs(linha) do
        if quadro ~= 0 then
          love.graphics.draw(mapa.img, quadrosDetails[quadro], (coluna - 1) * tamanhoQuadroMapa, (posicao - 1) * tamanhoQuadroMapa)
        end
      end
    end

    for posicao, linha in ipairs(mapa.fases[2]) do
      for coluna, quadro in ipairs(linha) do
        if quadro ~= 0 then
          if quadro >= 29 then
            love.graphics.draw(mapa.water, quadrosDetailColision[quadro], (coluna - 1) * tamanhoQuadroMapa, (posicao - 1) * tamanhoQuadroMapa)
          else
            love.graphics.draw(mapa.img, quadrosDetailColision[quadro], (coluna - 1) * tamanhoQuadroMapa, (posicao - 1) * tamanhoQuadroMapa)
          end
        end
      end
    end

    for posicao, linha in ipairs(mapa.fases[4]) do
      for coluna, quadro in ipairs(linha) do
        if quadro ~= 0 then
          love.graphics.draw(mapa.img, quadrosSob[quadro], (coluna - 1) * tamanhoQuadroMapa, (posicao - 1) * tamanhoQuadroMapa)
        end
      end
    end
  end
  --[[ for i, quad in ipairs(quadrosIntransponiveis) do
    quad:draw()
  end --]]

  if (gameState == 'boss') then
    mapa.resetaColisao()
    love.graphics.circle('fill', circulo.x, circulo.y, circulo.radius)
    love.graphics.draw(faseBoss.imgBack, 0, 0)
    
    love.graphics.push()
    love.graphics.translate(love.graphics.getWidth() / 2, love.graphics.getHeight() / 2)
    love.graphics.rotate(faseBoss.angle)
    love.graphics.translate(-love.graphics.getWidth() / 2, -love.graphics.getHeight() / 2)
    love.graphics.draw(faseBoss.imgPrato, 0, 0)
    love.graphics.pop()

    --love.graphics.draw(faseBoss.imgPrato,0,0, faseBoss.angle, faseBoss.imgPrato:getWidth()/2, faseBoss.imgPrato:getHeight()/2, faseBoss.imgPrato:getWidth(), faseBoss.imgPrato:getHeight())
  end
end

function mapa.update(dt)
  faseBoss.angle = faseBoss.angle + dt * math.pi / 2
	faseBoss.angle = faseBoss.angle % (2*math.pi)

  if mapaTimer > 0.6 then
    if animationCont == 8 then
      animationCont = 1
    end
    waterAnimation(animationCont)
    animationCont = animationCont + 1
    animationFrame = animationFrame + 2
    if animationFrame == 14 then
      animationFrame = 0
    end
    mapaTimer = 0
  end
  mapaTimer = mapaTimer + dt
end

function waterAnimation()
  quadrosDetailColision[29] = newQuad(((7 * animationCont - 1) + animationCont) * tamanhoQuadroMapa, 0 * tamanhoQuadroMapa, tamanhoQuadroMapa, tamanhoQuadroMapa, mapa.water:getWidth(), mapa.water:getHeight())
  quadrosDetailColision[30] = newQuad(((7 * animationCont - 1) + animationCont) * tamanhoQuadroMapa, 1 * tamanhoQuadroMapa, tamanhoQuadroMapa, tamanhoQuadroMapa, mapa.water:getWidth(), mapa.water:getHeight())
  quadrosDetailColision[31] = newQuad(((7 * animationCont - 1) + animationCont) * tamanhoQuadroMapa, 2 * tamanhoQuadroMapa, tamanhoQuadroMapa, tamanhoQuadroMapa, mapa.water:getWidth(), mapa.water:getHeight())
  quadrosDetailColision[32] = newQuad((6 * animationCont + animationFrame) * tamanhoQuadroMapa, 2 * tamanhoQuadroMapa, tamanhoQuadroMapa, tamanhoQuadroMapa, mapa.water:getWidth(), mapa.water:getHeight())
  quadrosDetailColision[33] = newQuad((6 * animationCont + animationFrame) * tamanhoQuadroMapa, 0 * tamanhoQuadroMapa, tamanhoQuadroMapa, tamanhoQuadroMapa, mapa.water:getWidth(), mapa.water:getHeight())
  quadrosDetailColision[34] = newQuad((6 * animationCont + animationFrame) * tamanhoQuadroMapa, 1 * tamanhoQuadroMapa, tamanhoQuadroMapa, tamanhoQuadroMapa, mapa.water:getWidth(), mapa.water:getHeight())
end

function mapa.correMapa()
  for posicao, linha in ipairs(mapa.fases[1]) do
    for coluna, quadro in ipairs(linha) do
      if quadro ~= 0 then
        if (quadro == 8) then
          quadroNovo = hc.rectangle((coluna - 1) * tamanhoQuadroMapa, (posicao - 1) * tamanhoQuadroMapa,tamanhoQuadroMapa, tamanhoQuadroMapa)
          table.insert(quadrosIntransponiveis, quadroNovo)
        end
      end
    end
  end

  for posicao, linha in ipairs(mapa.fases[2]) do
    for coluna, quadro in ipairs(linha) do
      if quadro ~= 0 then
        quadroNovo = hc.rectangle((coluna - 1) * tamanhoQuadroMapa, (posicao - 1) * tamanhoQuadroMapa,tamanhoQuadroMapa, tamanhoQuadroMapa)
        table.insert(quadrosIntransponiveis, quadroNovo)
      end
    end
  end
end

function mapa.trocaFase() 
  proximaFase = proximaFase + 1
  mapa.resetaColisao()
  if(proximaFase > 2) then
    proximaFase = 2
  end
  mapa.correMapa()
end

function mapa.resetaColisao()
  for i, quad in ipairs(quadrosIntransponiveis) do
    hc.remove(quad)
  end
  quadrosIntransponiveis = {}
end

function mapa.circleAndRectangleOverlap(jogador)
  local circle_distance_x = math.abs(circulo.x - jogador.getPosX() - jogador.getQuadro()/2)
  local circle_distance_y = math.abs(circulo.y - jogador.getPosY() - jogador.getQuadro()/2)

  if circle_distance_x > (jogador.getQuadro()/2 + circulo.radius) or circle_distance_y > (jogador.getQuadro()/2 + circulo.radius) then
    return false
  elseif circle_distance_x <= (jogador.getQuadro()/2) or circle_distance_y <= (jogador.getQuadro()/2) then
    return true
  end
  return (math.pow(circle_distance_x - jogador.getQuadro() / 2, 2) + math.pow(circle_distance_y - jogador.getQuadro() / 2, 2)) <= math.pow(circulo.radius, 2)
end

function mapa.updateAngle(jogador) 
  mapa.angle = mapa.mathAngle(jogador.getPosX(), jogador.getPosY(), circulo.x + circulo.radius / 2, circulo.y + circulo.radius / 2)
  return  mapa.angle
end

function mapa.mathAngle(x1, y1, x2, y2)
  return math.deg(math.atan2(y1 - y2, x1 - x2))
end

return mapa
