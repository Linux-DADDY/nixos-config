{
  programs.zen-browser.policies.ExtensionSettings = {
    "*".installation_mode = "blocked"; # blocks all addons except the ones specified below
    #Wappalyer
    "wappalyzer@crunchlabz.com" = {
      install_url = "https://addons.mozilla.org/firefox/downloads/latest/wappalyzer/latest.xpi";
      installation_mode = "normal_installed";
      default_area = "menupanel";
    };

    #Github file icon
    "{85860b32-02a8-431a-b2b1-40fbd64c9c69}" = {
      install_url = "https://addons.mozilla.org/firefox/downloads/latest/github-file-icons/latest.xpi";
      installation_mode = "normal_installed";
      default_area = "menupanel";
    };

    # uBlock Origin
    "uBlock0@raymondhill.net" = {
      install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
      installation_mode = "force_installed";
      default_area = "menupanel";
    };

    # Privacy Badger
    "jid1-MnnxcxisBPnSXQ@jetpack" = {
      install_url = "https://addons.mozilla.org/firefox/downloads/latest/privacy-badger17/latest.xpi";
      installation_mode = "force_installed";
      default_area = "menupanel";
    };

    # ClearURLs
    "{74145f27-f039-47ce-a470-a662b129930a}" = {
      install_url = "https://addons.mozilla.org/firefox/downloads/latest/clearurls/latest.xpi";
      installation_mode = "force_installed";
      default_area = "menupanel";
    };

    # Decentraleyes (bonus privacy extension)
    "jid1-BoFifL9Vbdl2zQ@jetpack" = {
      install_url = "https://addons.mozilla.org/firefox/downloads/latest/decentraleyes/latest.xpi";
      installation_mode = "force_installed";
      default_area = "menupanel";
    };

    # DuckDuckGo Privacy Essentials
    #"jid1-ZAdIEUB7XOzOJw@jetpack" = {
    # install_url = "https://addons.mozilla.org/firefox/downloads/latest/duckduckgo-for-firefox/latest.xpi";
    # installation_mode = "force_installed";
    #  default_area = "menupanel";
    #};

    # Dark Reader
    "addon@darkreader.org" = {
      install_url = "https://addons.mozilla.org/firefox/downloads/latest/darkreader/latest.xpi";
      installation_mode = "normal_installed";
      default_area = "menupanel";
    };

    # Proton Pass
    "78272b6fa58f4a1abaac99321d503a20@proton.me" = {
      install_url = "https://addons.mozilla.org/firefox/downloads/latest/proton-pass/latest.xpi";
      installation_mode = "force_installed";
      default_area = "navbar";
    };

    # Proton VPN
    "vpn@proton.ch" = {
      install_url = "https://addons.mozilla.org/firefox/downloads/latest/proton-vpn-firefox-extension/latest.xpi";
      installation_mode = "force_installed";
      default_area = "menupanel";
    };

    # SponsorBlock for YouTube
    "sponsorBlocker@ajay.app" = {
      install_url = "https://addons.mozilla.org/firefox/downloads/latest/sponsorblock/latest.xpi";
      installation_mode = "normal_installed";
      default_area = "menupanel";
    };

    # Return YouTube Dislike
    "{762f9885-5a13-4abd-9c77-433dcd38b8fd}" = {
      install_url = "https://addons.mozilla.org/firefox/downloads/latest/return-youtube-dislikes/latest.xpi";
      installation_mode = "normal_installed";
      default_area = "menupanel";
    };

    # Enhancer for YouTube
    #   "enhancerforyoutube@maximerf.addons.mozilla.org" = {
    # install_url = "https://addons.mozilla.org/firefox/downloads/latest/enhancer-for-youtube/latest.xpi";
    # installation_mode = "normal_installed";
    #  default_area = "menupanel";
    #};

    # Improve YouTube! 🎧 (for YouTube & Videos)
    "{3c6bf0cc-3ae2-42fb-9993-0d33104fdcaf}" = {
      install_url = "https://addons.mozilla.org/firefox/downloads/latest/youtube-addon/latest.xpi";
      installation_mode = "normal_installed";
      default_area = "menupanel";
    };

    # Search by Image
    "{2e5ff8c8-32fe-46d0-9fc8-6b8986621f3c}" = {
      install_url = "https://addons.mozilla.org/firefox/downloads/latest/search_by_image/latest.xpi";
      installation_mode = "normal_installed";
      default_area = "menupanel";
    };

    # Dictionary Anywhere
    "{e90f5de4-8510-4515-9f67-3b6654e1e8c2}" = {
      install_url = "https://addons.mozilla.org/firefox/downloads/latest/dictionary-anyvhere/latest.xpi";
      installation_mode = "force_installed";
      default_area = "menupanel";
    };

    # I still don't care about cookies
    "idcac-pub@guus.ninja" = {
      install_url = "https://addons.mozilla.org/firefox/downloads/latest/istilldontcareaboutcookies/latest.xpi";
      installation_mode = "normal_installed";
      default_area = "menupanel";
    };
  };
}
