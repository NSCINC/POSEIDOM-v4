require 'numo/narray'

# Define a classe FieldElement para representar um elemento de um campo finito
class FieldElement
  FIELD_MODULUS = 21888242871839275222246405745257275088696311157297823662689037894645226208583

  def initialize(value)
    @value = value % FIELD_MODULUS
  end

  def add(other)
    FieldElement.new((@value + other.value) % FIELD_MODULUS)
  end

  def sub(other)
    FieldElement.new((@value - other.value) % FIELD_MODULUS)
  end

  def mul(other)
    FieldElement.new((@value * other.value) % FIELD_MODULUS)
  end

  def div(other)
    inverse = other.value.pow(-1, FIELD_MODULUS)
    FieldElement.new((@value * inverse) % FIELD_MODULUS)
  end

  def exp(exponent)
    FieldElement.new(@value.pow(exponent, FIELD_MODULUS))
  end

  def to_s
    @value.to_s
  end
end

# Teste da classe FieldElement
a = FieldElement.new(10)
b = FieldElement.new(20)
c = a.add(b)
puts c  # Saída: 30
