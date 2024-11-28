{
  stdenv,
  fetchFromGitHub,
  lib,
  qt6,
  pkg-config,
  dbus,
  simpleBluez,
  simpleDBus,
}:
stdenv.mkDerivation (finalAttrs: {
  pname = "zmkBATx";

  version = "1.0.2";

  src = fetchFromGitHub {
    owner = "sefodopo";
    repo = "zmkBATx";
    rev = "update_simpleBluez_0.8.1";
    hash = "sha256-g8ng5pP5rLiSOA81KtQiJOPZJI4P3YwS7DArx5kbWLk=";
  };

  nativeBuildInputs = [
    qt6.wrapQtAppsHook
    pkg-config
    qt6.qmake
  ];

  buildInputs = [
    qt6.qtbase
    qt6.qtconnectivity
    dbus.lib
    simpleBluez
    simpleDBus
  ];

  postPatch = ''
    substituteInPlace zmkBATx.pro --replace-fail "/usr/include/dbus-1.0" "${dbus.dev}/include/dbus-1.0"
    substituteInPlace zmkBATx.pro --replace-fail "/usr/lib/x86_64-linux-gnu/dbus-1.0/include" "${dbus.lib}/lib/dbus-1.0/include"
  '';

  meta = with lib; {
    description = "Battery monitoring for ZMK split keyboards";
    longDescription = "Opensource tool for peripheral battery monitoring zmk split keyboard over BLE for linux.";
    homepage = "https://github.com/mh4x0f/zmkBATx";
    changelog = "https://github.com/mh4x0f/zmkBATx/releases/tag/${finalAttrs.src.rev}";
    license = licenses.mit;
    mainProgram = "zmkbatx";
    platforms = platforms.linux;
    maintainers = with maintainers; [ aciceri ];
  };
})
