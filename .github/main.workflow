workflow "Hello world" {
  on = "issues"
  resolves = ["Hello World"]
}

action "Hello World" {
  uses = "vgaidarji/android-github-actions/build@v1.0.0"
  runs = "echo \"olá Frank\""
}
