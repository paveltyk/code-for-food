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
  end

  describe '#menu_published' do
    before(:each) { User.destroy_all }
    let(:menu) { Menu.make! }
    let(:mail) { Mailer.menu_published(menu) }

    it 'render the headers' do
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
    end
  end

end

