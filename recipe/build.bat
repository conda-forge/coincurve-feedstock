rm -r coincurve.egg-info/SOURCES.txt
rm -r libsecp256k1

%PYTHON% setup.py install
