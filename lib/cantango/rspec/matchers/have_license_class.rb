module RSpec::RubyContentMatchers
  module LicenseClass
    def have_license_class name, superclass = 'License::Base'
      superclass ? have_subclass(name.to_s + 'License', superclass) : have_class(name)
    end

    def have_license_classes *names
      names.each do |name|
        return false if !have_license_class(name)
      end
      true
    end
  end
end
