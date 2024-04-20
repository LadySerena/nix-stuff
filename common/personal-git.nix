{
  programs.git = {
    enable = true;
    userName = "LadySerena";
    userEmail = "serena.tiede+github@gmail.com";
    aliases = {
      new = "!f() { git checkout -b serena/$1; }; f";
      yeet =
        "!f() { git branch | grep -v ' master$' | grep -v ' main$' | xargs git branch -D; }; f";
      squash-cleanup =
        "!f() { git hide 'draft() - ancestors(branches())'; }; f";
    };
    extraConfig = {
      core = {
        editor = "hx";
        pager = "delta --syntax-theme='GitHub'";
      };

      pull = { rebase = true; };
      init = { defaultBranch = "main"; };
      push = { autoSetupRemote = true; };
      merge = { tool = "meld"; };
      mergetool = { cmd = "meld"; };
      branchless = { core = { mainBranch = "main"; }; };
    };
  };
}
