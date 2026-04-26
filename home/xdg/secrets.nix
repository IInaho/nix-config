{ config, ... }:
{
  xdg.configFile."opencode/config.json" = {
    source = config.lib.file.mkOutOfStoreSymlink "/run/agenix/opencode-json";
  };
  xdg.configFile."claude/settings.json" = {
    source = config.lib.file.mkOutOfStoreSymlink "/run/agenix/claude-settings";
  };
}
