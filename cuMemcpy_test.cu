#include <iostream>
#include <iomanip>
#include <cmath>
#include <string>
#include <cuda.h>
#include <pthread.h>
#include <cuda_runtime_api.h>
#include <unistd.h>
#include <sched.h>
#include <sys/mman.h>
#include <sys/wait.h>
#include <linux/version.h>

using namespace std;

#define gpuDriverErrorCheck(ans) {gpuAssert((ans),__FILE__,__LINE__); }
inline void gpuAssert(CUresult code,  const char *file, int line)
{
    if (code != CUDA_SUCCESS )
    {
        fprintf(stderr, "GPU assert: %d %s %d\n",
            code, file, line);
    }
}

__global__ void checkDeviceResult(int * ptr, int total_elem, int expect_val) {
    int i = 0;
    while (i < total_elem) {
        if (ptr[i] == expect_val) {
            i+=1;
        } else {
            printf("Error: value incorrect\n");
            break;
        }
    }
}

int main()
{
    const int total_elem = 2<<10;
    const int buf_size = total_elem * sizeof(int);

    //using cuda driver api
    //initialize cuda driver
    gpuDriverErrorCheck(cuInit(0)); 
    int count = 0;
    gpuDriverErrorCheck(cuDeviceGetCount(&count));
    CUdevice device;
    gpuDriverErrorCheck(cuDeviceGet(&device, 0));
    CUcontext context;
    gpuDriverErrorCheck(cuCtxCreate(&context, 0, device));

    //Initialize value in memory
    CUdeviceptr tmp;
    gpuDriverErrorCheck(cuMemAlloc(&tmp, buf_size));

    CUdeviceptr h_mem;
    int* h_mem_ptr;
    gpuDriverErrorCheck(cuMemHostAlloc((void **)&h_mem_ptr, buf_size,  CU_MEMHOSTALLOC_DEVICEMAP)); 
    for(int i = 0; i < total_elem; i++){
        h_mem_ptr[i] = 1;
    }
    gpuDriverErrorCheck(cuMemHostGetDevicePointer(&h_mem, (void*)h_mem_ptr, 0));
    //gpuDriverErrorCheck(cuMemsetD32(h_mem,  (unsigned int)1, total_elem));

    CUdeviceptr d_mem;
    gpuDriverErrorCheck(cuMemAlloc(&d_mem, buf_size));
    gpuDriverErrorCheck(cuMemsetD32(d_mem,  (unsigned int)2, total_elem));

    CUdeviceptr h_tmp;
    int* h_tmp_ptr;
    gpuDriverErrorCheck(cuMemHostAlloc((void **)&h_tmp_ptr, buf_size,  CU_MEMHOSTALLOC_DEVICEMAP)); 
    for(int i = 0; i < total_elem; i++){
        h_tmp_ptr[i] = 1;
    }
    gpuDriverErrorCheck(cuMemHostGetDevicePointer(&h_tmp, (void*)h_tmp_ptr, 0));
    //gpuDriverErrorCheck(cuMemsetD32(h_tmp,  (unsigned int)1, total_elem));

    CUdeviceptr d_tmp;
    gpuDriverErrorCheck(cuMemAlloc(&d_tmp, buf_size));
    gpuDriverErrorCheck(cuMemsetD32(d_tmp,  (unsigned int)3, total_elem));

    //Do memory copy and check result
    printf("Note: if no error message shows, then indicates test pass\n");
    gpuDriverErrorCheck(cuMemcpy(h_tmp, d_mem, buf_size));
    printf("Test memory copy D to H result....\n");
    checkDeviceResult<<<1,1>>>((int *)h_tmp, total_elem, 2);
    cudaDeviceSynchronize();

    gpuDriverErrorCheck(cuMemcpy(h_tmp, h_mem, buf_size));
    printf("Test memory copy H to H result....\n");
    checkDeviceResult<<<1,1>>>((int *)h_tmp, total_elem, 1);
    //res = checkHostResult(h_tmp, total_elem, 1);
    cudaDeviceSynchronize();
    
    gpuDriverErrorCheck(cuMemcpy(d_tmp, d_mem, buf_size));
    printf("Test memory copy D to D result....\n");
    checkDeviceResult<<<1,1>>>((int *)d_tmp, total_elem, 2);
    cudaDeviceSynchronize();
    
    gpuDriverErrorCheck(cuMemcpy(d_tmp, h_mem, buf_size));
    printf("Test memory copy H to D result....\n");
    checkDeviceResult<<<1,1>>>((int *)d_tmp, total_elem, 1);
    cudaDeviceSynchronize();

    return 0;
}