{ ... }:
{
  programs.claude-code = {
    enable = true;
  };

  programs.git.ignores = [
    "CLAUDE.local.md"
  ];
}
