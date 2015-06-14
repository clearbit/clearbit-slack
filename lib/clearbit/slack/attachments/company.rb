module Clearbit
  module Slack
    module Attachments
      class Company
        include Helpers
        attr_reader :company

        def initialize(company)
          @company = company
        end

        def as_json(options = {})
          {
            author_name: company.name,
            author_icon: company.logo,
            text: company.description,
            color: color,
            fields: fields.compact
          }
        end

        private

        def color
          'good'
        end

        def fields
          [
            website,
            raised,
            location,
            employees,
            angellist(company.angellist),
            facebook(company.facebook),
            linkedin(company.linkedin),
            twitter(company.twitter),
          ]
        end

        def employees
          return unless company.employees
          field 'Employees', format_number(company.employees)
        end

        def location
          return unless company.location
          field 'Location', company.location
        end

        def website
          return unless company.url
          field 'Website', company.url
        end

        def raised
          return unless company.raised
          field 'Raised', "$#{format_number(company.raised)}"
        end
      end
    end
  end
end
