
parameters = [
   //frontend Service Details
  { name = "dev.frontend.catalogue_url", value = "http://catalogue-dev.devopsforyou.online:8080/", type = "String" },
  { name = "dev.frontend.user_url", value = "http://user-dev.devopsforyou.online:8080/", type = "String" },
  { name = "dev.frontend.cart_url", value = "http://cart-dev.devopsforyou.online:8080/", type = "String" },
  { name = "dev.frontend.shipping_url", value = "http://shipping-dev.devopsforyou.online:8080/", type = "String" },
  { name = "dev.frontend.payment_url", value = "http://payment-dev.devopsforyou.online:8080/", type = "String" },

  //User service Details
  /* Environment=MONGO={{ lookup('aws_ssm', '{{env}}.{{component}}.mongo', region='us-east-1') }}
  Environment=REDIS_HOST={{ lookup('aws_ssm', '{{env}}.{{component}}.redis_host', region='us-east-1') }}
  Environment=MONGO_URL="{{ lookup('aws_ssm', '{{env}}.{{component}}.mongo_url', region='us-east-1') }}" */
  { name = "dev.user.mongo", value = "true", type = "String" },
  { name = "dev.user.redis_host", value = "redis-dev.devopsforyou.online", type = "String" },
  { name = "dev.user.mongo_url", value = "mongodb://mongodb-dev.devopsforyou.online:27017/users", type = "String" },

  //Shipping serice Details
  /* Environment=CART_ENDPOINT={{ lookup('aws_ssm', '{{env}}.{{component}}.cart_endpoint', region='us-east-1') }},
  Environment=DB_HOST={{ lookup('aws_ssm', '{{env}}.{{component}}.db_host', region='us-east-1') }}, */
  { name = "dev.shipping.cart_endpoint", value = "cart-dev.devopsforyou.online:8080", type = "String" },
  { name = "dev.shipping.db_host", value = "mysql-dev.devopsforyou.online", type = "String" },


  //Payment Service Dtails
  /* Environment=CART_HOST={{ lookup('aws_ssm', '{{env}}.{{component}}.cart_host', region='us-east-1') }}
  Environment=CART_PORT={{ lookup('aws_ssm', '{{env}}.{{component}}.cart_port', region='us-east-1') }}
  Environment=USER_HOST={{ lookup('aws_ssm', '{{env}}.{{component}}.user_host', region='us-east-1') }}
  Environment=USER_PORT={{ lookup('aws_ssm', '{{env}}.{{component}}.user_port', region='us-east-1') }}
  Environment=AMQP_HOST={{ lookup('aws_ssm', '{{env}}.{{component}}.amqp_host', region='us-east-1') }} */
  { name = "dev.payment.cart_host", value = "cart-dev.devopsforyou.online", type = "String" },
  { name = "dev.payment.cart_port", value = "8080", type = "String" },
  { name = "dev.payment.user_host", value = "user-dev.devopsforyou.online", type = "String" },
  { name = "dev.payment.user_port", value = "8080", type = "String" },
  { name = "dev.payment.amqp_host", value = "rabbitmq-dev.devopsforyou.online", type = "String" },

  //Catalogue Serive
  /* Environment=MONGO={{ lookup('aws_ssm', '{{env}}.{{component}}.mongo', region='us-east-1') }}
  Environment=MONGO_URL="{{ lookup('aws_ssm', '{{env}}.{{component}}.mongo_url', region='us-east-1') }}" */
  { name = "dev.catalogue.mongo", value = "true", type = "String" },
  { name = "dev.catalogue.mongo_url", value = "mongodb://mongodb-dev.devopsforyou.online:27017/catalogue", type = "String" },
    
   //cart component
  /* Environment=REDIS_HOST={{ lookup('aws_ssm', '{{env}}.{{component}}.redis_host', region='us-east-1') }}
  Environment=CATALOGUE_HOST={{ lookup('aws_ssm', '{{env}}.{{component}}.catalogue_host', region='us-east-1') }}
  Environment=CATALOGUE_PORT={{ lookup('aws_ssm', '{{env}}.{{component}}.catalogue_port', region='us-east-1') }} */
  { name = "dev.cart.redis_host", value = "redis-dev.devopsforyou.online", type = "String" },
  { name = "dev.cart.catalogue_host", value = "catalogue-dev.devopsforyou.online", type = "String" },
  { name = "dev.cart.catalogue_port", value = "8080", type = "String" },


  //Dispatch Service
  /* Environment=AMQP_HOST=RABBITMQ-IP
  Environment=AMQP_USER=roboshop
  Environment=AMQP_PASS=roboshop123  
  Environment=AMQP_HOST={{ lookup('aws_ssm', '{{env}}.{{component}}.amqp_host', region='us-east-1') }}*/
  { name = "dev.dispatch.amqp_host", value = "dispatch-dev.devopsforyou.online", type = "String" }

]   