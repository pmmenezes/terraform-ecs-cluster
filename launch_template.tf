

resource "aws_launch_template" "on_demand" {
  name_prefix            = format("%s-on-demand", var.project_name)
  vpc_security_group_ids = [aws_security_group.main.id]
  update_default_version = true

  block_device_mappings {
    device_name = "/dev/xvda"

    ebs {
      volume_size = var.node_volume_size
      volume_type = var.node_volume_type
    }
  }

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = format("%s-on-demand", var.project_name)
    }
  }

  user_data = base64encode(templatefile("${path.module}/templates/user-data.tpl", {
    ECS_CLUSTER_NAME = var.project_name
  }))


  //  aws iam list-instance-profiles

  iam_instance_profile {
    name = aws_iam_role.main.name
    #   name = "LabInstanceProfile"
  }

  image_id      = var.nodes_ami
  instance_type = var.node_instance_type

}