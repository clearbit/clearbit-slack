module Clearbit
  module Slack
    module Helpers
      def format_number(value)
        value.to_s.reverse.gsub(/(\d{3})(?=\d)/, '\\1,').reverse
      end

      def field(title, value, short = true)
        {
          title: title,
          value: value,
          short: short
        }
      end

      def link(url, title, followers = nil)
        if followers
          followers = format_number(followers)
          followers = " (#{followers} followers)"
        end

        "<#{url}|#{title}>#{followers}".strip
      end

      def aboutme(aboutme)
        return unless aboutme.handle
        value = link(
          "https://about.me/#{aboutme.handle}",
          aboutme.handle
        )
        field 'AboutMe', value
      end

      def angellist(angellist)
        return unless angellist.handle
        value = link(
          "https://angel.co/#{angellist.handle}",
          angellist.handle,
          angellist.followers
        )
        field 'AngelList', value
      end

      def github(github)
        return unless github.handle
        value = link(
          "https://github.com/#{github.handle}",
          github.handle,
          github.followers
        )
        field 'GitHub', value
      end

      def facebook(facebook)
        return unless facebook.handle
        value = link(
          "https://www.facebook.com/#{facebook.handle}",
          facebook.handle
        )
        field 'Facebook', value
      end

      def twitter(twitter)
        return unless twitter.handle
        value = link(
          "http://twitter.com/#{twitter.handle}",
          "@#{twitter.handle}",
          twitter.followers
        )
        field 'Twitter', value
      end

      def linkedin(linkedin)
        return unless linkedin.handle
        value = link(
          "https://www.linkedin.com/#{linkedin.handle}",
          linkedin.handle
        )
        field 'LinkedIn', value
      end
    end
  end
end
