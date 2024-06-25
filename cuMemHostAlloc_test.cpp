#include <gtest/gtest.h>
#include <stdio.h>
#include <iostream>
#include <cuda.h>
#include <cuda_runtime_api.h>

using namespace std;



TEST(CuMemHostAllocTest, CuMemHostAlloc) {
    void* host_ptr;
    cudaError_t err = cudaHostAlloc(&host_ptr, 1024, cudaHostAllocDefault);
    ASSERT_EQ(err, cudaSuccess) << "cudaHostAlloc failed: " << cudaGetErrorString(err);

    // Perform additional tests on the allocated host memory
    ASSERT_NE(host_ptr, nullptr) << "Host pointer is null";

    // Free the allocated host memory
    err = cudaFreeHost(host_ptr);
    ASSERT_EQ(err, cudaSuccess) << "cudaFreeHost failed: " << cudaGetErrorString(err);
}


int main(int argc, char** argv) {
    ::testing::InitGoogleTest(&argc, argv);
    return RUN_ALL_TESTS();
}