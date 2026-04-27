{ pkgs, ... }:

let
  src = pkgs.fetchFromGitHub {
    owner = "tw93";
    repo = "Waza";
    rev = "02c39b53af6877b30b6fadf1ff8703061d079ada";
    sha256 = "0bf8wnpc8yrj0yh1gic1q5fga7mi06li8ha8xgx8x7gvjfi6h0y2";
  };
in
{
  skills = builtins.listToAttrs (
    map (name: {
      inherit name;
      value = "${src}/skills/${name}";
    }) [
      "think"
      "check"
      "hunt"
      "design"
      "read"
      "write"
      "learn"
      "health"
    ]
  );

  rules = {
    chinese = "${src}/rules/chinese.md";
    english = "${src}/rules/english.md";
  };

  context = "${src}/CLAUDE.md";
}
