module Clients
  class Slack
    def initialize(gem_client: ::Slack::Web::Client.new(token: ENV['SLACK_API_TOKEN']))
      @gem_client = gem_client
    end

    def notify_of_changes(changeset)
      gem_client.chat_postMessage(
        text: formatted_message(changeset),
        channel: ENV['SLACK_CHANNEL']
      )
    end

    def formatted_message(changeset)
      message = ""

      message << ":rolled_up_newspaper: Heads up, it looks like changes have been made to the Kickstarter jobs page\n"
      if changeset.added.present?
        message << "*New job listings:*\n"
        message << changeset.added.map(&:to_s).map { |listing| ":heavy_plus_sign: #{listing}" }.join("\n")
      end
      if changeset.removed.present?
        message << "*Removed job listings:*\n"

        message << changeset.removed.map(&:to_s).map { |listing| ":heavy_minus_sign: #{listing}" }.join("\n") if changeset.removed.present?
      end

      message << "\nAre any of these titles relevant to you? If so, you should reach out the the Kickstarter Union bargaining unit about utilizing your recall rights"

      message
    end

    private

    attr_reader :gem_client
  end
end