# set up the default root SSH key
resource "aws_key_pair" "root" {
  key_name = "davidski_root"
  public_key = "${file("${path.module}/files/davidski-root-AWS-public.pem")}"
}