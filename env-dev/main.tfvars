env = "dev"


vpc = {
    main = {
        vpc_cidr = "10.0.0.0/16"

        public_subnets = {
            public = {
                name = "publicsubnet"
                cidr_block = [ "10.0.0.0/24","10.0.1.0/24" ]

            }
        }
        private_subnets = {
            web = {
                name = "websubnet"
                cidr_block = [ "10.0.2.0/24","10.0.3.0/24" ]
            }
            app = {
                name = "appsubnet"
                cidr_block = [ "10.0.4.0/24","10.0.5.0/24" ]
            }
            db = {
                name = "dbsubnet"
                cidr_block = [ "10.0.6.0/24","10.0.7.0/24" ]
            }
        }

    }
}