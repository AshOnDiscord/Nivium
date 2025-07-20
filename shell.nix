{ pkgs ? import <nixpkgs> {} }:

let
  qtEnv = with pkgs.qt6; env "custom-qt6" [ qtbase qtdeclarative ];
in pkgs.mkShell {
  buildInputs = [ qtEnv pkgs.qtcreator pkgs.cmake pkgs.gdb ];
  shellHook = ''
    export QML2_IMPORT_PATH="${qtEnv}/lib/qt-6/qml:$QML2_IMPORT_PATH"
  '';
}
