#include <gtest/gtest.h>
#include <stdio.h>
#include <iostream>
#include <cuda.h>
#include <cuda_runtime_api.h>

using namespace std;

TEST(CuMemsetD32Test, CuMemsetD32) {
    // Allocate device memory
    int* device_ptr;
    cudaError_t cudaStatus = cudaMalloc((void**)&device_ptr, 1024);
    ASSERT_EQ(cudaStatus, cudaSuccess) << "cudaMalloc failed: " << cudaGetErrorString(cudaStatus);

    // Set the device memory to a specific value
    unsigned int value = 0xFFFFEFFF;
    CUresult cuStatus = cuMemsetD32((CUdeviceptr)device_ptr, value, 256);
    ASSERT_EQ(cuStatus, CUDA_SUCCESS) << "cuMemsetD32 failed: " << cudaGetErrorString(cudaGetLastError());

    // Verify that the memory was set correctly
    unsigned int* host_ptr = new unsigned int[256];
    cudaStatus = cudaMemcpy(host_ptr, device_ptr, 1024, cudaMemcpyDeviceToHost);
    ASSERT_EQ(cudaStatus, cudaSuccess) << "cudaMemcpy failed: " << cudaGetErrorString(cudaStatus);

    for (int i = 0; i < 256; i++) {
        ASSERT_EQ(host_ptr[i], value) << "Memory at index " << i << " was not set correctly";
    }

    // Clean up
    delete[] host_ptr;
    cudaStatus = cudaFree(device_ptr);
    ASSERT_EQ(cudaStatus, cudaSuccess) << "cudaFree failed: " << cudaGetErrorString(cudaStatus);
}

int main(int argc, char** argv) {
    ::testing::InitGoogleTest(&argc, argv);
    return RUN_ALL_TESTS();
}