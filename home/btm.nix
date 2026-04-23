{ ... }:
{
  programs.bottom = {
    enable = true;
    settings = {
      flags = {
        process_memory_as_value = true;
        tree = true;
        network_use_log = false;
        enable_gpu = true;
        enable_cache_memory = true;
      };

      processes = {
        columns = [
          "PID"
          "Name"
          "CPU%"
          "Mem%"
          "R/s"
          "W/s"
          "T.Read"
          "T.Write"
          "User"
          "State"
          "GMem%"
          "GPU%"
        ];
      };

      styles = {
        tables = {
          headers = {
            color = "#8be9fd";
          };
        };

        cpu = {
          all_entry_color = "#f8f8f2";
          avg_entry_color = "#ffb86c";
          cpu_core_colors = [
            "#bd93f9"
            "#ff79c6"
            "#f1fa8c"
            "#50fa7b"
            "#8be9fd"
            "#ffb86c"
            "#ff5555"
            "#6272a4"
          ];
        };

        memory = {
          ram_color = "#50fa7b";
          swap_color = "#ff79c6";
          gpu_colors = [
            "#bd93f9"
            "#ff79c6"
            "#ffb86c"
            "#8be9fd"
            "#50fa7b"
            "#f1fa8c"
          ];
          arc_color = "#8be9fd";
        };

        network = {
          rx_color = "#50fa7b";
          tx_color = "#ff79c6";
        };

        widgets = {
          widget_title = {
            color = "#bd93f9";
          };
          border_color = "#44475a";
          selected_border_color = "#bd93f9";
          text = {
            color = "#f8f8f2";
          };
          selected_text = {
            color = "#282a36";
            bg_color = "#bd93f9";
          };
        };

        graphs = {
          graph_color = "#44475a";
        };

        battery = {
          high_battery_color = "#50fa7b";
          medium_battery_color = "#f1fa8c";
          low_battery_color = "#ff5555";
        };
      };
    };
  };
}
