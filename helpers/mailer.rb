require 'pony'
require 'dotenv'

Dotenv.load

module Mailer

	class << self
		def send_mail(name, mail, subject, text)

			Pony.mail(
				:to => "decorabodas.es@gmail.com",
				:from => "decorabodas.es@gmail.com",
			    :subject => "#{subject}",
			    :body => "#{name} te ha enviado un mensaje desde la direccion #{mail} diciendo: #{text}",
			    :via => :smtp,
			    :via_options => {
			      :address              => 'smtp.gmail.com',
			      :port                 => '587',
			      :enable_starttls_auto => true,
			      :user_name            => 'decorabodas.es',
			      :password             => ENV["MAIL_PASS"],
			        :authentication     => :plain, # :plain, :login, :cram_md5, no auth by default
			        :domain             => 'localhost' # the HELO domain provided by the client to the server
			    }
			)
			
		end
	end

end