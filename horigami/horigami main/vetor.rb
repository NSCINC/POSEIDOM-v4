require 'ast'

def get_source_lines_and_file(obj, error_msg = nil)
    filename = nil
    begin
        filename = obj.method(:source_location).source_location[0]
        sourcelines, file_lineno = obj.method(:source_location).source_location[1], 0
    rescue SystemCallError => e
        msg = "Can't get source for #{obj}. TorchScript requires source access in " \
            "order to carry out compilation, make sure original .py files are " \
            "available."
        msg += "\n" + error_msg if error_msg
        raise SystemCallError.new(msg) from e
    end

    return sourcelines, file_lineno, filename
end

def normalize_source_lines(sourcelines)
    idx = sourcelines.index { |l| l.strip.start_with?("def") }
    return sourcelines if idx.nil?

    fn_def = sourcelines[idx]
    whitespace = fn_def.split("def")[0]
    aligned_prefix = sourcelines[0...idx].map { |s| whitespace + s.strip }
    aligned_suffix = sourcelines[(idx + 1)..].map { |s| whitespace + s.strip }

    aligned_prefix << fn_def
    return aligned_prefix + aligned_suffix
end

class SourceContext
    attr_reader :source, :filename, :file_lineno, :leading_whitespace_len, :uses_true_division, :funcname

    def initialize(source, filename, file_lineno, leading_whitespace_len, uses_true_division=true, funcname=nil)
        @source = source
        @filename = filename
        @file_lineno = file_lineno
        @leading_whitespace_len = leading_whitespace_len
        @uses_true_division = uses_true_division
        @funcname = funcname
    end

    def make_raw_range(start, end_pos)
        # Your implementation here
    end
end

def make_source_context(*args)
    return SourceContext.new(*args)
end

def fake_range
    return SourceContext.new("", nil, 0, 0).make_raw_range(0, 1)
end

ParsedDef = Struct.new(:ast, :ctx, :source, :filename, :file_lineno)

def parse_def(fn)
    sourcelines, file_lineno, filename = get_source_lines_and_file(fn, ErrorReport.call_stack)
    sourcelines = normalize_source_lines(sourcelines)
    source = sourcelines.join("")
    dedent_src = source.strip_heredoc
    py_ast = AST::Node.new(:module, AST.parse(dedent_src))
    if py_ast.children.length != 1 || py_ast.children[0].type != :def
        raise "Expected a single top-level function: #{filename}:#{file_lineno}"
    end
    leading_whitespace_len = source.split("\n", 1)[0].length - dedent_src.split("\n", 1)[0].length
    ctx = make_source_context(source, filename, file_lineno, leading_whitespace_len, true, fn.method_name)
    return ParsedDef.new(py_ast, ctx, source, filename, file_lineno)
end
