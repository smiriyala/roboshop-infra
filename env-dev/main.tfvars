env = "dev"


vpc = {
    main = {
        vpc_cidr = "10.0.0.0/16"

        public_subnets = {
            public_az1 = {
                name = "public_az1"
                cidr_block = [ "10.0.0.0/24"]
                availability_zone = "us-east-1a"
            }
            public_az2 = {
                name = "public_az2"
                cidr_block = [ "10.0.1.0/24" ]
                availability_zone = "us-east-1a"
            }
        }
        private_subnets = {
            web = {
                name = "websubnet"
                cidr_block = [ "10.0.2.0/24", "10.0.3.0/24" ]
            }
            app = {
                name = "appsubnet"
                cidr_block = [ "10.0.4.0/24", "10.0.5.0/24" ]
            }
            db = {
                name = "dbsubnet"
                cidr_block = [ "10.0.6.0/24", "10.0.7.0/24" ]

            }
        }
    }
}