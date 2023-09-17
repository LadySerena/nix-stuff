{
  programs.git = {
    enable = true;
    userName = "LadySerena";
    userEmail = "serena.tiede+github@gmail.com";
    aliases = {
      amend = "commit --all --amend --no-edit";
      new = "!f() { git checkout -b serena/$1; }; f";
      yeet =
        "!f() { git branch | grep -v ' master$' | grep -v ' main$' | xargs git branch -D; }; f";
    };
    extraConfig = {
      core = { editor = "hx"; };
      pull = { rebase = true; };
      init = { defaultBranch = "main"; };
      push = { autoSetupRemote = true; };
    };
  };
}
