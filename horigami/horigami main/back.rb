require 'digest'

class Blake2bfMessageDigest
  def initialize
    @buffer = Array.new(213, 0)
    @buffer_size = 0
  end

  def digest
    if @buffer_size != 213
      raise "Buffer not filled with 213 bytes"
    end
    sha256 = Digest::SHA256.new
    sha256.update(@buffer.pack('C*'))
    sha256.digest
  end

  def update(value)
    if @buffer_size >= 213
      raise "Buffer overflow"
    end
    @buffer[@buffer_size] = value
    @buffer_size += 1
  end

  def update_bytes(bytes)
    bytes.each do |byte|
      update(byte)
    end
  end

  def update_big_endian_int(value)
    bytes = [value].pack('N').bytes
    update_bytes(bytes)
  end

  def reset
    @buffer_size = 0
  end
end

# Testes
message_digest = Blake2bfMessageDigest.new

# Atualizar o digest com 213 bytes
213.times do
  message_digest.update(0)
end

digest = message_digest.digest
puts digest.unpack('H*').first  # Imprime o digest esperado

# Mais testes aqui...
