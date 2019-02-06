workflow "Hello world" {
  resolves = ["Hello World"]
  on = "issue_comment"
}

action "Hello World" {
  uses = "vgaidarji/android-github-actions/build@v1.0.0"
  runs = "echo \"olá Frank\""
}
