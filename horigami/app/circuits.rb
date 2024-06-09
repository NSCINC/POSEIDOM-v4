

"""Binary IO for circuit objects."""
require 'json'

# Define os formatos dos cabeçalhos
CIRCUIT_HEADER = Struct.new(:global_phase, :num_qubits, :num_clbits, :num_registers, :num_instructions)
CIRCUIT_HEADER_V2 = Struct.new(:global_phase, :num_qubits, :num_clbits, :num_registers, :num_instructions)
CIRCUIT_HEADER_V12 = Struct.new(:global_phase, :num_qubits, :num_clbits, :num_registers, :num_instructions, :num_vars)

# Define os formatos dos registros
REGISTER = Struct.new(:size, :type, :standalone, :in_circuit)
REGISTER_V4 = Struct.new(:size, :type, :standalone, :in_circuit)

# Define os formatos das instruções do circuito
CIRCUIT_INSTRUCTION = Struct.new(
  :name_size,
  :label_size,
  :condition_register_size,
  :num_qargs,
  :num_cargs,
  :num_parameters,
  :has_condition
)
CIRCUIT_INSTRUCTION_V2 = Struct.new(
  :name_size,
  :label_size,
  :condition_register_size,
  :num_qargs,
  :num_cargs,
  :num_parameters,
  :has_condition,
  :conditional_key,
  :ctrl_state,
  :num_ctrl_qubits
)

# Define o formato para as modificações
MODIFIER_DEF = Struct.new(:type, :num_ctrl_qubits, :ctrl_state, :power)

# Define o formato para as definições de calibração
CALIBRATION = Struct.new(:num_cals)

# Define o formato para as definições de calibração de cada instrução
CALIBRATION_DEF = Struct.new(:name_size, :num_qubits, :num_params)

# Define o formato para as definições de operações personalizadas
CUSTOM_CIRCUIT_DEF_HEADER = Struct.new(:size)
CUSTOM_CIRCUIT_INST_DEF = Struct.new(
  :gate_name_size,
  :type,
  :num_qubits,
  :num_clbits,
  :num_ctrl_qubits,
  :ctrl_state,
  :size
)
CUSTOM_CIRCUIT_INST_DEF_V2 = Struct.new(
  :gate_name_size,
  :type,
  :num_qubits,
  :num_clbits,
  :size
)

# Define o formato para as definições de evolução de Pauli
PAULI_EVOLUTION_DEF = Struct.new(:operator_size, :standalone_op, :time_size, :synth_method_size)

# Define o formato para a lista de operadores esparsos de Pauli
SPARSE_PAULI_OP_LIST_ELEM = Struct.new(:size)

# Define o formato para as definições de intervalo
RANGE = Struct.new(:start, :stop, :step)

# Define o formato para as instruções do circuito
CIRCUIT_INSTRUCTION_ARG = Struct.new(:type, :size)

# Define o formato para as definições de operação anotada
ANNO_OP_MODIFIER = Struct.new(:type, :num_ctrl_qubits, :ctrl_state, :power)

# Define o formato para as definições de evolução de Pauli
PAULI_EVOLUTION_DEF = Struct.new(:operator_size, :standalone_op, :time_size, :synth_method_size)

# Define o formato para as definições de evolução de Pauli
SPARSE_PAULI_OP_LIST_ELEM = Struct.new(:size)

# Define o formato para as definições de intervalo
RANGE = Struct.new(:start, :stop, :step)

# Define o formato para as instruções do circuito
CIRCUIT_INSTRUCTION_ARG = Struct.new(:type, :size)

# Define o formato para as modificações
MODIFIER_DEF = Struct.new(:type, :num_ctrl_qubits, :ctrl_state, :power)

# Define o formato para as definições de calibração
CALIBRATION = Struct.new(:num_cals)

# Define o formato para as definições de calibração de cada instrução
CALIBRATION_DEF = Struct.new(:name_size, :num_qubits, :num_params)

# Define o formato para as definições de operações personalizadas
CUSTOM_CIRCUIT_DEF_HEADER = Struct.new(:size)
CUSTOM_CIRCUIT_INST_DEF = Struct.new(
  :gate_name_size,
  :type,
  :num_qubits,
  :num_clbits,
  :num_ctrl_qubits,
  :ctrl_state,
  :size
)
CUSTOM_CIRCUIT_INST_DEF_V2 = Struct.new(
  :gate_name_size,
  :type,
  :num_qubits,
  :num_clbits,
  :size
)

# Define o formato para as definições de evolução de Pauli
PAULI_EVOLUTION_DEF = Struct.new(:operator_size, :standalone_op, :time_size, :synth_method_size)

# Define o formato para a lista de operadores esparsos de Pauli
SPARSE_PAULI_OP_LIST_ELEM = Struct.new(:size)

# Define o formato para as definições de intervalo
RANGE = Struct.new(:start, :stop, :step)

# Define o formato para as instruções do circuito
CIRCUIT_INSTRUCTION_ARG = Struct.new(:type, :size)

def read_header_v12(file_obj, version, vectors, metadata_deserializer)
  data = CIRCUIT_HEADER_V12.new(*file_obj.read(CIRCUIT_HEADER_V12.size).unpack("F*"))

  name = file_obj.read(data.name_size).force_encoding(Encoding::UTF_8)
  global_phase = value.loads_value(
    data.global_phase_type,
    file_obj.read(data.global_phase_size),
    version=version,
    vectors=vectors
  )
  header = {
    global_phase: global_phase,
    num_qubits: data.num_qubits,
    num_clbits: data.num_clbits,
    num_registers: data.num_registers,
    num_instructions: data.num_instructions,
    num_vars: data.num_vars
  }
  metadata_raw = file_obj.read(data.metadata_size)
  metadata = JSON.parse(metadata_raw)
  return header, name, metadata
end

def read_header_v2(file_obj, version, vectors, metadata_deserializer)
  data = CIRCUIT_HEADER_V2.new(*file_obj.read(CIRCUIT_HEADER_V2.size).unpack("F*"))

  name = file_obj.read(data.name_size).force_encoding(Encoding::UTF_8)
  global_phase = value.loads_value(
    data.global_phase_type,
    file_obj.read(data.global_phase_size),
    version=version,
    vectors=vectors
  )
  header = {
    global_phase: global_phase,
    num_qubits: data.num_qubits,
    num_clbits: data.num_clbits,
    num_registers: data.num_registers,
    num_instructions: data.num_instructions
  }

  metadata_raw = file


def _write_pauli_evolution_gate(file_obj, evolution_gate, version):
    operator_list = evolution_gate.operator
    standalone = False
    if not isinstance(operator_list, list):
        operator_list = [operator_list]
        standalone = True
    num_operators = len(operator_list)
require 'json'
require 'stringio'
require 'struct'

def _write_elem(buffer, op)
    elem_data = common.data_to_binary(op.to_list(array: true), method(:np_save))
    elem_metadata = [elem_data.size].pack(formats::SPARSE_PAULI_OP_LIST_ELEM_PACK)
    buffer.write(elem_metadata)
    buffer.write(elem_data)
end

def write_circuit(file_obj, circuit, metadata_serializer: nil, use_symengine: false, version: common::QPY_VERSION)
    metadata_raw = JSON.dump(circuit.metadata, :separators => [',', ':'], :cls => metadata_serializer).encode(common::ENCODE)
    metadata_size = metadata_raw.size
    num_instructions = circuit.size
    circuit_name = circuit.name.encode(common::ENCODE)
    global_phase_type, global_phase_data = value.dumps_value(circuit.global_phase, :version => version)

    registers_buffer = StringIO.new
    num_qregs = _write_registers(registers_buffer, circuit.qregs, circuit.qubits)
    num_cregs = _write_registers(registers_buffer, circuit.cregs, circuit.clbits)
    registers_raw = registers_buffer.string
    num_registers = num_qregs + num_cregs

    # Escrever o cabeçalho do circuito
    if version >= 12
        header_raw = [circuit_name.size, global_phase_type, global_phase_data.size, circuit.num_qubits, circuit.num_clbits, metadata_size, num_registers, num_instructions, circuit.num_vars]
        header = header_raw.pack(formats::CIRCUIT_HEADER_V12_PACK)
        file_obj.write(header)
        file_obj.write(circuit_name)
        file_obj.write(global_phase_data)
        file_obj.write(metadata_raw)
        # Escrever o payload do cabeçalho
        file_obj.write(registers_raw)
        standalone_var_indices = value.write_standalone_vars(file_obj, circuit)
    else
        if circuit.num_vars > 0
            raise exceptions::UnsupportedFeatureForVersion.new("circuits containing realtime variables", :required => 12, :target => version)
        end
        header_raw = [circuit_name.size, global_phase_type, global_phase_data.size, circuit.num_qubits, circuit.num_clbits, metadata_size, num_registers, num_instructions]
        header = header_raw.pack(formats::CIRCUIT_HEADER_V2_PACK)
        file_obj.write(header)
        file_obj.write(circuit_name)
        file_obj.write(global_phase_data)
        file_obj.write(metadata_raw)
        file_obj.write(registers_raw)
        standalone_var_indices = {}
    end

    instruction_buffer = StringIO.new
    custom_operations = {}
    index_map = {"q" => {}, "c" => {}}
    circuit.each do |instruction|
        _write_instruction(instruction_buffer, instruction, custom_operations, index_map, use_symengine, version, :standalone_var_indices => standalone_var_indices)
    end

    custom_operations_buffer = StringIO.new
    new_custom_operations = custom_operations.keys
    until new_custom_operations.empty?
        operations_to_serialize = new_custom_operations.dup
        new_custom_operations.clear
        operations_to_serialize.each do |name|
            operation = custom_operations[name]
            new_custom_operations.concat(_write_custom_operation(custom_operations_buffer, name, operation, custom_operations, use_symengine, version, :standalone_var_indices => standalone_var_indices))
        end
    end

    file_obj.write([custom_operations.size].pack(formats::CUSTOM_CIRCUIT_DEF_HEADER_PACK))
    file_obj.write(custom_operations_buffer.string)

    file_obj.write(instruction_buffer.string)

    # Escrever calibrações
    _write_calibrations(file_obj, circuit.calibrations, metadata_serializer, :version => version)
    _write_layout(file_obj, circuit)
end
