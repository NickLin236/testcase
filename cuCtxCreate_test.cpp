#include <gtest/gtest.h>
#include <stdio.h>
#include <iostream>
#include <cuda.h>
#include <cuda_runtime_api.h>

using namespace std;

TEST(CudaContextTest, CudaCtxCreate) {
    CUcontext context;

    // Initialize the CUDA runtime.
    CUresult result = cuInit(0); 
    ASSERT_EQ(result, CUDA_SUCCESS)<< "cuInit failed with error code: " << result;

    // Create a CUDA context.
    // err = cuCtxCreate(&context, 0, 0)
    result = cuCtxCreate(&context, 0, 0);
    ASSERT_EQ(result, CUDA_SUCCESS)<< "cuCtxCreate failed with error code: " << result; 

    // Check if the context was created successfully
    ASSERT_NE(context, nullptr)<< "Host pointer is null";

    // Destroy the context.
    result = cuCtxDestroy(context);
    ASSERT_EQ(result, CUDA_SUCCESS)<< "cuCtxDestory failed with error code: " << result;
}


int main(int argc, char** argv) {
    ::testing::InitGoogleTest(&argc, argv);
    return RUN_ALL_TESTS();
}