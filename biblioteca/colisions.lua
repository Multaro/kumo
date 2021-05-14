function colidiu(x1, y1, w1, h1, x2, y2, w2, h2)
  return x2 + w2 >= x1 and y2 + h2 >= y1 and x2 <= x1 + w1 and y2 <= y1 + h1
end