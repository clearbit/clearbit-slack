module Spec
  module Support
    module Helpers
      def parsed_fixture_data(path)
        JSON.parse(fixture_data(path))
      end

      def fixture_data(path)
        File.open("spec/support/fixtures/#{path}", 'rb').read
      end
    end
  end
end
