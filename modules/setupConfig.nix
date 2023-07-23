{ config, pkgs, ... }: 
let
  cfg = config.setupConfig;
in rec {
  options.setupConfig = {
    host = mkOption {
      type = types.str;
      example = "desktop";
      description = "The host configuration to apply.";
    };
    system = mkOption {
      type = types.str;
      example = "x86_64-linux";
      description = "The system architecture.";
    };
    user.name = mkOption {
      type = types.str;
      example = "myUsername";
      description = "Login username.";
    };
    user.homeDirectory = mkOption {
      type = types.path;
      example = /home/myUsername;
      description = "Path to the user home directory.";
    };
    timeZone = mkOption {
      type = types.str;
      default = "Europe/Stockholm";
      example = "America/New_York";
      description = "The system timezone.";
    };
    defaultLocale = mkOption {
      type = types.str;
      default = "en_US.UTF-8";
      example = "en_US.UTF-8";
      description = "The default locale setting.";
    };
    git.userName = mkOption {
      type = types.str;
      example = "myGitUsername";
      description = "The git username setting.";
    };
    git.userEmail = mkOption {
      type = types.str;
      example = "myGitEmail@gmail.com";
      description = "The git email setting.";
    };
  };
}
