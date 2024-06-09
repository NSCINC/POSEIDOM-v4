require 'httparty'
require 'json'

# Define os dados do bloco que deseja importar
block_data = {
  number: 123,
  parentHash: "0xabc...",
  coinbase: "0x123...",
  extraData: "0xabc123...",
  transactions: [
    { from: "0xabc...", to: "0xdef...", data: "0x123..." },
    { from: "0xdef...", to: "0xghi...", data: "0x456..." }
  ]
}

# Define a URL para fazer a solicitação POST
url = "http://localhost:8080/import-blocks"

# Faz a solicitação POST para o servidor
response = HTTParty.post(url, body: block_data.to_json, headers: { 'Content-Type' => 'application/json' })

# Verifica o código de status da resposta
if response.code == 200
  puts "Blocos importados com sucesso"
else
  puts "Falha ao importar blocos: #{response.code}"
end
