class Picture < ActiveRecord::Base
	has_attached_file :image, styles: { large: "400x400" }

  belongs_to :user
  belongs_to :house

  validates_attachment :image, content_type: { content_type: ["image/jpeg", "image/png"]}

  def self.enroll(url, person, house_name)


    body = {:image => url, :subject_id => person, :gallery_name => house_name, :selector => "SETPOSE", :symmetricFill => "true"  }
    body = body.to_json

    headers = {
      'content_type' => 'application/json',
      'app_id' => ENV['KAIROS_ID'],
      'app_key' => ENV['KAIROS_KEY']
    }

    response = HTTParty.post('https://api.kairos.com/enroll', { headers: headers, body: body })
    ap response
  end

  def self.recognize(url, house_name)

    threshold = '0.80'

    body = {:image => url, :gallery_name => house_name, :threshold => threshold}
    body = body.to_json


    headers = {
      'content_type' => 'application/json',
      'app_id' => ENV['KAIROS_ID'],
      'app_key' => ENV['KAIROS_KEY']
    }

    response = HTTParty.post('https://api.kairos.com/recognize', { body: body, headers: headers})

    ap response

    successtest = response['images'][0]['transaction']['status']
    # ap successtest
    successtest
    Picture.text(successtest)
  end

  def self.remove_subject(person, house_name)

    body = {:gallery_name => house_name, :subject_id => person}
    body = body.to_json

    headers = {
      :content_type => 'application/json',
      :app_id => ENV['KAIROS_ID'],
      :app_key => ENV['KAIROS_KEY']
    }

    response = HTTParty.post('https://api.kairos.com/gallery/remove_subject', { body: body, headers: headers})
    ap response
  end



  def self.text(status)
    client = Twilio::REST::Client.new ENV['account_sid'], ENV['auth_token']
    from = '+17863726460'
    if status == 'success'
      client.account.messages.create(
        :from => from,
        :to => "+17864496939",
        :body => 'open'
        )
		elsif status == 'lock'
			client.account.messages.create(
        :from => from,
        :to => "+17864496939",
        :body => 'close'
        )
    else
      client.account.messages.create(
        :from => from,
        :to => "+13053262790",
        :body => "Face Didn't Match"
        )
    end
  end
	#new functionality

	 def self.textlights(status)
	   client = Twilio::REST::Client.new ENV['account_sid'], ENV['auth_token']
	   from = '+17863726460'
	   if status == 'on'
	     ap 'lights on'
	     client.account.messages.create(
	       :from => from,
	       :to => "+14159685257",
	       :body => '#LIGHTSON'
	       )
	        elsif status == 'off'
	            client.account.messages.create(
	       :from => from,
	       :to => "+14159685257",
	       :body => '#LIGHTSOFF'
	       )
	   end
	 end


end
