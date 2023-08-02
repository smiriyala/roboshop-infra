
parameters = [
   //frontend Service Details
  { name = "prod.frontend.catalogue_url", value = "http://catalogue-prod.devopsforyou.online:80/", type = "String" },
  { name = "prod.frontend.user_url", value = "http://user-prod.devopsforyou.online:80/", type = "String" },
  { name = "prod.frontend.cart_url", value = "http://cart-prod.devopsforyou.online:80/", type = "String" },
  { name = "prod.frontend.shipping_url", value = "http://shipping-prod.devopsforyou.online:80/", type = "String" },
  { name = "prod.frontend.payment_url", value = "http://payment-prod.devopsforyou.online:80/", type = "String" },

  //User service Details
  /* Environment=MONGO={{ lookup('aws_ssm', '{{env}}.{{component}}.mongo', region='us-east-1') }}
  Environment=REDIS_HOST={{ lookup('aws_ssm', '{{env}}.{{component}}.redis_host', region='us-east-1') }}
  Environment=MONGO_URL="{{ lookup('aws_ssm', '{{env}}.{{component}}.mongo_url', region='us-east-1') }}" */
  { name = "prod.user.mongo", value = "false", type = "String" },
   { name = "prod.user.documentdb", value = "true", type = "String" },
  { name = "prod.user.redis_host", value = "redis-prod.devopsforyou.online", type = "String" },
  { name = "prod.user.mongo_url", value = "mongodb://mongodb-prod.devopsforyou.online:27017/users", type = "String" },

  //Shipping serice Details
  /* Environment=CART_ENDPOINT={{ lookup('aws_ssm', '{{env}}.{{component}}.cart_endpoint', region='us-east-1') }},
  Environment=DB_HOST={{ lookup('aws_ssm', '{{env}}.{{component}}.db_host', region='us-east-1') }}, */
  { name = "prod.shipping.cart_endpoint", value = "cart-prod.devopsforyou.online:80", type = "String" },
  { name = "prod.shipping.db_host", value = "mysql-prod.devopsforyou.online", type = "String" },


  //Payment Service Dtails
  /* Environment=CART_HOST={{ lookup('aws_ssm', '{{env}}.{{component}}.cart_host', region='us-east-1') }}
  Environment=CART_PORT={{ lookup('aws_ssm', '{{env}}.{{component}}.cart_port', region='us-east-1') }}
  Environment=USER_HOST={{ lookup('aws_ssm', '{{env}}.{{component}}.user_host', region='us-east-1') }}
  Environment=USER_PORT={{ lookup('aws_ssm', '{{env}}.{{component}}.user_port', region='us-east-1') }}
  Environment=AMQP_HOST={{ lookup('aws_ssm', '{{env}}.{{component}}.amqp_host', region='us-east-1') }} */
  { name = "prod.payment.cart_host", value = "cart-prod.devopsforyou.online", type = "String" },
  { name = "prod.payment.cart_port", value = "80", type = "String" },
  { name = "prod.payment.user_host", value = "user-prod.devopsforyou.online", type = "String" },
  { name = "prod.payment.user_port", value = "80", type = "String" },
  { name = "prod.payment.amqp_host", value = "rabbitmq-prod.devopsforyou.online", type = "String" },

  //Catalogue Serive
  /* Environment=MONGO={{ lookup('aws_ssm', '{{env}}.{{component}}.mongo', region='us-east-1') }}
  Environment=MONGO_URL="{{ lookup('aws_ssm', '{{env}}.{{component}}.mongo_url', region='us-east-1') }}" */
  { name = "prod.catalogue.mongo", value = "false", type = "String" },
  { name = "prod.catalogue.documentdb", value = "true", type = "String" },
  { name = "prod.catalogue.mongo_url", value = "mongodb://mongodb-prod.devopsforyou.online:27017/catalogue", type = "String" },
    
   //cart component
  /* Environment=REDIS_HOST={{ lookup('aws_ssm', '{{env}}.{{component}}.redis_host', region='us-east-1') }}
  Environment=CATALOGUE_HOST={{ lookup('aws_ssm', '{{env}}.{{component}}.catalogue_host', region='us-east-1') }}
  Environment=CATALOGUE_PORT={{ lookup('aws_ssm', '{{env}}.{{component}}.catalogue_port', region='us-east-1') }} */
  { name = "prod.cart.redis_host", value = "redis-prod.devopsforyou.online", type = "String" },
  { name = "prod.cart.catalogue_host", value = "catalogue-prod.devopsforyou.online", type = "String" },
  { name = "prod.cart.catalogue_port", value = "80", type = "String" },


  //Dispatch Service
  /* Environment=AMQP_HOST=RABBITMQ-IP
  Environment=AMQP_USER=roboshop
  Environment=AMQP_PASS=roboshop123  
  Environment=AMQP_HOST={{ lookup('aws_ssm', '{{env}}.{{component}}.amqp_host', region='us-east-1') }}*/
  { name = "prod.dispatch.amqp_host", value = "dispatch-prod.devopsforyou.online", type = "String" }, 

  ##Adding APP VERSION from PARAMETERS Store
  { name = "prod.frontend.app_verion", value = "v1.0.0", type = "String" },
  { name = "prod.catalogue.app_verion", value = "v1.0.0", type = "String" },
  { name = "prod.cart.app_verion", value = "v1.0.0", type = "String" },
  { name = "prod.shipping.app_verion", value = "v1.0.0", type = "String" },
  { name = "prod.payment.app_verion", value = "v1.0.0", type = "String" },
  { name = "prod.user.app_verion", value = "v1.0.1", type = "String" },
  { name = "prod.dispatch.app_verion", value = "v1.0.0", type = "String" }

] 


secrets = [
  //total -11
  //catalogue servie
  { name = "prod.catalogue.user", value = "roboshop", type = "SecureString" },
  //dispatch service
  { name = "prod.dispatch.user", value = "roboshop", type = "SecureString" },
  { name = "prod.dispatch.amqp_user", value = "roboshop", type = "SecureString" },
  { name = "prod.dispatch.amqp_pass", value = "roboshop123", type = "SecureString" },
  //Payment Service
  { name = "prod.payment.amqp_user", value = "roboshop", type = "SecureString" },
  { name = "prod.payment.amqp_pass", value = "roboshop123", type = "SecureString" },
  //shipping
  { name = "prod.shipping.user", value = "roboshop", type = "SecureString" },
  //user service
  { name = "prod.user.user", value = "roboshop", type = "SecureString" },
  //mysql main has root password
  { name = "prod.mysql.password", value = "RoboShop@1", type = "SecureString" },
  //rabbitmq Serive user and pass
  { name = "prod.rabbitmq.user", value = "roboshop", type = "SecureString" },
  { name = "prod.rabbitmq.password", value = "roboshop123", type = "SecureString" },


  #Adding USSER NAME AND PASSWORDS FOR THE DOCDB PART OF tf-module-docdb repo
  { name = "prod.docdb.user", value = "admin1", type = "SecureString" },
  { name = "prod.docdb.pass", value = "Roboshop1", type = "SecureString" },

    #Adding USSER NAME AND PASSWORDS FOR THE RDS OF tf-module-rds repo
  { name = "prod.rds.user", value = "admin1", type = "SecureString" },
  { name = "prod.rds.pass", value = "Roboshop1", type = "SecureString" }, 

  #Adding USSER NAME AND PASSWORDS FOR NEXUS REPO Details
  { name = "prod.nexus.user", value = "admin", type = "SecureString" },
  { name = "prod.nexus.pass", value = "admin123", type = "SecureString" }
]