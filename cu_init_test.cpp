#include <gtest/gtest.h>
#include <stdio.h>
#include <iostream>
#include <cuda.h>
#include <cuda_runtime_api.h>

using namespace std;


class CudaInitTest : public ::testing::Test {
    protected:
    void SetUp() override {
    }

    void TearDown() override {
    }
};

TEST_F(CudaInitTest, CudaInit) {
    cout << "CUDA initialization test" << endl;
    //int deviceCount = 0;
    //CUresult result = cudaGetDeviceCount(&deviceCount);
    //cudaGetDeviceCount(&deviceCount);
    //EXPECT_GT(deviceCount, 0);
    CUresult result = cuInit(0);
    EXPECT_EQ(result, CUDA_SUCCESS) << "cuInit failed with error code: " << result;
}

int main(int argc, char **argv) {
    ::testing::InitGoogleTest(&argc, argv);
    return RUN_ALL_TESTS();
}
