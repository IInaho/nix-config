{ pkgs, ... }:

let
  waza = import ./waza.nix { inherit pkgs; };
  kami = import ./kami.nix { inherit pkgs; };

  all-skills = waza.skills // kami.skills;
  all-rules = waza.rules;
  all-context = waza.context + "\n\n" + kami.context;
in
{
  inherit all-skills all-rules all-context;
}
