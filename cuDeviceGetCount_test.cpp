#include <gtest/gtest.h>
#include <stdio.h>
#include <iostream>
#include <cuda.h>
#include <cuda_runtime_api.h>

using namespace std;


TEST(CudaGetDeviceTest, CudaDeviceGetCount) {
    int device_count = 0;
    // Test to check the number of CUDA devices
    cudaError_t err = cudaGetDeviceCount(&device_count);
    ASSERT_EQ(err, CUDA_SUCCESS)<< "cudaGetDeviceCount failed: " << cudaGetErrorString(err);
    ASSERT_GT(device_count, 0);
}

int main(int argc, char **argv) {
    ::testing::InitGoogleTest(&argc, argv);
    return RUN_ALL_TESTS();
}