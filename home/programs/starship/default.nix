{ pkgs, ... }:

{
  programs.starship = {
    enable = true;
    enableZshIntegration = true;
    package = pkgs.starship;
    settings = {
      add_newline = false;
      battery = {
        full_symbol = "🔋 ";
        charging_symbol = "⚡️ ";
        discharging_symbol = "💀 ";
      };
      character = {
        success_symbol = "[λ](green)";
        error_symbol = "[λ](bold red)";
        vimcmd_symbol = "[y](green)";
        vimcmd_replace_one_symbol = "[y](bold purple)";
        vimcmd_replace_symbol = "[y](bold purple)";
        vimcmd_visual_symbol = "[y](bold yellow)";
        disabled = false;
      };
      command_timeout = 30000;
      erlang = {
        format = "via [e $version](bold red) ";
      };
      git_branch = {
        symbol = "🌱 ";
      };
      git_commit = {
        commit_hash_length = 8;
        tag_symbol = "🔖 ";
      };
      git_state = {
        format = "[($state($progress_current of $progress_total))]($style) ";
        cherry_pick = "[🍒 PICKING](bold red)";
      };
      git_status = {
        conflicted = "🏳 ";
        ahead = "🏎💨 ";
        behind = "😰 ";
        diverged = "😵 ";
        untracked = "🤷‍ ";
        stashed = "📦 ";
        modified = "📝 ";
        staged = "[++($count)](green)";
        renamed = "👅 ";
        deleted = "🗑  ";
      };
      hostname = {
        ssh_only = true;
        format = "on [$hostname](bold red) ";
        disabled = false;
      };
      nix_shell = {
        disabled = false;
        impure_msg = "[impure shell](bold red)";
        pure_msg = "[pure shell](bold green)";
        format = "via [❆ ($name)](bold blue) ";
      };
      "$schema" = "https://starship.rs/config-schema.json";
      terraform = {
        format = "[🏎💨 $version$workspace]($style) ";
      };
      username = {
        style_user = "white bold";
        style_root = "black bold";
        format = "[$user]($style) ";
        disabled = false;
        show_always = true;
      };
    };
  };
}
