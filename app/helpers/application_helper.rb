  module ApplicationHelper

    def gravatar_for(user)
      email_address = user.email
  
      # Create the SHA256 hash
      hash = Digest::SHA256.hexdigest(email_address)

      # Set default URL and size parameters
      default = "https://www.example.com/default.jpg"
      size = 150

      # Compile the full URL with URI encoding for the parameters
      params = URI.encode_www_form('d' => default, 's' => size)
      gravatar_url = "https://www.gravatar.com/avatar/#{hash}?=#{params}"
      image_tag(gravatar_url, alt: user.username, class: "rounded-circle", style: "border: solid #919191 5px;")
    end
  end
