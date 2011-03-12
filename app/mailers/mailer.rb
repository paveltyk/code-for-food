class Mailer < ActionMailer::Base
  def invitation(invitation)
    @invitation = invitation
    mail :to => invitation.recipient_email,
         :from => invitation.sender.email,
         :subject => 'Приглашение для регистрации на сайте code-for-food.info'
  end

  def menu_published(menu)
    @menu = menu
    add_recipients User.all.map(&:email)
    mail :from => 'no-reply@code-for-food.info',
         :subject => "Опубликовано меню на \"#{@menu}\""
  end

  delegate :add_recipients, :substitute, :uniq_args, :category, :add_filter_setting, :to => :send_grid_header

  def send_grid_header
    @send_grid_header ||= SendGrid::ApiHeader.new
  end

  def mail_with_send_grid(headers={}, &block)
    headers[:to] ||= self.class.smtp_settings[:user_name]
    headers['X-SMTPAPI'] = send_grid_header.to_json
    mail_without_send_grid(headers, &block)
  end
  alias_method_chain :mail, :send_grid
end

