{
  enable = true;
  profiles."mdlsvensson" = {
    bookmarks = [
      {
        name = "Packages";
        tags = [ "nixos" "nix" "linux" ];
        keyword = "pkgs";
        url = "https://search.nixos.org/packages";
      }
      {
        name = "Options";
        tags = [ "nixos" "nix" "linux" ];
        keyword = "opts";
        url = "https://search.nixos.org/options";
      }
      {
        name = "HM Search";
        tags = [ "nixos" "nix" "linux" "home manager" ];
        keyword = "hm";
        url = "https://mipmip.github.io/home-manager-option-search/";
      }
    ];
    search = {
      force = true;
      engines = {
        "nixpkgs" = {
          urls = [{
            template = "https://search.nixos.org/packages";
            params = [
              { name = "type"; value = "packages"; }
              { name = "query"; value = "{searchTerms}"; }
            ];
          }];
          iconUpdateURL = "https://nixos.wiki/favicon.png";
          updateInterval = 24 * 60 * 60 * 1000; # every day
          definedAliases = [ "@pkgs" ];
        };
        "home-manager" = {
          urls = [{
            template = "https://mipmip.github.io/home-manager-option-search/";
            params = [
              { name = "query"; value = "{searchTerms}"; }
            ];
          }];
          iconUpdateURL = "images/favicon.png";
          updateInterval = 24 * 60 * 60 * 1000; # every day
          definedAliases = [ "@hm" ];
        };
      };
    };
  };
}