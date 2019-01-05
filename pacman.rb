require_relative 'home'

def carrega_mundo(numero)
  arquivo = "mundo#{numero}.txt"
  texto = File.read arquivo
  mundo = texto.split "\n"
end

def coordenadas_jogador(mundo)
  heroi = "H"
  mundo.each_with_index do |linha_atual, linha|
    coluna_heroi = linha_atual.index heroi
    if coluna_heroi != nil
      return [linha, coluna_heroi]
    end
  end
end

def mover(heroi, direcao)
  heroi = heroi.dup
  coordenadas = {
    "w" => [-1, 0],
    "s" => [+1, 0],
    "a" => [0, -1],
    "d" => [0, +1]
  }
  posicao = coordenadas[direcao]
  heroi[0] += posicao[0]
  heroi[1] += posicao[1]
  heroi
end

def coordenada_valida?(mundo, posicao)
  linhas = mundo.size
  colunas = mundo[0].size
  passou_linha = posicao[0] < 0 || posicao[0] >= linhas
  passou_coluna = posicao[1] < 0 || posicao[1] >= colunas

  return false if passou_linha || passou_coluna

  return false if mundo[posicao[0]][posicao[1]] == "X"

  return false if mundo[posicao[0]][posicao[1]] == "G"

  true
end

def posicoes_validas(mundo, novo_mundo, posicao)
  posicoes = []
  baixo = [posicao[0] + 1, posicao[1]]
  if coordenada_valida?(mundo, baixo) && coordenada_valida?(novo_mundo, baixo)
    posicoes << baixo
  end
  cima = [posicao[0] - 1, posicao[1]]
  if coordenada_valida?(mundo, cima) && coordenada_valida?(novo_mundo, cima)
    posicoes << cima
  end
  direita = [posicao[0], posicao[1] + 1]
  if coordenada_valida?(mundo, direita) && coordenada_valida?(novo_mundo, direita)
    posicoes << direita
  end
  esquerda = [posicao[0], posicao[1] - 1]
  if coordenada_valida?(mundo, esquerda) && coordenada_valida?(novo_mundo, esquerda)
    posicoes << esquerda
  end
  posicoes
end

def move_ghost(mundo, novo_mundo, linha, coluna)
  posicoes = posicoes_validas mundo, novo_mundo, [linha, coluna]
  return if posicoes.empty?
  posicao = posicoes[0]
  mundo[linha][coluna] = " "
  novo_mundo[posicao[0]][posicao[1]] = "G"
end

def copia_mundo(mundo)
  novo_mundo = mundo.join("\n").tr("G", " ").split "\n"
end

def move_ghosts(mundo)
  char_ghost = "G"
  novo_mundo = copia_mundo mundo
  mundo.each_with_index do |linha_atual, linha|
    linha_atual.chars.each_with_index do |char_atual, coluna|
      is_ghost = char_atual == char_ghost
      if is_ghost
        move_ghost mundo, novo_mundo, linha, coluna
      end
    end
  end
  novo_mundo
end

def jogar(nome)
  mundo = carrega_mundo 2

  while true
    desenha_mundo mundo
    direcao = movimentar
    heroi = coordenadas_jogador mundo
    nova_posicao = mover heroi, direcao
    next if !coordenada_valida? mundo, nova_posicao
    mundo[heroi[0]][heroi[1]] = " "
    mundo[nova_posicao[0]][nova_posicao[1]] = "H"

    mundo = move_ghosts mundo
  end
end



def inicia_pacman
  nome = main
  jogar nome
end
