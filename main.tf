resource "aws_instance" "sales_instance" {
  ami           = "ami-06fcc1f0bc2c8943f"
  instance_type = "t2.micro"
  key_name      ="ec2key"
  tags		= {
  Name		="ec2 instance created by terraform"
}
}


output "instance_type" {
  description = "Type of instance"
  value       = aws_instance.sales_instance.*.instance_type
}
