#for random strings
resource "random_string" "myrandom" {
  length = 5
  upper = false
  numeric = false
}