{ pkgs, me, ... }:

{

  primaryUser = me.user-name;

  configurationRevision = pkgs.rev or pkgs.dirtyRev or null;

  stateVersion = 6;

  startup.chime = false;

  defaults = {

    screencapture = {
      location = "/Users/${me.user-name}/Documents/Screenshots";
      disable-shadow = true;
      target = "clipboard";
      show-thumbnail = false;
      type = "png";
    };

    dock = {
      # appswitcher-all-displays = false;
      autohide = true;
      # autohide-delay = 0.5;
      # autohide-time-modifier = 1.0;
      # dashboard-in-overlay = false;
      # enable-spring-load-actions-on-all-items = false;
      # expose-animation-duration = 0.5;
      # expose-group-by-app = true;
      # largesize = 16;
      launchanim = false;
      magnification = false;
      # mineffect = "genie";
      # minimize-to-application = false;
      # mouse-over-hilite-stack = null;
      # mru-spaces = true;
      orientation = "left";
      # scroll-to-open = true;
      show-process-indicators = false;
      show-recents = false;
      showhidden = false;
      static-only = true;
      tilesize = 32;

      wvous-bl-corner = 1;
      wvous-br-corner = 1;
      wvous-tl-corner = 1;
      wvous-tr-corner = 1;
    };

    finder = {
      AppleShowAllExtensions = true;
      AppleShowAllFiles = true;
      FXEnableExtensionChangeWarning = false;
      _FXShowPosixPathInTitle = true;
      _FXSortFoldersFirst = true;
      CreateDesktop = false;
      ShowPathbar = true;
      FXPreferredViewStyle = "Nlsv"; # list view
      FXRemoveOldTrashItems = true;
    };

    iCal = {
      "TimeZone support enabled" = true;
      "first day of week" = "Monday";
    };

    loginwindow.GuestEnabled = false;

    NSGlobalDomain = {
      # AppleEnableMouseSwipeNavigateWithScrolls = true;
      # AppleEnableSwipeNavigateWithScrolls = true;
      AppleFontSmoothing = 2;
      AppleICUForce24HourTime = false;
      AppleInterfaceStyle = "Dark";
      AppleInterfaceStyleSwitchesAutomatically = false;
      AppleIconAppearanceTheme = "TintedDark";
      # AppleKeyboardUIMode = 3;
      # AppleMeasurementUnits = "Inches";
      # AppleMetricUnits = 0;
      # ApplePressAndHoldEnabled = true;
      # AppleScrollerPagingBehavior = false;
      AppleShowAllExtensions = true;
      AppleShowAllFiles = true;
      AppleShowScrollBars = "WhenScrolling";
      # AppleTemperatureUnit = "Celsius";
      # AppleWindowTabbingMode = "fullscreen";
      InitialKeyRepeat = 10;
      KeyRepeat = 1;
      NSAutomaticCapitalizationEnabled = false;
      NSAutomaticDashSubstitutionEnabled = false;
      NSAutomaticPeriodSubstitutionEnabled = false;
      NSAutomaticQuoteSubstitutionEnabled = false;
      NSAutomaticSpellingCorrectionEnabled = false;
      NSAutomaticInlinePredictionEnabled = true;
      # NSAutomaticWindowAnimationsEnabled = true;
      NSDisableAutomaticTermination = false;
      NSDocumentSaveNewDocumentsToCloud = false;
      # NSNavPanelExpandedStateForSaveMode = true;
      # NSNavPanelExpandedStateForSaveMode2 = true;
      # NSScrollAnimationEnabled = true;
      # NSTableViewDefaultSizeMode = 2;
      # NSTextShowsControlCharacters = true;
      # NSUseAnimatedFocusRing = true;
      # NSWindowResizeTime = 0.2;
      # PMPrintingExpandedStateForPrint = false;
      # PMPrintingExpandedStateForPrint2 = false;
      # _HIHideMenuBar = true;

      # "com.apple.keyboard.fnState" = false;
      # "com.apple.mouse.tapBehavior" = null;
      "com.apple.sound.beep.feedback" = 0;
      "com.apple.sound.beep.volume" = 0.0;
      # "com.apple.springing.delay" = 0.5;
      # "com.apple.springing.enabled" = false;
      "com.apple.swipescrolldirection" = true;
      # "com.apple.trackpad.enableSecondaryClick" = true;
      "com.apple.trackpad.scaling" = 1.0;
      "com.apple.trackpad.forceClick" = true;
      # "com.apple.trackpad.trackpadCornerClickBehavior" = 1;
    };

    SoftwareUpdate.AutomaticallyInstallMacOSUpdates = false;

    trackpad = {
      Clicking = true;
      ActuationStrength = 1;
      TrackpadThreeFingerDrag = false;
      ActuateDetents = false;
      FirstClickThreshold = 0;
      SecondClickThreshold = 1;
      TrackpadCornerSecondaryClick = 0;
    };

    magicmouse.MouseButtonMode = "TwoButton";

    menuExtraClock = {
      IsAnalog = true;
      ShowAMPM = false;
      ShowSeconds = false;
    };

    controlcenter.NowPlaying = false;
  };

  keyboard = {
    enableKeyMapping = true;
    remapCapsLockToEscape = true;
  };
}
