{config,lib,...}:
with lib;
let
cfg = config.features.desktop.joplin;
in
{
  options.features.desktop.joplin.enable = mkEnableOption "Joplin config";
  config = mkIf cfg.enable {

    programs.joplin-desktop  = {
      enable = true;
      extraConfig = {

      #$schema = "https://joplinapp.org/schema/settings.json";
      altInstanceId = "";
      editor.codeView = true;
      sync.target = 2;
      "sync.2.path" = "";
      "editor.pluginCompatibilityBannerDismissedFor" = [ "com.ckant.joplin-plugin-better-code-blocks" "com.hieuthi.joplin.function-plot" "com.hieuthi.joplin.slash-commands" "com.leenzhu.journal" "com.septemberhx.Joplin.Enhancement" "io.github.personalizedrefrigerator.js-draw" "joplin-plugin-knowledge-graph" "joplin.plugin.quick.html.tags" "kensam.joplin.plugin.eztable" "org.yangby.joplin.plugins.enhanced-editing" "plugin.azamahJunior.note-statistics" "plugin.calebjohn.MathMode" "ylc395.joplinOcr" "io.github.jackgruber.backup" ];
      locale = "de_DE";
      dateFormat= "DD.MM.YYYY";
      ocr.enabled= false;
      theme= 2;
      layoutButtonSequence= 1;
      notes.sortOrder.field= "title";
      notes.sortOrder.reverse= false;
      notes.perFieldReverse= { user_updated_time= true; user_created_time= true; title= false; order= false; todo_due= true; todo_completed= true; };
      trackLocation= false;
      notes.listRendererId= "compact";
      markdown.plugin.softbreaks= false;
      markdown.plugin.typographer= false;
      showTrayIcon= true;
      ui.layout= {
        key= "root";
        children= [
        {
          key= "tempContainer-1xi19HLsfF4pKUxn963ZVY";
          children= [
          {
            key= "sideBar";
            visible= true;
          }
          {
            key= "noteList";
            visible= true;
          }
          ];
          width= 252;
          visible= true;
        }
        {
          key= "editor";
          visible= true;
        }
        ];
        visible= true;
      };
      sync.interval= 43200;
      #noteVisiblePanes= [ editor ];
      editor.spellcheckBeta= true;
      #api.token= "caf5337299cc71c5517a48f21b031fa453db9ffc5af15e5f25474b42e58847dc610de12cf0ce07a92ca67412fddaa25a734cb9755f498d4b9770b03fc83245a9";
      revisionService.enabled= false;
      spellChecker.languages= [
          "de"
          "en-GB"
          "en-US"
      ];
      windowContentZoomFactor= 130;
      preferredLightTheme= 2;
      };
    };
  };
}
