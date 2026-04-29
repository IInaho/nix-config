# wayscrollshot — Wayland 滚动截图工具
# 仓库无 Cargo.lock，使用本地预生成的 lockfile 注入源码后构建。
{
  lib,
  rustPlatform,
  fetchFromGitHub,
  pkg-config,
  clang,
  llvmPackages,
  opencv4,
  libxkbcommon,
  wayland,
  libGL,
}:

let
  version = "0.1.5";

  src = fetchFromGitHub {
    owner = "jswysnemc";
    repo = "wayscrollshot";
    rev = "v${version}";
    hash = "sha256-fosHHKcKT5aJT5Oml6xTWMCPPqCHuXEsKxnUItvbU+Y=";
  };

  # 预生成的 Cargo.lock（仓库不包含，本地 cargo generate-lockfile 生成）
  cargoLock = ./wayscrollshot-Cargo.lock;
in
rustPlatform.buildRustPackage {
  pname = "wayscrollshot";
  inherit version src;

  # 注入预生成的 Cargo.lock
  postUnpack = ''
    cp ${cargoLock} $sourceRoot/Cargo.lock
  '';

  cargoHash = "sha256-NrDXwalYoobCm9orPDnVUnkwzu5kGbeZybR4BA2H9SQ=";

  nativeBuildInputs = [
    pkg-config
    clang
    llvmPackages.libclang
  ];

  buildInputs = [
    opencv4
    libxkbcommon
    wayland
    libGL
  ];

  env = {
    LIBCLANG_PATH = "${llvmPackages.libclang.lib}/lib";
    OPENCV_LINK_PATHS = "${opencv4}/lib";
    OPENCV_INCLUDE_PATHS = "${opencv4}/include/opencv4";
    OPENCV_PACKAGE_PROBE = "disabled";
  };

  meta = {
    description = "Wayland 滚动截图工具，实时捕捉并拼接滚动内容";
    homepage = "https://github.com/jswysnemc/wayscrollshot";
    license = lib.licenses.mit;
    platforms = [ "x86_64-linux" ];
    mainProgram = "wayscrollshot";
  };
}
