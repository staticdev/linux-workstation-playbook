{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    nautilus
    papers
    eog
    vlc
  ];

  # enable screen sharing
  xdg = {
    mime =
      let
        web = "brave-browser.desktop";
        inode = "org.gnome.Nautilus.desktop";
        pdf = "org.gnome.Papers.desktop";
        image = "org.gnome.eog.desktop";
        video = "vlc.desktop";
      in
      {
        enable = true;
        addedAssociations = {
          "inode/directory" = [ inode ];
          "x-scheme-handler/http" = [ web ];
          "x-scheme-handler/https" = [ web ];
          "application/pdf" = [ pdf ];
          "image/bmp" = [ image ];
          "image/gif" = [ image ];
          "image/jpg" = [ image ];
          "image/pjpeg" = [ image ];
          "image/png" = [ image ];
          "image/tiff" = [ image ];
          "image/webp" = [ image ];
          "image/x-bmp" = [ image ];
          "image/x-gray" = [ image ];
          "image/x-icb" = [ image ];
          "image/x-ico" = [ image ];
          "image/x-png" = [ image ];
          "image/x-portable-anymap" = [ image ];
          "image/x-portable-bitmap" = [ image ];
          "image/x-portable-graymap" = [ image ];
          "image/x-portable-pixmap" = [ image ];
          "image/x-xbitmap" = [ image ];
          "image/x-xpixmap" = [ image ];
          "image/x-pcx" = [ image ];
          "image/svg+xml" = [ image ];
          "image/svg+xml-compressed" = [ image ];
          "image/vnd.wap.wbmp" = [ image ];
          "image/x-icns" = [ image ];
          "video/x-ogm+ogg" = [ video ];
          "video/3gp" = [ video ];
          "video/3gpp" = [ video ];
          "video/3gpp2" = [ video ];
          "video/dv" = [ video ];
          "video/divx" = [ video ];
          "video/fli" = [ video ];
          "video/flv" = [ video ];
          "video/mp2t" = [ video ];
          "video/mp4" = [ video ];
          "video/mp4v-es" = [ video ];
          "video/mpeg" = [ video ];
          "video/mpeg-system" = [ video ];
          "video/msvideo" = [ video ];
          "video/ogg" = [ video ];
          "video/quicktime" = [ video ];
          "video/vivo" = [ video ];
          "video/vnd.divx" = [ video ];
          "video/vnd.mpegurl" = [ video ];
          "video/vnd.rn-realvideo" = [ video ];
          "video/vnd.vivo" = [ video ];
          "video/webm" = [ video ];
          "video/x-anim" = [ video ];
          "video/x-avi" = [ video ];
          "video/x-flc" = [ video ];
          "video/x-fli" = [ video ];
          "video/x-flic" = [ video ];
          "video/x-flv" = [ video ];
          "video/x-m4v" = [ video ];
          "video/x-matroska" = [ video ];
          "video/x-mjpeg" = [ video ];
          "video/x-mpeg" = [ video ];
          "video/x-mpeg2" = [ video ];
          "video/x-ms-asf" = [ video ];
          "video/x-ms-asf-plugin" = [ video ];
          "video/x-ms-asx" = [ video ];
          "video/x-msvideo" = [ video ];
          "video/x-ms-wm" = [ video ];
          "video/x-ms-wmv" = [ video ];
          "video/x-ms-wmx" = [ video ];
          "video/x-ms-wvx" = [ video ];
          "video/x-nsv" = [ video ];
          "video/x-theora" = [ video ];
          "video/x-theora+ogg" = [ video ];
          "video/x-ogm" = [ video ];
          "video/avi" = [ video ];
          "video/x-mpeg-system" = [ video ];
        };
        defaultApplications = {
          "inode/directory" = [ inode ];
          "x-scheme-handler/http" = [ web ];
          "x-scheme-handler/https" = [ web ];
          "application/pdf" = [ pdf ];
          "image/bmp" = [ image ];
          "image/gif" = [ image ];
          "image/jpg" = [ image ];
          "image/pjpeg" = [ image ];
          "image/png" = [ image ];
          "image/tiff" = [ image ];
          "image/webp" = [ image ];
          "image/x-bmp" = [ image ];
          "image/x-gray" = [ image ];
          "image/x-icb" = [ image ];
          "image/x-ico" = [ image ];
          "image/x-png" = [ image ];
          "image/x-portable-anymap" = [ image ];
          "image/x-portable-bitmap" = [ image ];
          "image/x-portable-graymap" = [ image ];
          "image/x-portable-pixmap" = [ image ];
          "image/x-xbitmap" = [ image ];
          "image/x-xpixmap" = [ image ];
          "image/x-pcx" = [ image ];
          "image/svg+xml" = [ image ];
          "image/svg+xml-compressed" = [ image ];
          "image/vnd.wap.wbmp" = [ image ];
          "image/x-icns" = [ image ];
          "video/x-ogm+ogg" = [ video ];
          "video/3gp" = [ video ];
          "video/3gpp" = [ video ];
          "video/3gpp2" = [ video ];
          "video/dv" = [ video ];
          "video/divx" = [ video ];
          "video/fli" = [ video ];
          "video/flv" = [ video ];
          "video/mp2t" = [ video ];
          "video/mp4" = [ video ];
          "video/mp4v-es" = [ video ];
          "video/mpeg" = [ video ];
          "video/mpeg-system" = [ video ];
          "video/msvideo" = [ video ];
          "video/ogg" = [ video ];
          "video/quicktime" = [ video ];
          "video/vivo" = [ video ];
          "video/vnd.divx" = [ video ];
          "video/vnd.mpegurl" = [ video ];
          "video/vnd.rn-realvideo" = [ video ];
          "video/vnd.vivo" = [ video ];
          "video/webm" = [ video ];
          "video/x-anim" = [ video ];
          "video/x-avi" = [ video ];
          "video/x-flc" = [ video ];
          "video/x-fli" = [ video ];
          "video/x-flic" = [ video ];
          "video/x-flv" = [ video ];
          "video/x-m4v" = [ video ];
          "video/x-matroska" = [ video ];
          "video/x-mjpeg" = [ video ];
          "video/x-mpeg" = [ video ];
          "video/x-mpeg2" = [ video ];
          "video/x-ms-asf" = [ video ];
          "video/x-ms-asf-plugin" = [ video ];
          "video/x-ms-asx" = [ video ];
          "video/x-msvideo" = [ video ];
          "video/x-ms-wm" = [ video ];
          "video/x-ms-wmv" = [ video ];
          "video/x-ms-wmx" = [ video ];
          "video/x-ms-wvx" = [ video ];
          "video/x-nsv" = [ video ];
          "video/x-theora" = [ video ];
          "video/x-theora+ogg" = [ video ];
          "video/x-ogm" = [ video ];
          "video/avi" = [ video ];
          "video/x-mpeg-system" = [ video ];
        };
      };
    portal = {
      enable = true;
      extraPortals = with pkgs; [
        xdg-desktop-portal-wlr
        xdg-desktop-portal-gtk
      ];
    };
  };
}
