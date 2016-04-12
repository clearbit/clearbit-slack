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
            author_name: person.name.full_name,
            author_icon: person.avatar,
            text: person.bio,
            color: color,
            fields: fields.compact
          }
        end

        private

        def fields
          [
            email,
            location,
            employment,
            title,
            role,
            seniority,
            linkedin(person.linkedin),
            twitter(person.twitter),
          ]
        end

        def email
          return unless person.email
          field 'Email', person.email
        end

        def title
          return unless person.employment && person.employment.title
          field 'Title', person.employment.title
        end

        def employment
          return unless person.employment && person.employment.name
          field 'Employment', person.employment.name
        end

        def role
          return unless person.employment && person.employment.role
          field 'Role', person.employment.role
        end

        def seniority
          return unless person.employment && person.employment.seniority
          field 'Seniority', person.employment.seniority
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
