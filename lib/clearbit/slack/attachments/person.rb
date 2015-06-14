module Clearbit
  module Slack
    module Attachments
      class Person
        include Helpers
        attr_reader :person

        def initialize(person)
          @person = person
        end

        def as_json(options = {})
          {
            text: person.bio,
            color: color,
            fields: fields.compact
          }
        end

        private

        def fields
          [
            email,
            employment,
            position,
            location,
            aboutme(person.aboutme),
            angellist(person.angellist),
            facebook(person.facebook),
            linkedin(person.linkedin),
            twitter(person.twitter),
          ]
        end

        def email
          return unless person.email
          field 'Email', person.email
        end

        def employment
          return unless person.employment.name
          field 'Employment', person.employment.name
        end

        def position
          return unless person.employment.title
          field 'Position', person.employment.title
        end

        def location
          return unless person.location
          field 'Location', person.location
        end

        def color
          'good'
        end
      end
    end
  end
end
