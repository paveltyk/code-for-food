module SendGrid
  def self.included(base)
    base.class_eval do
      include InstanceMethods
      delegate :add_recipients, :substitute, :uniq_args, :category, :add_filter_setting, :to => :send_grid_header
      alias_method_chain :mail, :send_grid
    end
  end

  module InstanceMethods
    def send_grid_header
      @send_grid_header ||= SendGrid::ApiHeader.new
    end

    def mail_with_send_grid(headers={}, &block)
      headers[:to] ||= self.class.smtp_settings[:user_name]
      headers['X-SMTPAPI'] = send_grid_header.to_json
      mail_without_send_grid(headers, &block)
    end
  end
end

