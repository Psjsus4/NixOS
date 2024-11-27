{
  buildPythonPackage,
  docker,
  psutil,
}:
buildPythonPackage {
  pname = "getlibs";
  version = "0.1.0";

  src = ./.;

  propagatedBuildInputs = [
    docker
    psutil
  ];
}
