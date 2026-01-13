class ContactMailer < ApplicationMailer

    def send_notification(member, title, body)
        @body = body
        mail(
          to: member.email,
          subject: title
        )
    end
end
