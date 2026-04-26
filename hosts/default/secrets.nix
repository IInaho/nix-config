{ config, ... }:
{
  age.identityPaths = [ "/home/lznauy/.config/sops/age/keys.txt" ];

  age.secrets.opencode-json = {
    file = ../../secrets/opencode.json.age;
    owner = "lznauy";
    group = "users";
  };

  age.secrets.claude-settings = {
    file = ../../secrets/claude-settings.json.age;
    owner = "lznauy";
    group = "users";
  };
}
