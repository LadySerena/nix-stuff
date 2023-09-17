{
  programs.helix = {
    enable = true;
    settings = {
      theme = "base16_transparent";
      editor = {
        true-color = true;
        file-picker = { hidden = true; };
      };

    };
    languages = {
      language = [
        {
          name = "yaml";
          file-types = [ "yaml" "yml" ];
          formatter = {
            command = "prettier";
            args = [ "--parser" "yaml" ];
          };
          config = {
            yaml = {
              schemas = {
                kubernetes =
                  [ "/kubernetes/*.yaml" "/kubernetes/*.yml" "kubectl-edit*" ];
                "https://raw.githubusercontent.com/ansible/ansible-lint/main/src/ansiblelint/schemas/ansible.json#/$defs/playbook" =
                  [ "ansible/playbook.yml" "ansible/playbook.yaml" ];
                "https://raw.githubusercontent.com/ansible/ansible-lint/main/src/ansiblelint/schemas/inventory.json" =
                  [ "ansible/inventory.yml" "ansible/inventory.yaml" ];
              };
              format = { enable = true; };
            };
          };
          indent = {
            tab-width = 2;
            unit = "  ";
          };
        }
        {
          name = "rust";
          config = { checkOnSave = { command = "clippy"; }; };
        }
        {
          name = "markdown";
          text-width = 120;
          language-server = { command = "ltex-ls"; };
          formatter = {
            command = "prettier";
            args = [
              "--parser"
              "markdown"
              "--prose-wrap"
              "always"
              "--print-wdith"
              "120"
            ];
          };
        }
        {
          name = "nix";
          auto-format = true;
          formatter = { command = "nixfmt"; };
        }
      ];
    };
  };
}
