A simple ruby wrapper for skipio api

`gem install skipio_api`

`require 'skipio'`

# *Usage*

```
service = Skipio.new({ token: Rails.application.secrets.skipio_api, params: @options })
```

# _Contact List_

```
service.contact_list(options) # options = { page: 1, per: 10 } 
```

# _Find Contact_

```
service.find_contact(id) #=> contact_id
``` 

# _Send Message_
```
service.send_message(options) # => { recipients: 'Comma Separated User UUID', message: 'body message' }
```


# _by url_
```
action = :get or :post
url = 'v1/contacts'
options = { params: { Hash: parameters }, json: { Hash: json } }
service.process_by_url(url, action, options)
```
