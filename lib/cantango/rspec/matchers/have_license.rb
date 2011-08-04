module RSpec::RubyContentMatchers
  module License
    def have_license name
      have_call :licenses, :args => [name.to_sym]
    end

    def have_licenses *names
      have_call :licenses, :args => names.to_symbols
    end
  end
end
