#!/bin/bash
nvcc -std=c++11 -I/usr/local/cuda/include -L/usr/local/cuda/lib64 -lcuda -lcudart cuMemcpy_test.cu -o cuMemcpy_test
./cuMemcpy_test