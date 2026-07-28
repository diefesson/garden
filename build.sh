BASE_URL=https://diefesson.github.io/garden

rm -rf docs
(cd garden && hugo build -b $BASE_URL)
mv garden/public docs
