{
  programs.zen-browser.profiles.default = {
    search = {
      default = "ecosia";
      order = [
        "ecosia"
        "google"
        "youtube"
        "NixOS Packages"
        "Home Manager Options"
        "Wikipedia"
      ];
      force = true;

      engines = let
        # Helper function to create simple search engines
        mkSimpleEngine = url: icon: aliases: {
          urls = [{template = url;}];
          icon = icon;
          definedAliases = aliases;
        };

        # Helper function for NixOS search engines
        mkNixSearchEngine = type: queryParam: aliases: {
          urls = [
            {
              template = "https://search.nixos.org/${type}";
              params = [
                {
                  name = "type";
                  value = type;
                }
                {
                  name = queryParam;
                  value = "{searchTerms}";
                }
              ];
            }
          ];
          icon = "https://nixos.org/favicon.ico";
          definedAliases = aliases;
        };
      in {
        # Hidden engines
        "bing".metaData.hidden = true;

        # Primary search engines
        "google".metaData.Alias = "@g"; # Keeping your original capitalization

        "ecosia" = {
          urls = [
            {
              template = "https://www.ecosia.org/search";
              params = [
                {
                  name = "q";
                  value = "{searchTerms}";
                }
              ];
            }
          ];
          icon = "https://www.ecosia.org/favicon.ico"; # Fixed quote
          definedAliases = ["@eco"];
        };

        # General search engines
        "ddg" =
          mkSimpleEngine
          "https://duckduckgo.com/?q={searchTerms}"
          "https://duckduckgo.com/favicon.ico"
          ["@ddg"];

        "Brave Search" =
          mkSimpleEngine
          "https://search.brave.com/search?q={searchTerms}"
          "https://brave.com/favicon.ico"
          ["@brave"];

        # Media & Reference
        "youtube" =
          mkSimpleEngine
          "https://www.youtube.com/results?search_query={searchTerms}"
          "https://www.youtube.com/favicon.ico"
          ["@yt"];

        "Wikipedia" =
          mkSimpleEngine
          "https://en.wikipedia.org/wiki/Special:Search?search={searchTerms}"
          "https://en.wikipedia.org/favicon.ico"
          ["@wiki"];

        # AI Search engines
        "Perplexity" =
          mkSimpleEngine
          "https://www.perplexity.ai/search?q={searchTerms}"
          "https://www.perplexity.ai/favicon.ico"
          ["@perp"];

        "Phind" =
          mkSimpleEngine
          "https://www.phind.com/search?q={searchTerms}" # Fixed quote
          
          "https://www.phind.com/favicon.ico"
          ["@phind"];

        "Felo" =
          mkSimpleEngine
          "https://felo.ai/search?q={searchTerms}" # Fixed quote
          
          "https://felo.ai/favicon.ico"
          ["@felo"];

        "Crowdview" =
          mkSimpleEngine
          "https://crowdview.ai/search?q={searchTerms}"
          "https://crowdview.ai/favicon.ico"
          ["@crowd"];

        # Development & Technical
        "GitHub" =
          mkSimpleEngine
          "https://github.com/search?q={searchTerms}"
          "https://github.com/favicon.ico"
          ["@gh"];

        "Stack Overflow" =
          mkSimpleEngine
          "https://stackoverflow.com/search?q={searchTerms}"
          "https://stackoverflow.com/favicon.ico"
          ["@so"];

        "DevDocs" =
          mkSimpleEngine
          "https://devdocs.io/#q={searchTerms}"
          "https://devdocs.io/images/icon-64.png"
          ["@devdocs"];

        # NixOS specific
        "NixOS Packages" = mkNixSearchEngine "packages" "query" ["@nixpkg"];
        "NixOS Options" = mkNixSearchEngine "options" "query" ["@nixopt"];

        "Home Manager Options" = {
          urls = [
            {
              template = "https://home-manager-options.extranix.com";
              params = [
                {
                  name = "query";
                  value = "{searchTerms}";
                }
              ];
            }
          ];
          icon = "data:image/svg+xml;utf8,<svg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 100 100'><text y='.9em' font-size='90'>🏠</text></svg>";
          definedAliases = ["@hm"];
        };

        "NixOS Wiki" =
          mkSimpleEngine
          "https://wiki.nixos.org/w/index.php?search={searchTerms}"
          "https://wiki.nixos.org/favicon.ico"
          ["@nixwiki"];

        "MyNixOS" =
          mkSimpleEngine
          "https://mynixos.com/search?q={searchTerms}"
          "https://mynixos.com/favicon.ico"
          ["@mynix"];

        # Package repositories
        "NPM" =
          mkSimpleEngine
          "https://www.npmjs.com/search?q={searchTerms}"
          "https://www.google.com/s2/favicons?domain=npmjs.com"
          ["@npm"];

        "Crates.io" =
          mkSimpleEngine
          "https://crates.io/search?q={searchTerms}"
          "https://crates.io/favicon.ico"
          ["@crates"];

        # Documentation
        "MDN" =
          mkSimpleEngine
          "https://developer.mozilla.org/en-US/search?q={searchTerms}"
          "https://developer.mozilla.org/favicon.ico"
          ["@mdn"];

        "Arch Wiki" =
          mkSimpleEngine
          "https://wiki.archlinux.org/index.php?search={searchTerms}"
          "https://wiki.archlinux.org/favicon.ico"
          ["@arch"];

        # Academic & Research
        "Google Scholar" =
          mkSimpleEngine
          "https://scholar.google.com/scholar?q={searchTerms}"
          "https://scholar.google.com/favicon.ico"
          ["@scholar"];

        "arXiv" =
          mkSimpleEngine
          "https://arxiv.org/search/?query={searchTerms}&searchtype=all"
          "https://arxiv.org/favicon.ico"
          ["@arxiv"];
      };
    };
  };
}
