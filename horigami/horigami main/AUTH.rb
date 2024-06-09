require 'numo/narray'

# Função para autenticar o usuário (simulada apenas para exemplo)
def authenticate_user(username, password)
  # Verifica se o nome de usuário e a senha correspondem a um usuário válido
  if username == "user" && password == "password"
    return true
  else
    return false
  end
end

# Teste da função de autenticação
print "Digite o nome de usuário: "
username = gets.chomp
print "Digite a senha: "
password = gets.chomp

if authenticate_user(username, password)
  puts "Usuário autenticado com sucesso!"
else
  puts "Falha na autenticação. Verifique suas credenciais."
end
