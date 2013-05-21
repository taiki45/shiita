# Set your API key
export GOOGLE_KEY="your_client_key"
export GOOGLE_SECRET="your_client_secret"

# Fill your company's email domain such as "@company.com".
# Shiita uses this value for complement.
# See app/controllers/users_controller.rb
export SHIITA_DOMAIN="email_domain" # for development
export REMOTE_SHIITA_DOMAIN="email domain for production"


# For production
#
export SHIITA_USER="username in your remote system"
export SHIITA_GROUP="group in your remote system"

# if you use local mongodb, set "mongodb://localhost/shiita"
# See more detail at http://mongoid.org/en/mongoid/docs/installation.html#configuration
export DATABASE_URI="mongodb://user:pass@59.1.22.1:27017,59.1.22.2:27017/shiita"


export DEPROY_USER="remote user name"
export DEPROY_SERVER="remote server name or address"
export DEPROY_TO_DIR="remote dir for deploy" # e.g. "/var/www/shiita"
