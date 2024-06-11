class ERC20Token {
  String name;
  String symbol;
  int decimals;
  int totalSupply;
  Map<String, int> balances;
  Map<String, Map<String, int>> allowances;

  ERC20Token(this.name, this.symbol, this.decimals, this.totalSupply) {
    balances = {};
    allowances = {};
  }

  // Transferir tokens para um endereço
  bool transfer(String to, int amount) {
    if (balances.containsKey(name) && balances[name] >= amount) {
      balances[name] -= amount;
      balances.update(to, (value) => value + amount, ifAbsent: () => amount);
      return true;
    }
    return false;
  }

  // Aprovar uma quantidade de tokens para serem gastos por outro endereço
  bool approve(String spender, int amount) {
    allowances.putIfAbsent(name, () => {});
    allowances[name]![spender] = amount;
    return true;
  }

  // Transferir tokens de um endereço para outro utilizando uma permissão
  bool transferFrom(String from, String to, int amount) {
    if (allowances.containsKey(from) &&
        allowances[from]!.containsKey(name) &&
        allowances[from]![name]! >= amount &&
        balances.containsKey(from) &&
        balances[from]! >= amount) {
      balances[from] -= amount;
      balances.update(to, (value) => value + amount, ifAbsent: () => amount);
      allowances[from]![name]! -= amount;
      return true;
    }
    return false;
  }

  // Consultar o saldo de um endereço
  int balanceOf(String owner) {
    return balances.containsKey(owner) ? balances[owner]! : 0;
  }
}

void main() {
  // Criar contratos ERC-20 para cada token
  var etherD1 = ERC20Token('ETHER D1', 'ETHD1', 18, 10000);
  var etherD2 = ERC20Token('ETHER D2', 'ETHD2', 18, 10000);
  var etherD3 = ERC20Token('ETHER D3', 'ETHD3', 18, 10000);
  var etherD4 = ERC20Token('ETHER D4', 'ETHD4', 18, 10000);
  var etherD5 = ERC20Token('ETHER D5', 'ETHD5', 18, 10000);
  var etherD6 = ERC20Token('ETHER D6', 'ETHD6', 18, 10000);
  var etherD7 = ERC20Token('ETHER D7', 'ETHD7', 18, 10000);
  var etherD8 = ERC20Token('ETHER D8', 'ETHD8', 18, 10000);
  var etherD9 = ERC20Token('ETHER D9', 'ETHD9', 18, 10000);
  var etherD10 = ERC20Token('ETHER D10', 'ETHD10', 18, 10000);

  // Transferir tokens para alguns endereços
  etherD1.transfer('0x123abc', 1000);
  etherD2.transfer('0x456def', 2000);
  etherD3.transfer('0x789ghi', 3000);

  // Verificar saldo de alguns endereços
  print('Saldo de ETHD1 em 0x123abc: ${etherD1.balanceOf('0x123abc')}');
  print('Saldo de ETHD2 em 0x456def: ${etherD2.balanceOf('0x456def')}');
  print('Saldo de ETHD3 em 0x789ghi: ${etherD3.balanceOf('0x789ghi')}');
}
