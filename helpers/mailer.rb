require 'pony'
require 'dotenv'

Dotenv.load

module Mailer

	class << self
		def send_mail(name, mail, subject, text)

			Pony.mail(
				:to => "leclateventos@gmail.com",
				:from => mail,
			    :subject => "Mensaje desde la WEB",
			    :body => "#{name} te ha enviado un mensaje desde la direccion #{mail} diciendo: #{text}",
          :charset => "UTF-8",
			    :via => :smtp,
			    :via_options => {
			      :address              => 'smtp.gmail.com',
			      :port                 => '587',
			      :enable_starttls_auto => true,
			      :user_name            => 'leclateventos',
			      :password             => ENV["MAIL_PASS"],
			        :authentication     => :plain, # :plain, :login, :cram_md5, no auth by default
			        :domain             => 'http://huertask-dev.herokuapp.com' # the HELO domain provided by the client to the server
			    }
			)

		end
	end

end
