{pkgs, ...}:

{
  home.packages = with pkgs;
  let
    python-with-my-packages = python3.withPackages (ps: with ps; [
      numpy
      pandas
      matplotlib
      spyder
      spyder-kernels
      python312Packages.psycopg2
      python312Packages.pyarrow
      python312Packages.marimo
      python312Packages.duckdb
      python312Packages.pysam
      python312Packages.ipykernel
      python312Packages.jupyterlab
      python312Packages.polars
      python312Packages.qtconsole
      python312Packages.newick
      python312Packages.ete3
      python312Packages.xlsx2csv
      python312Packages.flask
      python312Packages.sqlalchemy
      python312Packages.flask-sqlalchemy
      python312Packages.werkzeug
      python312Packages.flask-session
      python312Packages.pyqt6
    ]);
  in
    [
      python-with-my-packages
    ];

}
