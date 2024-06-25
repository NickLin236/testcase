#!/bin/bash
g++ -o cu_init_test cu_init_test.cpp -lgtest -lgtest_main -lcuda -lcudart -pthread
g++ -std=c++11 -I/usr/local/cuda/include -I/usr/local/include/gtest -c cu_init_test.cpp -o cu_init_test.o
nvcc -o cu_init_test cu_init_test.o -lgtest -lgtest_main -lcuda -lcudart -lpthread
chmod +x cu_init_test
./cu_init_test
g++ -std=c++11 -I/usr/local/cuda/include -I/usr/local/include/gtest -c cuDeviceGetCount_test.cpp -o cuDeviceGetCount_test.o
nvcc -o cuDeviceGetCount_test cuDeviceGetCount_test.o -lgtest -lgtest_main -lcuda -lcudart -lpthread
chmod +x cuDeviceGetCount_test
./cuDeviceGetCount_test
g++ -std=c++11 -I/usr/local/cuda/include -I/usr/local/include/gtest -c cuCtxCreate_test.cpp -o cuCtxCreate_test.o
nvcc -o cuCtxCreate_test cuCtxCreate_test.o -lgtest -lgtest_main -lcuda -lcudart -lpthread
chmod +x cuCtxCreate_test
./cuCtxCreate_test
g++ -std=c++11 -I/usr/local/cuda/include -I/usr/local/include/gtest -c cuMemAlloc_test.cpp -o cuMemAlloc_test.o
nvcc -o cuMemAlloc_test cuMemAlloc_test.o -lgtest -lgtest_main -lcuda -lcudart -lpthread
chmod +x cuMemAlloc_test
./cuMemAlloc_test
g++ -std=c++11 -I/usr/local/cuda/include -I/usr/local/include/gtest -c cuMemHostAlloc_test.cpp -o cuMemHostAlloc_test.o
nvcc -o cuMemHostAlloc_test cuMemHostAlloc_test.o -lgtest -lgtest_main -lcuda -lcudart -lpthread
chmod +x cuMemHostAlloc_test
./cuMemHostAlloc_test
g++ -std=c++11 -I/usr/local/cuda/include -I/usr/local/include/gtest -c cuMemHostGetDevicePointer_test.cpp -o cuMemHostGetDevicePointer_test.o
nvcc -o cuMemHostGetDevicePointer_test cuMemHostGetDevicePointer_test.o -lgtest -lgtest_main -lcuda -lcudart -lpthread
chmod +x cuMemHostGetDevicePointer_test
./cuMemHostGetDevicePointer_test
g++ -std=c++11 -I/usr/local/cuda/include -I/usr/local/include/gtest -c cuMemsetD32_test.cpp -o cuMemsetD32_test.o
nvcc -o cuMemsetD32_test cuMemsetD32_test.o -lgtest -lgtest_main -lcuda -lcudart -lpthread
chmod +x cuMemsetD32_test
./cuMemsetD32_test