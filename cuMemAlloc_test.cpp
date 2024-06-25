#include <gtest/gtest.h>
#include <stdio.h>
#include <iostream>
#include <cuda.h>
#include <cuda_runtime_api.h>

using namespace std;


TEST(CudaMemAllocTest, CudaMemAlloc) {
    CUresult result = cuInit(0); 
    ASSERT_EQ(result, CUDA_SUCCESS)<< "cuInit failed with error code: " << result;

    CUcontext ctx; 
    result = cuCtxCreate(&ctx, 0, 0);
    ASSERT_EQ(result, CUDA_SUCCESS)<< "Ctx failed with error code: " << result;

    size_t size = 1024;
    CUdeviceptr ptr;

    // Allocate device memory
    result = cuMemAlloc(&ptr, size);
    if (result != CUDA_SUCCESS) {
        const char* errorString = nullptr; // Initialize to nullptr
        result = cuGetErrorString(result, &errorString); // Correct usage
        if (result != CUDA_SUCCESS) {
            std::cerr << "Error getting error string!" << std::endl;
        } else {
            std::cout << "cuMemAlloc error: " << errorString << std::endl;
        }
    }

    ASSERT_EQ(result, CUDA_SUCCESS)<< "cuMemAlloc failed with error code: " << result;

    // Check if ptr is not zero
    ASSERT_NE(ptr, 0)<< "Host pointer is null";

    result = cuCtxDestroy(ctx);
    ASSERT_EQ(result, CUDA_SUCCESS)<< "Ctx destory failed with error code: " << result;
}


int main(int argc, char** argv) {
    ::testing::InitGoogleTest(&argc, argv);
    return RUN_ALL_TESTS();
}