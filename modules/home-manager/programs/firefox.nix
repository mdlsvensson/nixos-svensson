{
  programs.firefox.enable = true;
  programs.firefox.profiles."mdlsvensson" = {
    search.force = true;
    search.engines = let everyDay = 24 * 60 * 60 * 1000; in {
      "nixpkgs" = {
        urls = [{
          template = "https://search.nixos.org/packages";
          params = [
            { name = "channel"; value = "unstable";    }
            { name = "query"; value = "{searchTerms}"; }
          ];
        }];
        iconUpdateURL = "https://nixos.wiki/favicon.png";
        updateInterval = everyDay;
        definedAliases = [ "@pkgs" ];
      };
      "nixos-options" = {
        urls = [{
          template = "https://search.nixos.org/options";
          params = [
            { name = "channel"; value = "unstable";    }
            { name = "query"; value = "{searchTerms}"; }
          ];
        }];
        iconUpdateURL = "https://nixos.wiki/favicon.png";
        updateInterval = everyDay;
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
        updateInterval = everyDay;
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
        updateInterval = everyDay;
        definedAliases = [ "@yt" ];
      };
      "wikipedia" = {
        urls = [{
          template = "https://en.wikipedia.org/w/index.php";
          params = [
            { name = "search"; value = "{searchTerms}"; }
          ];
        }];
        iconUpdateURL = "https://en.wikipedia.org/favicon.ico";
        updateInterval = everyDay;
        definedAliases = [ "@wiki" ];
      };
    };
    bookmarks = [
      {
        name = "google-gemini";
        tags = [ "ai" "bot" "google" "chat" ];
        keyword = "ge";
        url = "https://gemini.google.com/";
      }
      {
        name = "easing-functions-cheat-sheet";
        tags = [ "math" "programming" "logic" "gamedev" "trigonometry" ];
        url = "https://easings.net/";
      }
    ];
  };
}