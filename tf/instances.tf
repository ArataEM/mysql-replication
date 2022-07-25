resource "aws_key_pair" "mysql-repl-key" {
  key_name   = "mysql-repl-key"
  public_key = file(var.public_key)
}

resource "aws_instance" "mysql-repl" {
  count                  = var.replicas
  ami                    = var.image_id
  instance_type          = "t2.micro"
  key_name               = aws_key_pair.mysql-repl-key.key_name
  subnet_id              = aws_subnet.mysql-repl-public1.id
  vpc_security_group_ids = [aws_security_group.mysql-repl-sg.id]

  tags = {
    Name = "mysql-repl-${count.index + 1}"
    Ansible = "true"
    Task = "web_server"
  }
}

output "instance_ip_addr" {
  value = aws_instance.mysql-repl.*.public_ip
}

output "instance_priv_ip_addr" {
  value = aws_instance.mysql-repl.*.private_ip
}

output "instance_dns_addr" {
  value = aws_instance.mysql-repl.*.public_dns
}
