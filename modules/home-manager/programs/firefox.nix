{
  programs.firefox.enable = true;
  programs.firefox.profiles."mdlsvensson".search = {
    force = true;
    engines = {
      "nixpkgs" = {
        urls = [{
          template = "https://search.nixos.org/packages";
          params = [
            { name = "channel"; value = "unstable";    }
            { name = "query"; value = "{searchTerms}"; }
          ];
        }];
        iconUpdateURL = "https://nixos.wiki/favicon.png";
        updateInterval = 24 * 60 * 60 * 1000; # every day
        definedAliases = [ "@pkgs" ];
      };
      "opts" = {
        urls = [{
          template = "https://search.nixos.org/options";
          params = [
            { name = "channel"; value = "unstable";    }
            { name = "query"; value = "{searchTerms}"; }
          ];
        }];
        iconUpdateURL = "https://nixos.wiki/favicon.png";
        updateInterval = 24 * 60 * 60 * 1000; # every day
        definedAliases = [ "@opts" ];
      };
      "home-manager" = {
        urls = [{
          template = "https://mipmip.github.io/home-manager-option-search/";
          params = [
            { name = "query"; value = "{searchTerms}"; }
          ];
        }];
        iconUpdateURL = "https://mipmip.github.io/home-manager-option-search/images/favicon.png";
        updateInterval = 24 * 60 * 60 * 1000; # every day
        definedAliases = [ "@hm" ];
      };
      "youtube" = {
        urls = [{
          template = "https://www.youtube.com/results";
          params = [
            { name = "search_query"; value = "{searchTerms}"; }
          ];
        }];
        iconUpdateURL = "https://s.ytimg.com/yts/img/favicon-vfl8qSV2F.ico";
        updateInterval = 24 * 60 * 60 * 1000; # every day
        definedAliases = [ "@yt" ];
      };
    };
  };
}