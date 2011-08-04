require 'rails-app-spec'

module RSpec::RubyContentMatchers
  module LicenseFile
    class HaveLicenseFile
      include ::RailsAssist::Artifact::Directory
      include ::RailsAssist::Directory

      attr_reader :name

      def initialize name
        @name = name
      end

      def license_dir
        File.join(app_dir, 'licenses')
      end

      def license_file name
        File.join(license_dir, "#{name}_license.rb")
      end

      def matches? obj, &block
        file_name = license_file(name)
        found = File.file? file_name
        yield File.read(file_name) if block && found
        found
      end

      def failure_message
        "No license file found for #{name} in #{license_dir} as expected"
      end

      def negative_failure_message
        "License file #{name} found in #{license_dir} but was not expected"
      end

    end

    def have_license_file name
      HaveLicenseFile.new name
    end

    class HaveLicenseFiles
      include ::RailsAssist::Artifact::Directory
      include ::RailsAssist::Directory

      attr_reader :names

      def initialize *names
        @names = names.flatten
      end

      def license_dir
        File.join(app_dir, 'licenses')
      end

      def license_file name
        File.join(license_dir, "#{name}_license.rb")
      end

      def matches? obj, &block
        names.flatten.each do |name|
          return false if !File.file? license_file(name)
        end
        true
      end

      def failure_message
        "License files #{names} not found in #{license_dir} as expected"
      end

      def negative_failure_message
        "License files #{names} found in #{license_dir} but was not expected"
      end
    end

    def have_license_files *names
      HaveLicenseFiles.new names
    end
  end
end
