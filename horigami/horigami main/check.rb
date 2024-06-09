require 'find'

def check_headers(root_path, spdx_header, files_regex, exclude_regex)
  files_without_header = []

  Find.find(root_path) do |file|
    next unless File.file?(file)
    next unless file.match?(files_regex)
    next if file.match?(exclude_regex)

    content = File.read(file)
    unless content.include?(spdx_header)
      files_without_header << file
    end
  end

  if files_without_header.any?
    puts "Files without headers:"
    files_without_header.each { |file| puts file }
    raise "Files without SPDX header found."
  end
end

# Chamada da função de verificação
check_headers("caminho/para/o/diretorio", "SPDX-License-Identifier: Apache-2.0", ".*", "")
