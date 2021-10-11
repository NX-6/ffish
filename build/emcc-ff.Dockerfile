FROM emscripten/emsdk:2.0.31

COPY /cpp /cpp

WORKDIR /

RUN mkdir   out/
RUN emcc -o out/stockfish.js \
         cpp/benchmark.cpp \
         cpp/bitbase.cpp \
         cpp/bitboard.cpp \
         cpp/endgame.cpp \
         cpp/evaluate.cpp \
         cpp/main.cpp \
         cpp/material.cpp \
         cpp/misc.cpp \
         cpp/movegen.cpp \
         cpp/movepick.cpp \
         cpp/partner.cpp \
         cpp/parser.cpp \
         cpp/pawns.cpp \
         cpp/piece.cpp \
         cpp/position.cpp \
         cpp/psqt.cpp \
         cpp/search.cpp \
         cpp/thread.cpp \
         cpp/timeman.cpp \
         cpp/tt.cpp \
         cpp/uci.cpp \
         cpp/ucioption.cpp \
         cpp/variant.cpp \
         cpp/xboard.cpp \
         cpp/tune.cpp \
         cpp/syzygy/tbprobe.cpp \
        -Wall \
        -O3 \
        -std=c++11  \
        -DNDEBUG \
        -DIS_64BIT \
        -DNO_PREFETCH \
        -DUSE_POPCNT \
        -flto \
        -I cpp/ \
        -s MODULARIZE=1 \
        -s EXPORT_NAME="Stockfish" \
        -s NO_EXIT_RUNTIME=1 \
        -s USE_PTHREADS=1 \
        -s PTHREAD_POOL_SIZE=1 \
        -s TOTAL_MEMORY=67108864 \
        -s EXPORTED_RUNTIME_METHODS=ccall \
        -s "INCOMING_MODULE_JS_API=['print', 'postRun', 'onAbort', 'onRuntimeInitialized']" \
        -s ASSERTIONS=0 \
        -s ALLOW_MEMORY_GROWTH=1 \
        -s WASM_MEM_MAX=2147483648 \
        --pre-js cpp/pre.js
