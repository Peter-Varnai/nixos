{
  pkgs,
  lib,
  inputs,
  ...
}:

let
  # Skill list comes from the upstream plugin manifest, so `nix flake update
  # mattpocock-skills` picks up added/removed skills automatically.
  mattpocock = inputs.mattpocock-skills;
  manifest = builtins.fromJSON (builtins.readFile "${mattpocock}/.claude-plugin/plugin.json");
  mattpocockSkills = lib.listToAttrs (
    map (path: {
      name = baseNameOf path;
      value = "${mattpocock}/${lib.removePrefix "./" path}";
    }) manifest.skills
  );
in
{
  programs.claude-code = {
    enable = true;
    package = inputs.claude-code.packages.${pkgs.stdenv.hostPlatform.system}.default;
    skills = mattpocockSkills;
  };
}
