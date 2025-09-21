{
  programs.zen-browser.policies = {
    AutofillAddressEnabled = true;
    AutofillCreditCardEnabled = false;
    DisableAppUpdate = true;
    DisableFeedbackCommands = true;
    DisableFirefoxStudies = true;
    DisablePocket = true;
    DisableTelemetry = true;
    DontCheckDefaultBrowser = true;
    NoDefaultBookmarks = true;
    OfferToSaveLogins = false;
    HardwareAcceleration = true;
    EnableTrackingProtection = {
      Value = true;
      Locked = true;
      Cryptomining = true;
      Fingerprinting = true;
    };
    Preferences = {
      "browser.tabs.warnOnClose" = {
        "Value" = false;
        "Status" = "locked";
      };
      # Add more preferences here as needed
    };
    Permissions = {
      Location = {
        BlockNewRequests = true;
        Locked = true;
      };
      #NOTE: Only enable this if you want to disable notify completly.
      #  Notifications = {
      # BlockNewRequests = true;
      #  Locked = true;
      #};
    };
  };
}
