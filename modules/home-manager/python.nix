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
      psycopg2
      pyarrow
      marimo
      duckdb
      pysam
      ipykernel
      jupyterlab
      polars
      qtconsole
      newick
      ete3
      xlsx2csv
      flask
      sqlalchemy
      flask-sqlalchemy
      werkzeug
      flask-session
      pyqt6

      # For meloTTS
      txtsplit
      torch
      torchaudio
      cached_path
      transformers
      num2words
      unidic_lite
      unidic
      mecab-python3
      pykakasi
      fugashi
      g2p_en
      anyascii
      jamo
      gruut
      g2pkk
      librosa
      pydub
      eng_to_ipa
      inflect
      unidecode
      pypinyin
      cn2an
      jieba
      gradio
      langid
      tqdm
      tensorboard
      loguru

    ]
      ++ gruut.optional-dependencies.de
      ++ gruut.optional-dependencies.es
      ++ gruut.optional-dependencies.fr
    );
    
  in
    [
      python-with-my-packages
    ];

}
