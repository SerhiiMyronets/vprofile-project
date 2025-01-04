resource "aws_security_group" "jenkins-sg" {
  name        = "jenkins-sg"
  vpc_id      = data.aws_vpc.default.id
  description = "Jenkins web Traffic"

  ingress {
    description = "Allow SSH access"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.my_ip_cidr]
  }

  ingress {
    description = "Allow Jenkins access"
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = [var.my_ip_cidr, "0.0.0.0/0"]
  }

  egress {
    description = "Allow all port access"
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "nexus-sg" {
  name        = "nexus-sg"
  vpc_id      = data.aws_vpc.default.id
  description = "Nexus web Traffic"

  ingress {
    description = "Allow SSH access"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.my_ip_cidr]
  }

  ingress {
    description = "Allow nexus access"
    from_port   = 8081
    to_port     = 8081
    protocol    = "tcp"
    cidr_blocks = [var.my_ip_cidr]
  }

  egress {
    description = "Allow all port access"
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "sonar-sg" {
  name        = "sonar-sg"
  vpc_id      = data.aws_vpc.default.id
  description = "Sonar web Traffic"

  ingress {
    description = "Allow SSH access"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.my_ip_cidr]
  }

  ingress {
    description = "Allow nexus access"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = [var.my_ip_cidr]
  }

  egress {
    description = "Allow all port access"
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group_rule" "jenkins_to_sonar" {
  description       = "Allow jenkins to sonar access"
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  security_group_id = aws_security_group.sonar-sg.id
  source_security_group_id = aws_security_group.jenkins-sg.id
}

resource "aws_security_group_rule" "jenkins_to_nexus" {
  description       = "Allow jenkins to nexus access"
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  security_group_id = aws_security_group.nexus-sg.id
  source_security_group_id = aws_security_group.jenkins-sg.id
}

resource "aws_security_group_rule" "sonar_to_jenkins" {
  description       = "Allow sonar to jenkins access"
  type              = "ingress"
  from_port         = 8080
  to_port           = 8080
  protocol          = "tcp"
  security_group_id = aws_security_group.jenkins-sg.id
  source_security_group_id = aws_security_group.sonar-sg.id
}