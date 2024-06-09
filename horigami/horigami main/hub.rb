require 'open-uri'
require 'fileutils'
require 'zip'
require 'securerandom'

class Faketqdm
  def initialize(total: nil, disable: false, unit: nil, *args, **kwargs)
    @total = total
    @disable = disable
    @n = 0
    # Ignore all extra *args and **kwargs lest you want to reinvent tqdm
  end

  def update(n)
    return if @disable

    @n += n
    if @total.nil?
      $stderr.write "\r#{@n:.1f} bytes"
    else
      $stderr.write "\r#{100 * @n / @total.to_f:.1f}%"
    end
    $stderr.flush
  end

  # Don't bother implementing; use real tqdm if you want
  def set_description(*args, **kwargs)
  end

  def write(s)
    $stderr.write "#{s}\n"
  end

  def close
    @disable = true
  end

  def self.enter
    self.new
  end

  def exit(*args)
    return if @disable

    $stderr.write "\n"
  end
end

begin
  require 'tty-progressbar'
  Tqdm = TTY::ProgressBar
rescue LoadError
  Tqdm = Faketqdm
end

# Definindo as funções a serem traduzidas...


def _check_dependencies(m):
    dependencies = _load_attr_from_module(m, VAR_DEPENDENCY)

    if dependencies is not None:
        missing_deps = [pkg for pkg in dependencies if not _check_module_exists(pkg)]
        if len(missing_deps):
            raise RuntimeError(f"Missing dependencies: {', '.join(missing_deps)}")


def _load_entry_from_hubconf(m, model):
    if not isinstance(model, str):
        raise ValueError('Invalid input: model should be a string of function name')

    # Note that if a missing dependency is imported at top level of hubconf, it will
    # throw before this function. It's a chicken and egg situation where we have to
    # load hubconf to know what're the dependencies, but to import hubconf it requires
    # a missing package. This is fine, Python will throw proper error message for users.
    _check_dependencies(m)

    func = _load_attr_from_module(m, model)

    if func is None or not callable(func):
        raise RuntimeError(f'Cannot find callable {model} in hubconf')

    end

