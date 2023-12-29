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
        { name = "git-commit"; }
        {
          name = "markdown";
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
            command = "bundle";
            args = [
              "exec"
              "rubocop"
              "--stdin"
              "foo.rb"
              "-a"
              "--stderr"
              "--fail-level"
              "fatal"
            ];
          };
        }
      ];
    };
  };
}
