resource "aws_security_group" "WEBSERVER-SG1" {
    name = "WEBSERVER-SG1"
    description = "allowing ssh and http traffic"

    ingress {
      from_port = 22
      to_port = 22
      protocol = "tcp"
      cidr_blocks = [ "0.0.0.0/0" ]
    } 

    ingress {
      from_port = 80  
      to_port = 80
      protocol = "tcp"
      cidr_blocks = [ "0.0.0.0/0" ]

    }

    egress  {
      from_port = 0  
      to_port = 0
      protocol = "-1"
      cidr_blocks = [ "0.0.0.0/0" ]
    } 
  
}

#create EC2-INSTANCE

resource "aws_instance" "webserverforhttp" {
    ami = "ami-076e3a557efe1aa9c"
    instance_type = "t2.micro"
    availability_zone = "ap-south-1a"
    security_groups = ["${aws_security_group.WEBSERVER-SG1.name}"]
    key_name = "aug3rembg"
    user_data = <<-EOF
            #!/bin/bash        
            sudo yum install httpd -y
            sudo systemctl start httpd
            sudo systemctl enable httpd
            sudo yum update -y
            sudo yum install git -y
            git clone https://github.com/karthi007dir/hotel.git
            cd hotel
            sudo su
            mv index.css index.html /var/www/html
    EOF

    tags ={
           name ="WEBPAGE"
    } 
}
