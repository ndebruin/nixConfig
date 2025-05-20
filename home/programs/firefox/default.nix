{pkgs, pkgs-unstable, nur, lib, ...}:
{
    home.packages = with pkgs; [
        #firefox
    ];

    programs.firefox = {
        enable = true;
        package = pkgs.firefox;

        policies = {
            BlockAboutConfig = false;
            DefaultDownloadDirectory = "\${home}/downloads";
            DisableTelemetry = true;
            DisableFirefoxStudies =true;
            EnableTrackingProtection = true;
            DisablePocket = true;
            DisableFirefoxAccounts = true;
            DisableAccounts = true;
            DisableFirefoxScreenshots = true;
            OverrideFirstRunPage = "";
            OverridePostUpdatePage = "";
            DontCheckDefaultBrowser = true;
            DisplayBookmarksToolbar = "new-tab"; # alternatives: "always" or "newtab"
            DisplayMenuBar = "default-off"; # alternatives: "always", "never" or "default-on"
            SearchBar = "unified"; # alternative: "separate"
            AutofillAddressEnabled = false;
            AutofillCreditCardEnabled = false;
            CaptivePortal = false;
            DisableSetDesktopBackground = true;
            DNSOverHTTPS = "Disabled";
            OfferToSaveLogins = false;
            PasswordManagerEnabled = false;
            DisableMasterPasswordCreation = true;
            SkipTermsOfUse = true;
        };

        profiles."ndebruin" = {
            extensions = with pkgs.nur.repos.rycee.firefox-addons; [
                clearurls
                decentraleyes
                ublock-origin
                bitwarden
                privacy-badger
                darkreader
                don-t-fuck-with-paste
            ];

            id = 0;
            isDefault = true;
            search.default = "DuckDuckGo";
            search.force = true;
            search.order = [
                "DuckDuckGo"
                "Nix Packages"
                "NixOS Wiki"
                "Google"
            ];
            search.engines = {
                "Nix Packages" = {
                    urls = [{
                    template = "https://search.nixos.org/packages";
                        params = [
                            { name = "type"; value = "packages"; }
                            { name = "query"; value = "{searchTerms}"; }
                        ];
                    }];

                    icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
                    definedAliases = [ "@np" ];
                };

                "NixOS Wiki" = {
                    urls = [{ template = "https://nixos.wiki/index.php?search={searchTerms}"; }];
                    iconUpdateURL = "https://nixos.wiki/favicon.png";
                    updateInterval = 24 * 60 * 60 * 1000; # every day
                    definedAliases = [ "@nw" ];
                };

                "Google".metaData.alias = "@g"; # builtin engines only support specifying one additional alias
            };

            settings = {
                "widget.disable-workspace-management" = true;
                "extensions.autoDisableScopes" = 0;
                # performance settings
                "gfx.webrender.all" = true; # force GPU acceleration
                "media.ffmpeg.vaapi.enabled" = true;
                "widget.dmabuf.force-enabled" = true; # required in recent firefoxes

                # disable floating "sharing indicator" window
                "privacy.webrtc.legacyGlobalIndicator" = false;

                # actual settings
                "app.shield.optoutstudies.enabled" = false;
                "app.update.auto" = false; # kinda stupid bc nixOS
                "browser.bookmarks.restore_default_bookmarks" = false;
                "browser.contentblocking.category" = "strict";
                "browser.ctrlTab.recentlyUsedOrder" = false;
                "browser.discovery.enabled" = false;
                "browser.laterrun.enabled" = false;
                "browser.newtabpage.activity-stream.asrouter.userprefs.cfr.addons" = false;
                "browser.newtabpage.activity-stream.asrouter.userprefs.cfr.features" = false;
                "browser.newtabpage.activity-stream.feeds.snippets" = false;
                "browser.newtabpage.activity-stream.improveSearch.topSiteSearchShortcuts.havePinned" = "";
                "browser.newtabpage.activity-stream.improveSearch.topSiteSearchShortcuts.searchEngines" = "";
                "browser.newtabpage.activity-stream.section.highlights.includePocket" = false;
                "browser.newtabpage.activity-stream.showSponsored" = false;
                "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;
                "browser.newtabpage.pinned" = false;
                "browser.protections_panel.infoMessage.seen" = true;
                "browser.quitShortcut.disabled" = false;
                "browser.shell.checkDefaultBrowser" = false;
                "browser.ssb.enabled" = true;
                "browser.toolbars.bookmarks.visibility" = "newtab";
                "browser.urlbar.placeholderName" = "DuckDuckGo";
                "browser.urlbar.suggest.openpage" = true;
                "datareporting.policy.dataSubmissionEnable" = false;
                "datareporting.policy.dataSubmissionPolicyAcceptedVersion" = 2;
                "dom.security.https_only_mode" = true;
                "dom.security.https_only_mode_ever_enabled" = true;
                "extensions.getAddons.showPane" = "lock-false";
                "extensions.htmlaboutaddons.recommendations.enabled" = "lock-false";
                "extensions.pocket.enabled" = "lock-false";
                "identity.fxaccounts.enabled" = false;
                "privacy.trackingprotection.enabled" = true;
                "privacy.trackingprotection.socialtracking.enabled" = true;
                "privacy.globalprivacycontrol.enabled" = true;
        };
        };
    };
}