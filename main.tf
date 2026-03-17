data "aws_vpc" "default" {
  default = true
}

data "aws_subnets" "default" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}

# -----------------------------
# SECURITY GROUP
# -----------------------------

resource "aws_security_group" "react_sg" {
  name_prefix = "react-app-"
  description = "Allow HTTP and SSH"
  vpc_id      = data.aws_vpc.default.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# -----------------------------
# LAUNCH TEMPLATE
# -----------------------------

resource "aws_launch_template" "react_lt" {
  name_prefix   = "react-template-"
  image_id      = "ami-019715e0d74f695be"
  instance_type = "t3.micro"

  key_name = "terraform-server-key"

  user_data = base64encode(<<-EOF
#!/bin/bash
apt-get update -y
apt-get install -y nginx git curl
systemctl start nginx
systemctl enable nginx

curl -fsSL https://deb.nodesource.com/setup_18.x | bash -
apt-get install -y nodejs

git clone https://github.com/Sumantswain/React.js-project.git /home/ubuntu/react-app
chown -R ubuntu:ubuntu /home/ubuntu/react-app

cd /home/ubuntu/react-app
npm install
npm run build

rm -rf /var/www/html/*
cp -r dist/* /var/www/html/

systemctl restart nginx
EOF
  )

  vpc_security_group_ids = [aws_security_group.react_sg.id]
}

# -----------------------------
# TARGET GROUP
# -----------------------------

resource "aws_lb_target_group" "react_tg" {
  name     = "react-target-group"
  port     = 80
  protocol = "HTTP"
  vpc_id   = data.aws_vpc.default.id

  health_check {
    path     = "/"
    protocol = "HTTP"
  }
}

# -----------------------------
# LOAD BALANCER
# -----------------------------

resource "aws_lb" "react_alb" {
  name               = "react-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.react_sg.id]
  subnets            = data.aws_subnets.default.ids
}

# -----------------------------
# LISTENER
# -----------------------------

resource "aws_lb_listener" "react_listener" {
  load_balancer_arn = aws_lb.react_alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.react_tg.arn
  }
}

# -----------------------------
# AUTO SCALING GROUP
# -----------------------------

resource "aws_autoscaling_group" "react_asg" {

  desired_capacity    = 1
  max_size            = 3
  min_size            = 1
  vpc_zone_identifier = data.aws_subnets.default.ids

  launch_template {
    id      = aws_launch_template.react_lt.id
    version = "$Latest"
  }

  target_group_arns = [aws_lb_target_group.react_tg.arn]

  tag {
    key                 = "Name"
    value               = "React-AutoScale-Instance"
    propagate_at_launch = true
  }

  health_check_type = "ELB"
}

# -----------------------------
# SCALING POLICY
# -----------------------------

resource "aws_autoscaling_policy" "cpu_policy" {
  name                   = "cpu-scaling-policy"
  autoscaling_group_name = aws_autoscaling_group.react_asg.id
  policy_type            = "TargetTrackingScaling"

  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ASGAverageCPUUtilization"
    }
    target_value = 30.0
  }

  depends_on = [aws_autoscaling_group.react_asg]
}
