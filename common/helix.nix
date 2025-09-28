{ pkgs, ... }: {

  programs.helix = {
    enable = true;
    defaultEditor = true;
    settings = {
      theme = "base16_transparent";
      editor = {
        true-color = true;
        file-picker = { hidden = true; };
      };
    };
    extraPackages = with pkgs; [
      nodePackages.yaml-language-server
      nodePackages.bash-language-server
      nodePackages.prettier
      dockerfile-language-server
      ltex-ls
      nixfmt-classic
      nil
      marksman
      gopls
      lldb
      golangci-lint-langserver
      ansible-language-server
      rubyPackages_3_2.solargraph
      rust-analyzer
      rubocop
      clang-tools
    ];
    languages = {
      language-server.git-commit = {
        command = "ltex-ls";
        config = {
          "ltex.language" = "en-US";
          "ltex.dictionary" = {
            en-US = [
              "kubernetes"
              "Kubernetes"
              "HPA"
              "HPAs"
              "prometheus"
              "Prometheus"
            ];
            en-GB = [ "kubernetes" "Kubernetes" "HPA" "HPAs" ];
          };
        };
      };
      language-server.yaml-language-server = {
        config = {
          yaml = {
            schemas = {
              kubernetes = [
                "/kubernetes/*.yaml"
                "/kubernetes/*.yml"
                "kubectl-edit*"
                "/kustomize/**/resources/*.yaml"
                "/kustomize/**/resources/*.yml"
              ];
              "https://raw.githubusercontent.com/ansible/ansible-lint/main/src/ansiblelint/schemas/ansible.json#/$defs/playbook" =
                [ "ansible/playbook.yml" "ansible/playbook.yaml" ];
              "https://raw.githubusercontent.com/ansible/ansible-lint/main/src/ansiblelint/schemas/inventory.json" =
                [ "ansible/inventory.yml" "ansible/inventory.yaml" ];
            };
            format = { enable = true; };
          };
        };
      };
      language-server.rust-analyzer = {
        config = { check = { command = "clippy"; }; };
      };
      language-server.markdown = {
        command = "ltex-ls";
        config = {
          "ltex.language" = "en-US";
          "ltex.dictionary" = {
            en-US = [
              "kubernetes"
              "Kubernetes"
              "HPA"
              "HPAs"
              "prometheus"
              "Prometheus"
            ];
            en-GB = [ "kubernetes" "Kubernetes" "HPA" "HPAs" ];
          };
        };
      };
      language-server.solargraph = {
        config = {

          diagnostics = true;
          formatting = false;
        };
      };

      language = [
        {
          name = "yaml";
          file-types = [ "yaml" "yml" ];
          formatter = {
            command = "prettier";
            args = [ "--parser" "yaml" ];
          };
          indent = {
            tab-width = 2;
            unit = "  ";
          };
        }
        { name = "rust"; }
        {
          name = "git-commit";
          language-servers = [ "ltex-ls" ];
        }
        {
          name = "markdown";
          language-servers = [ "ltex-ls" "marksman" ];
          file-types = [ "md" ];
          text-width = 120;
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
        {
          name = "jsonnet";
          formatter = {
            command = "jsonnetfmt";
            args = [ "-" ];
          };
        }
        {
          name = "rego";
          indent = {
            unit = " ";
            tab-width = 2;
          };
          auto-format = true;
        }
        {
          name = "ruby";
          formatter = {
            command = "rubocop";
            args =
              [ "--stdin" "foo.rb" "-a" "--stderr" "--fail-level" "fatal" ];
          };
        }
      ];
    };
  };
}
