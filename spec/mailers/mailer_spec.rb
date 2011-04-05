require "spec_helper"

describe Mailer do
  describe '#invitation' do
    let(:invitation) { Invitation.make! }
    let(:mail) { Mailer.invitation(invitation) }

    it 'renders the headers' do
      mail.subject.should eq 'Приглашение для регистрации на сайте code-for-food.info'
      mail.to.should eq [invitation.recipient_email]
      mail.from.should eq [invitation.sender.email]
    end

    it 'renders registration link in the body' do
      mail.body.encoded.should match(register_url(:invitation_token => invitation.token))
    end

    it 'renders sendgrid category' do
      mail.to_s.should include('invitation-test')
    end
  end

  describe '#menu_published' do
    before(:each) { User.destroy_all }
    let(:menu) { Menu.make! }
    let(:mail) { Mailer.menu_published(menu) }

    it 'renders the headers' do
      mail.subject.should match menu.to_s
      mail.to.should eq ['group-delivery@code-for-food.info']
      mail.from.should eq ['no-reply@code-for-food.info']
    end

    it 'renders the menu order link in the body' do
      mail.body.encoded.should match order_url(menu)
    end

    context 'send grid' do
      it 'assigns multiple recipients' do
        User.make!
        mail # to create Administrator and menu
        emails = User.all.map(&:email)
        emails.size.should > 1
        mail.to_s.should include(emails.to_json)
      end

      it 'does not include unsubscribed recipients' do
        user = User.make! :receive_notifications => false
        mail
        mail.to_s.should_not include(user.email)
      end

      it 'renders sendgrid category' do
        mail.to_s.should include('menu-published-test')
      end
    end
  end

  describe '#feedback' do
    let(:feedback) { Feedback.make }
    let(:mail) { Mailer.feedback(feedback) }

    it 'renders the headers' do
      mail.subject.should =~ /feedback/i
      mail.to.should eq ['paveltyk@code-for-food.info']
      mail.from.should eq [feedback.sender.email]
    end

    it 'renders the message in the body' do
      feedback.body = 'Hello, Man!'
      mail.body.encoded.should =~ /Hello, Man!/i
    end

    it 'renders sendgrid category' do
      mail.to_s.should include('feedback-test')
    end
  end

  describe '#password_reset_instruction' do
    let(:user) { User.make!.tap(&:reset_perishable_token!) }
    let(:mail) { Mailer.password_reset_instruction(user) }

    it 'renders the headers' do
      mail.subject.should =~ /\[Code-for-Food\] Инструкция по восстановлению пароля/i
      mail.to.should eq [user.email]
      mail.from.should eq ['no-reply@code-for-food.info']
    end

    it 'renders the password restore link in the body' do
      mail.body.encoded.should include edit_password_reset_url(user.perishable_token)
    end
  end

end

