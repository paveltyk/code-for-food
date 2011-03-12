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
  end

end

