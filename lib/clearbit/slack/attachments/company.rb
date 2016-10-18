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
            text: company.description.to_s,
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
            location,
            website,
            type,
            raised,
            employees,
            linkedin(company.linkedin),
            twitter(company.twitter),
            tags,
            tech
          ]
        end

        def location
          return unless company.location
          field 'Location', company.location, false
        end

        def website
          return unless company.url
          field 'Website', company.url
        end

        def type
          return unless company.type
          field 'Type', company.type
        end

        def employees
          return unless company.metrics.employees
          field 'Employees', format_number(company.metrics.employees)
        end

        def raised
          return unless company.metrics.raised
          field 'Raised', "$#{format_number(company.metrics.raised)}"
        end

        def tags
          return unless company.tags
          field 'Tags', company.tags.join(', '), false
        end

        def tech
          return unless company.tech
          field 'Tech', company.tech.join(', '), false
        end
      end
    end
  end
end
