{ pkgs, ... }:

let
  src = pkgs.fetchFromGitHub {
    owner = "tw93";
    repo = "Kami";
    rev = "a33f1e199c1a91480d67e1abce9f60b76e6512fe";
    sha256 = "0m0mvih2rar8hjgk1927qw32j3w40rliprqgsjhj1jjbhwwhajcj";
  };

  # 构建标准 skill 目录结构（SKILL.md + 支撑文件）
  kami-skill = pkgs.runCommand "kami-skill" { } ''
    mkdir -p $out/kami
    ln -s ${src}/SKILL.md $out/kami/SKILL.md
    ln -s ${src}/references $out/kami/references
    ln -s ${src}/scripts $out/kami/scripts
    ln -s ${src}/assets $out/kami/assets
    ln -s ${src}/styles.css $out/kami/styles.css
  '';
in
{
  skills = {
    kami = "${kami-skill}/kami";
  };

  context = "${src}/CLAUDE.md";
}
