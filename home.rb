def main
  puts "Bem vindo ao Pacman"
  puts "Qual é o seu nome?"
  nome = gets.strip
  puts "\n\n\n\n\n"
  puts "#{nome}"
  nome
end

def desenha_mundo(mundo)
  puts mundo
end

def movimentar
  puts "Qual a direção?"
  movimento = gets.strip
end
