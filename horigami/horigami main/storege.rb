# Adiciona docstrings para funções de Storage

module Torch
    # Classe para adicionar documentação a métodos de armazenamento
    module StorageDoc
      def add_docstr_all(method, docstr)
        storage_classes = [
          "StorageBase",
        ]
  
        storage_classes.each do |cls_name|
          cls = Torch::C.const_get(cls_name)
          begin
            cls.method(method).call.doc_string = docstr
          rescue NoMethodError
            next
          end
        end
      end
  
      add_docstr_all(
        "from_file",
        <<~DOCS
          from_file(filename, shared=false, size=0) -> Storage
  
          Cria um armazenamento CPU baseado em um arquivo mapeado na memória.
  
          Se `shared` for `true`, então a memória é compartilhada entre todos os processos.
          Todas as alterações são escritas no arquivo. Se `shared` for `false`, então as alterações no
          armazenamento não afetam o arquivo.
  
          `size` é o número de elementos no armazenamento. Se `shared` for `false`,
          então o arquivo deve conter pelo menos `size * sizeof(Type)` bytes
          (`Type` é o tipo de armazenamento, no caso de um `UnTypedStorage` o arquivo deve conter pelo
          menos `size` bytes). Se `shared` for `true`, o arquivo será criado se necessário.
  
          Args:
              filename (str): nome do arquivo para mapear
              shared (bool): se deve compartilhar a memória (se `MAP_SHARED` ou `MAP_PRIVATE` é passado para o
                              `mmap(2)` subjacente)
              size (int): número de elementos no armazenamento
        DOCS
      )
    end
  end
  