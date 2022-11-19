#include <cudnn.h>
#include <stdio.h>
#include <cuda.h>
#include <malloc.h>
#include <cstdlib>
#include <time.h>
#include <iostream>
#include <sys/types.h>
#include <errno.h>
#include <vector>
#include <fstream>
#include <string>
#include <omp.h>
#define TH 4
#define TW 6
#define TC 16
#define C 64
#define N 32
#define H 224
#define W 224

#define TCS ((C-1)/TC + 1)
#define THS ((H-1)/TH + 1)
#define TWS ((W-1)/TW+1)
#define R 3
#define S 3


using namespace std;
#define checkCUDNN(expression)                               \
  {                                                          \
    cudnnStatus_t status = (expression);                     \
    if (status != CUDNN_STATUS_SUCCESS) {                    \
      std::cerr << "Error on line " << __LINE__ << ": "      \
                << cudnnGetErrorString(status) << std::endl; \
      std::exit(EXIT_FAILURE);                               \
    }                                                        \
  }
inline void chkerr(cudaError_t code)
{
    if (code != cudaSuccess)
    {
        std::cerr << "ERROR!!!:" << cudaGetErrorString(code) <<endl;
        exit(-1);
    }
}
extern "C" __global__ void default_function_kernel0(float* __restrict__ data, float* __restrict__ kernel, float* __restrict__ compute) {
  float compute_local[128];
  __shared__ float pad_temp_shared[2088];
  __shared__ float kernel_shared[288];
  float pad_temp_shared_local[48];
  float kernel_shared_local[12];
  for (int ff_c_init = 0; ff_c_init < 2; ++ff_c_init) {
    for (int yy_c_init = 0; yy_c_init < 4; ++yy_c_init) {
      compute_local[(((ff_c_init * 4) + yy_c_init))] = 0.000000e+00f;
      compute_local[((((ff_c_init * 4) + yy_c_init) + 64))] = 0.000000e+00f;
      compute_local[((((ff_c_init * 4) + yy_c_init) + 8))] = 0.000000e+00f;
      compute_local[((((ff_c_init * 4) + yy_c_init) + 72))] = 0.000000e+00f;
      compute_local[((((ff_c_init * 4) + yy_c_init) + 16))] = 0.000000e+00f;
      compute_local[((((ff_c_init * 4) + yy_c_init) + 80))] = 0.000000e+00f;
      compute_local[((((ff_c_init * 4) + yy_c_init) + 24))] = 0.000000e+00f;
      compute_local[((((ff_c_init * 4) + yy_c_init) + 88))] = 0.000000e+00f;
      compute_local[((((ff_c_init * 4) + yy_c_init) + 32))] = 0.000000e+00f;
      compute_local[((((ff_c_init * 4) + yy_c_init) + 96))] = 0.000000e+00f;
      compute_local[((((ff_c_init * 4) + yy_c_init) + 40))] = 0.000000e+00f;
      compute_local[((((ff_c_init * 4) + yy_c_init) + 104))] = 0.000000e+00f;
      compute_local[((((ff_c_init * 4) + yy_c_init) + 48))] = 0.000000e+00f;
      compute_local[((((ff_c_init * 4) + yy_c_init) + 112))] = 0.000000e+00f;
      compute_local[((((ff_c_init * 4) + yy_c_init) + 56))] = 0.000000e+00f;
      compute_local[((((ff_c_init * 4) + yy_c_init) + 120))] = 0.000000e+00f;
    }
  }
  for (int rc_outer = 0; rc_outer < 32; ++rc_outer) {
    __syncthreads();
    for (int ax0_ax1_fused_ax2_fused_ax3_fused_inner_inner_inner = 0; ax0_ax1_fused_ax2_fused_ax3_fused_inner_inner_inner < 19; ++ax0_ax1_fused_ax2_fused_ax3_fused_inner_inner_inner) {
      if (((((int)threadIdx.z) * 29) + ((((((int)threadIdx.y) * 38) + (((int)threadIdx.x) * 19)) + ax0_ax1_fused_ax2_fused_ax3_fused_inner_inner_inner) / 18)) < 116) {
        if (((((((int)threadIdx.z) * 522) + (((int)threadIdx.y) * 38)) + (((int)threadIdx.x) * 19)) + ax0_ax1_fused_ax2_fused_ax3_fused_inner_inner_inner) < 2088) {
          if ((((((int)threadIdx.y) * 38) + (((int)threadIdx.x) * 19)) + ax0_ax1_fused_ax2_fused_ax3_fused_inner_inner_inner) < 522) {
            pad_temp_shared[(((((((int)threadIdx.z) * 522) + (((int)threadIdx.y) * 38)) + (((int)threadIdx.x) * 19)) + ax0_ax1_fused_ax2_fused_ax3_fused_inner_inner_inner))] = (((((1 <= ((((int)blockIdx.y) * 56) + (((((int)threadIdx.z) * 29) + ((((((int)threadIdx.y) * 38) + (((int)threadIdx.x) * 19)) + ax0_ax1_fused_ax2_fused_ax3_fused_inner_inner_inner) / 18)) % 58))) && (((((int)blockIdx.y) * 56) + (((((int)threadIdx.z) * 29) + ((((((int)threadIdx.y) * 38) + (((int)threadIdx.x) * 19)) + ax0_ax1_fused_ax2_fused_ax3_fused_inner_inner_inner) / 18)) % 58)) < 225)) && (1 <= ((((int)blockIdx.x) * 16) + ((((((int)threadIdx.y) * 38) + (((int)threadIdx.x) * 19)) + ax0_ax1_fused_ax2_fused_ax3_fused_inner_inner_inner) % 18)))) && (((((int)blockIdx.x) * 16) + ((((((int)threadIdx.y) * 38) + (((int)threadIdx.x) * 19)) + ax0_ax1_fused_ax2_fused_ax3_fused_inner_inner_inner) % 18)) < 225)) ? data[((((((((rc_outer * 100352) + ((((((int)threadIdx.z) * 29) + ((((((int)threadIdx.y) * 38) + (((int)threadIdx.x) * 19)) + ax0_ax1_fused_ax2_fused_ax3_fused_inner_inner_inner) / 18)) / 58) * 50176)) + (((int)blockIdx.y) * 12544)) + ((((((int)threadIdx.z) * 29) + ((((((int)threadIdx.y) * 38) + (((int)threadIdx.x) * 19)) + ax0_ax1_fused_ax2_fused_ax3_fused_inner_inner_inner) / 18)) % 58) * 224)) + (((int)blockIdx.x) * 16)) + ((((((int)threadIdx.y) * 38) + (((int)threadIdx.x) * 19)) + ax0_ax1_fused_ax2_fused_ax3_fused_inner_inner_inner) % 18)) - 225))] : 0.000000e+00f);
          }
        }
      }
    }
    for (int ax0_ax1_fused_ax2_fused_ax3_fused_inner_inner_inner1 = 0; ax0_ax1_fused_ax2_fused_ax3_fused_inner_inner_inner1 < 3; ++ax0_ax1_fused_ax2_fused_ax3_fused_inner_inner_inner1) {
      if (((((int)threadIdx.z) * 4) + (((((int)threadIdx.y) * 2) + ((int)threadIdx.x)) / 6)) < 16) {
        if (((((int)threadIdx.z) * 8) + (((((int)threadIdx.y) * 2) + ((int)threadIdx.x)) / 3)) < 32) {
          if ((((((int)threadIdx.z) * 24) + (((int)threadIdx.y) * 2)) + ((int)threadIdx.x)) < 96) {
            if (((((((int)threadIdx.z) * 72) + (((int)threadIdx.y) * 6)) + (((int)threadIdx.x) * 3)) + ax0_ax1_fused_ax2_fused_ax3_fused_inner_inner_inner1) < 288) {
              if ((((((int)threadIdx.y) * 6) + (((int)threadIdx.x) * 3)) + ax0_ax1_fused_ax2_fused_ax3_fused_inner_inner_inner1) < 72) {
                if ((((((int)blockIdx.z) * 16) + (((int)threadIdx.z) * 4)) + (((((int)threadIdx.y) * 2) + ((int)threadIdx.x)) / 6)) < 32) {
                  kernel_shared[(((((((int)threadIdx.z) * 72) + (((int)threadIdx.y) * 6)) + (((int)threadIdx.x) * 3)) + ax0_ax1_fused_ax2_fused_ax3_fused_inner_inner_inner1))] = kernel[(((((((((int)blockIdx.z) * 9216) + (((int)threadIdx.z) * 2304)) + ((((((int)threadIdx.y) * 2) + ((int)threadIdx.x)) / 6) * 576)) + (rc_outer * 18)) + ((((((int)threadIdx.y) * 2) + ((int)threadIdx.x)) % 6) * 3)) + ax0_ax1_fused_ax2_fused_ax3_fused_inner_inner_inner1))];
                }
              }
            }
          }
        }
      }
    }
    __syncthreads();
    for (int rc_inner_outer = 0; rc_inner_outer < 2; ++rc_inner_outer) {
      for (int rx_inner_outer = 0; rx_inner_outer < 3; ++rx_inner_outer) {
        for (int ax2 = 0; ax2 < 6; ++ax2) {
          pad_temp_shared_local[(ax2)] = pad_temp_shared[((((((rc_inner_outer * 1044) + (((int)threadIdx.y) * 72)) + (ax2 * 18)) + ((int)threadIdx.x)) + rx_inner_outer))];
          pad_temp_shared_local[((ax2 + 6))] = pad_temp_shared[(((((((rc_inner_outer * 1044) + (((int)threadIdx.y) * 72)) + (ax2 * 18)) + ((int)threadIdx.x)) + rx_inner_outer) + 2))];
          pad_temp_shared_local[((ax2 + 12))] = pad_temp_shared[(((((((rc_inner_outer * 1044) + (((int)threadIdx.y) * 72)) + (ax2 * 18)) + ((int)threadIdx.x)) + rx_inner_outer) + 4))];
          pad_temp_shared_local[((ax2 + 18))] = pad_temp_shared[(((((((rc_inner_outer * 1044) + (((int)threadIdx.y) * 72)) + (ax2 * 18)) + ((int)threadIdx.x)) + rx_inner_outer) + 6))];
          pad_temp_shared_local[((ax2 + 24))] = pad_temp_shared[(((((((rc_inner_outer * 1044) + (((int)threadIdx.y) * 72)) + (ax2 * 18)) + ((int)threadIdx.x)) + rx_inner_outer) + 8))];
          pad_temp_shared_local[((ax2 + 30))] = pad_temp_shared[(((((((rc_inner_outer * 1044) + (((int)threadIdx.y) * 72)) + (ax2 * 18)) + ((int)threadIdx.x)) + rx_inner_outer) + 10))];
          pad_temp_shared_local[((ax2 + 36))] = pad_temp_shared[(((((((rc_inner_outer * 1044) + (((int)threadIdx.y) * 72)) + (ax2 * 18)) + ((int)threadIdx.x)) + rx_inner_outer) + 12))];
          pad_temp_shared_local[((ax2 + 42))] = pad_temp_shared[(((((((rc_inner_outer * 1044) + (((int)threadIdx.y) * 72)) + (ax2 * 18)) + ((int)threadIdx.x)) + rx_inner_outer) + 14))];
        }
        for (int ax0 = 0; ax0 < 2; ++ax0) {
          for (int ax21 = 0; ax21 < 3; ++ax21) {
            kernel_shared_local[(((ax0 * 3) + ax21))] = kernel_shared[((((((((int)threadIdx.z) * 36) + (ax0 * 18)) + (rc_inner_outer * 9)) + (ax21 * 3)) + rx_inner_outer))];
            kernel_shared_local[((((ax0 * 3) + ax21) + 6))] = kernel_shared[(((((((((int)threadIdx.z) * 36) + (ax0 * 18)) + (rc_inner_outer * 9)) + (ax21 * 3)) + rx_inner_outer) + 144))];
          }
        }
        for (int ry_inner_inner = 0; ry_inner_inner < 3; ++ry_inner_inner) {
          for (int ff_c = 0; ff_c < 2; ++ff_c) {
            for (int yy_c = 0; yy_c < 4; ++yy_c) {
              compute_local[(((ff_c * 4) + yy_c))] = (compute_local[(((ff_c * 4) + yy_c))] + (pad_temp_shared_local[((yy_c + ry_inner_inner))] * kernel_shared_local[(((ff_c * 3) + ry_inner_inner))]));
              compute_local[((((ff_c * 4) + yy_c) + 64))] = (compute_local[((((ff_c * 4) + yy_c) + 64))] + (pad_temp_shared_local[((yy_c + ry_inner_inner))] * kernel_shared_local[((((ff_c * 3) + ry_inner_inner) + 6))]));
              compute_local[((((ff_c * 4) + yy_c) + 8))] = (compute_local[((((ff_c * 4) + yy_c) + 8))] + (pad_temp_shared_local[(((yy_c + ry_inner_inner) + 6))] * kernel_shared_local[(((ff_c * 3) + ry_inner_inner))]));
              compute_local[((((ff_c * 4) + yy_c) + 72))] = (compute_local[((((ff_c * 4) + yy_c) + 72))] + (pad_temp_shared_local[(((yy_c + ry_inner_inner) + 6))] * kernel_shared_local[((((ff_c * 3) + ry_inner_inner) + 6))]));
              compute_local[((((ff_c * 4) + yy_c) + 16))] = (compute_local[((((ff_c * 4) + yy_c) + 16))] + (pad_temp_shared_local[(((yy_c + ry_inner_inner) + 12))] * kernel_shared_local[(((ff_c * 3) + ry_inner_inner))]));
              compute_local[((((ff_c * 4) + yy_c) + 80))] = (compute_local[((((ff_c * 4) + yy_c) + 80))] + (pad_temp_shared_local[(((yy_c + ry_inner_inner) + 12))] * kernel_shared_local[((((ff_c * 3) + ry_inner_inner) + 6))]));
              compute_local[((((ff_c * 4) + yy_c) + 24))] = (compute_local[((((ff_c * 4) + yy_c) + 24))] + (pad_temp_shared_local[(((yy_c + ry_inner_inner) + 18))] * kernel_shared_local[(((ff_c * 3) + ry_inner_inner))]));
              compute_local[((((ff_c * 4) + yy_c) + 88))] = (compute_local[((((ff_c * 4) + yy_c) + 88))] + (pad_temp_shared_local[(((yy_c + ry_inner_inner) + 18))] * kernel_shared_local[((((ff_c * 3) + ry_inner_inner) + 6))]));
              compute_local[((((ff_c * 4) + yy_c) + 32))] = (compute_local[((((ff_c * 4) + yy_c) + 32))] + (pad_temp_shared_local[(((yy_c + ry_inner_inner) + 24))] * kernel_shared_local[(((ff_c * 3) + ry_inner_inner))]));
              compute_local[((((ff_c * 4) + yy_c) + 96))] = (compute_local[((((ff_c * 4) + yy_c) + 96))] + (pad_temp_shared_local[(((yy_c + ry_inner_inner) + 24))] * kernel_shared_local[((((ff_c * 3) + ry_inner_inner) + 6))]));
              compute_local[((((ff_c * 4) + yy_c) + 40))] = (compute_local[((((ff_c * 4) + yy_c) + 40))] + (pad_temp_shared_local[(((yy_c + ry_inner_inner) + 30))] * kernel_shared_local[(((ff_c * 3) + ry_inner_inner))]));
              compute_local[((((ff_c * 4) + yy_c) + 104))] = (compute_local[((((ff_c * 4) + yy_c) + 104))] + (pad_temp_shared_local[(((yy_c + ry_inner_inner) + 30))] * kernel_shared_local[((((ff_c * 3) + ry_inner_inner) + 6))]));
              compute_local[((((ff_c * 4) + yy_c) + 48))] = (compute_local[((((ff_c * 4) + yy_c) + 48))] + (pad_temp_shared_local[(((yy_c + ry_inner_inner) + 36))] * kernel_shared_local[(((ff_c * 3) + ry_inner_inner))]));
              compute_local[((((ff_c * 4) + yy_c) + 112))] = (compute_local[((((ff_c * 4) + yy_c) + 112))] + (pad_temp_shared_local[(((yy_c + ry_inner_inner) + 36))] * kernel_shared_local[((((ff_c * 3) + ry_inner_inner) + 6))]));
              compute_local[((((ff_c * 4) + yy_c) + 56))] = (compute_local[((((ff_c * 4) + yy_c) + 56))] + (pad_temp_shared_local[(((yy_c + ry_inner_inner) + 42))] * kernel_shared_local[(((ff_c * 3) + ry_inner_inner))]));
              compute_local[((((ff_c * 4) + yy_c) + 120))] = (compute_local[((((ff_c * 4) + yy_c) + 120))] + (pad_temp_shared_local[(((yy_c + ry_inner_inner) + 42))] * kernel_shared_local[((((ff_c * 3) + ry_inner_inner) + 6))]));
            }
          }
        }
      }
    }
  }
  for (int ff_inner_inner_inner = 0; ff_inner_inner_inner < 2; ++ff_inner_inner_inner) {
    for (int yy_inner_inner_inner = 0; yy_inner_inner_inner < 4; ++yy_inner_inner_inner) {
      compute[(((((((((((int)blockIdx.z) * 802816) + (((int)threadIdx.z) * 100352)) + (ff_inner_inner_inner * 50176)) + (((int)blockIdx.y) * 12544)) + (((int)threadIdx.y) * 896)) + (yy_inner_inner_inner * 224)) + (((int)blockIdx.x) * 16)) + ((int)threadIdx.x)))] = compute_local[(((ff_inner_inner_inner * 4) + yy_inner_inner_inner))];
      compute[((((((((((((int)blockIdx.z) * 802816) + (((int)threadIdx.z) * 100352)) + (ff_inner_inner_inner * 50176)) + (((int)blockIdx.y) * 12544)) + (((int)threadIdx.y) * 896)) + (yy_inner_inner_inner * 224)) + (((int)blockIdx.x) * 16)) + ((int)threadIdx.x)) + 401408))] = compute_local[((((ff_inner_inner_inner * 4) + yy_inner_inner_inner) + 64))];
      compute[((((((((((((int)blockIdx.z) * 802816) + (((int)threadIdx.z) * 100352)) + (ff_inner_inner_inner * 50176)) + (((int)blockIdx.y) * 12544)) + (((int)threadIdx.y) * 896)) + (yy_inner_inner_inner * 224)) + (((int)blockIdx.x) * 16)) + ((int)threadIdx.x)) + 2))] = compute_local[((((ff_inner_inner_inner * 4) + yy_inner_inner_inner) + 8))];
      compute[((((((((((((int)blockIdx.z) * 802816) + (((int)threadIdx.z) * 100352)) + (ff_inner_inner_inner * 50176)) + (((int)blockIdx.y) * 12544)) + (((int)threadIdx.y) * 896)) + (yy_inner_inner_inner * 224)) + (((int)blockIdx.x) * 16)) + ((int)threadIdx.x)) + 401410))] = compute_local[((((ff_inner_inner_inner * 4) + yy_inner_inner_inner) + 72))];
      compute[((((((((((((int)blockIdx.z) * 802816) + (((int)threadIdx.z) * 100352)) + (ff_inner_inner_inner * 50176)) + (((int)blockIdx.y) * 12544)) + (((int)threadIdx.y) * 896)) + (yy_inner_inner_inner * 224)) + (((int)blockIdx.x) * 16)) + ((int)threadIdx.x)) + 4))] = compute_local[((((ff_inner_inner_inner * 4) + yy_inner_inner_inner) + 16))];
      compute[((((((((((((int)blockIdx.z) * 802816) + (((int)threadIdx.z) * 100352)) + (ff_inner_inner_inner * 50176)) + (((int)blockIdx.y) * 12544)) + (((int)threadIdx.y) * 896)) + (yy_inner_inner_inner * 224)) + (((int)blockIdx.x) * 16)) + ((int)threadIdx.x)) + 401412))] = compute_local[((((ff_inner_inner_inner * 4) + yy_inner_inner_inner) + 80))];
      compute[((((((((((((int)blockIdx.z) * 802816) + (((int)threadIdx.z) * 100352)) + (ff_inner_inner_inner * 50176)) + (((int)blockIdx.y) * 12544)) + (((int)threadIdx.y) * 896)) + (yy_inner_inner_inner * 224)) + (((int)blockIdx.x) * 16)) + ((int)threadIdx.x)) + 6))] = compute_local[((((ff_inner_inner_inner * 4) + yy_inner_inner_inner) + 24))];
      compute[((((((((((((int)blockIdx.z) * 802816) + (((int)threadIdx.z) * 100352)) + (ff_inner_inner_inner * 50176)) + (((int)blockIdx.y) * 12544)) + (((int)threadIdx.y) * 896)) + (yy_inner_inner_inner * 224)) + (((int)blockIdx.x) * 16)) + ((int)threadIdx.x)) + 401414))] = compute_local[((((ff_inner_inner_inner * 4) + yy_inner_inner_inner) + 88))];
      compute[((((((((((((int)blockIdx.z) * 802816) + (((int)threadIdx.z) * 100352)) + (ff_inner_inner_inner * 50176)) + (((int)blockIdx.y) * 12544)) + (((int)threadIdx.y) * 896)) + (yy_inner_inner_inner * 224)) + (((int)blockIdx.x) * 16)) + ((int)threadIdx.x)) + 8))] = compute_local[((((ff_inner_inner_inner * 4) + yy_inner_inner_inner) + 32))];
      compute[((((((((((((int)blockIdx.z) * 802816) + (((int)threadIdx.z) * 100352)) + (ff_inner_inner_inner * 50176)) + (((int)blockIdx.y) * 12544)) + (((int)threadIdx.y) * 896)) + (yy_inner_inner_inner * 224)) + (((int)blockIdx.x) * 16)) + ((int)threadIdx.x)) + 401416))] = compute_local[((((ff_inner_inner_inner * 4) + yy_inner_inner_inner) + 96))];
      compute[((((((((((((int)blockIdx.z) * 802816) + (((int)threadIdx.z) * 100352)) + (ff_inner_inner_inner * 50176)) + (((int)blockIdx.y) * 12544)) + (((int)threadIdx.y) * 896)) + (yy_inner_inner_inner * 224)) + (((int)blockIdx.x) * 16)) + ((int)threadIdx.x)) + 10))] = compute_local[((((ff_inner_inner_inner * 4) + yy_inner_inner_inner) + 40))];
      compute[((((((((((((int)blockIdx.z) * 802816) + (((int)threadIdx.z) * 100352)) + (ff_inner_inner_inner * 50176)) + (((int)blockIdx.y) * 12544)) + (((int)threadIdx.y) * 896)) + (yy_inner_inner_inner * 224)) + (((int)blockIdx.x) * 16)) + ((int)threadIdx.x)) + 401418))] = compute_local[((((ff_inner_inner_inner * 4) + yy_inner_inner_inner) + 104))];
      compute[((((((((((((int)blockIdx.z) * 802816) + (((int)threadIdx.z) * 100352)) + (ff_inner_inner_inner * 50176)) + (((int)blockIdx.y) * 12544)) + (((int)threadIdx.y) * 896)) + (yy_inner_inner_inner * 224)) + (((int)blockIdx.x) * 16)) + ((int)threadIdx.x)) + 12))] = compute_local[((((ff_inner_inner_inner * 4) + yy_inner_inner_inner) + 48))];
      compute[((((((((((((int)blockIdx.z) * 802816) + (((int)threadIdx.z) * 100352)) + (ff_inner_inner_inner * 50176)) + (((int)blockIdx.y) * 12544)) + (((int)threadIdx.y) * 896)) + (yy_inner_inner_inner * 224)) + (((int)blockIdx.x) * 16)) + ((int)threadIdx.x)) + 401420))] = compute_local[((((ff_inner_inner_inner * 4) + yy_inner_inner_inner) + 112))];
      compute[((((((((((((int)blockIdx.z) * 802816) + (((int)threadIdx.z) * 100352)) + (ff_inner_inner_inner * 50176)) + (((int)blockIdx.y) * 12544)) + (((int)threadIdx.y) * 896)) + (yy_inner_inner_inner * 224)) + (((int)blockIdx.x) * 16)) + ((int)threadIdx.x)) + 14))] = compute_local[((((ff_inner_inner_inner * 4) + yy_inner_inner_inner) + 56))];
      compute[((((((((((((int)blockIdx.z) * 802816) + (((int)threadIdx.z) * 100352)) + (ff_inner_inner_inner * 50176)) + (((int)blockIdx.y) * 12544)) + (((int)threadIdx.y) * 896)) + (yy_inner_inner_inner * 224)) + (((int)blockIdx.x) * 16)) + ((int)threadIdx.x)) + 401422))] = compute_local[((((ff_inner_inner_inner * 4) + yy_inner_inner_inner) + 120))];
    }
  }
}






class ConvGemm{
public:
    float *cpuKernel;
    float alpha = 1.0f;
    float beta = 0.0f;
    cudnnHandle_t convCudnn;
    void* d_workspace{nullptr};
    size_t workspace_bytes{0};
    cudnnTensorDescriptor_t convInputDescriptor;
    cudnnTensorDescriptor_t convOutputDescriptor;
    cudnnFilterDescriptor_t convKernelDescriptor;
    cudnnConvolutionDescriptor_t convDesc;
    float *output;
    float *kernel;
    void initialize();
    float *forward(float *input);
};
void ConvGemm::initialize(){

    cudaMalloc(&kernel,sizeof(float)*C*N*9);
    cudaMalloc(&this->output,sizeof(float)*N*H*W);
    cudnnCreate(&convCudnn);
    cudnnCreateTensorDescriptor(&convInputDescriptor);
    cudnnSetTensor4dDescriptor(convInputDescriptor,
            /*format=*/CUDNN_TENSOR_NCHW,
            /*dataType=*/CUDNN_DATA_FLOAT,
            /*batch_size=*/1,
            /*channels=*/C,
            /*image_height=*/H,
            /*image_width=*/W);
    cudnnCreateFilterDescriptor(&convKernelDescriptor);
    cudnnSetFilter4dDescriptor(convKernelDescriptor,
            /*dataType=*/CUDNN_DATA_FLOAT,
            /*format=*/CUDNN_TENSOR_NCHW,
            /*out_channels=*/N,
            /*in_channels=*/C,
            /*kernel_height=*/R,
            /*kernel_width=*/S);
    cudnnCreateConvolutionDescriptor(&convDesc);
    cudnnSetConvolution2dDescriptor(convDesc,
            /*pad_height=*/1,
            /*pad_width=*/1,
            /*vertical_stride=*/1,
            /*horizontal_stride=*/1,
            /*dilation_height=*/1,
            /*dilation_width=*/1,
            /*mode=*/CUDNN_CROSS_CORRELATION,
                                    CUDNN_DATA_FLOAT);
    int batch_size{0}, channels{0}, height{0}, width{0};
    cudnnGetConvolution2dForwardOutputDim(convDesc,
                                          convInputDescriptor,
                                          convKernelDescriptor,
                                          &batch_size,
                                          &channels,
                                          &height,
                                          &width);
    cudnnCreateTensorDescriptor(&convOutputDescriptor);
    cudnnSetTensor4dDescriptor(convOutputDescriptor,
            /*format=*/CUDNN_TENSOR_NCHW,
            /*dataType=*/CUDNN_DATA_FLOAT,
            /*batch_size=*/1,
            /*channels=*/N,
            /*image_height=*/H,
            /*image_width=*/W);
    cudnnGetConvolutionForwardWorkspaceSize(convCudnn,
                                            convInputDescriptor,
                                            convKernelDescriptor,
                                            convDesc,
                                            convOutputDescriptor,
                                            CUDNN_CONVOLUTION_FWD_ALGO_IMPLICIT_GEMM,
                                            &workspace_bytes);
    cudaMalloc(&d_workspace, workspace_bytes);
    unsigned int kernelSize = R*S*C*N;//kernel
    this->cpuKernel = (float *)malloc(kernelSize*sizeof(float));
    for(int i=0;i<kernelSize;++i){
        this->cpuKernel[i] = 1.0f;
    }
    cudaMemcpy(kernel,cpuKernel,R*S*C*N*sizeof(float),cudaMemcpyHostToDevice);
    free(cpuKernel);
}
float * ConvGemm::forward(float *input) {
    cudaMemset(output, 0, 1*N*H*W*sizeof(float));
    checkCUDNN(cudnnConvolutionForward(convCudnn,
                                       &alpha,
                                       convInputDescriptor,
                                       input,
                                       convKernelDescriptor,
                                       kernel,
                                       convDesc,
                                       CUDNN_CONVOLUTION_FWD_ALGO_IMPLICIT_GEMM,
                                       d_workspace,
                                       workspace_bytes,
                                       &beta,
                                       convOutputDescriptor,
                                       output));
    return output;
}

class ConvWinogradeNon{
public:
    float *cpuKernel;
    float alpha = 1.0f;
    float beta = 0.0f;
    cudnnHandle_t convCudnn;
    void* d_workspace{nullptr};
    size_t workspace_bytes{0};
    cudnnTensorDescriptor_t convInputDescriptor;
    cudnnTensorDescriptor_t convOutputDescriptor;
    cudnnFilterDescriptor_t convKernelDescriptor;
    cudnnConvolutionDescriptor_t convDesc;
    float *output;
    float *kernel;
    void initialize();
    float *forward(float *input);
};
void ConvWinogradeNon::initialize(){
    cudaMalloc(&kernel,sizeof(float)*C*N*9);
    cudaMalloc(&this->output,sizeof(float)*N*H*W);
    cudnnCreate(&convCudnn);
    cudnnCreateTensorDescriptor(&convInputDescriptor);
    cudnnSetTensor4dDescriptor(convInputDescriptor,
            /*format=*/CUDNN_TENSOR_NCHW,
            /*dataType=*/CUDNN_DATA_FLOAT,
            /*batch_size=*/1,
            /*channels=*/C,
            /*image_height=*/H,
            /*image_width=*/W);
    cudnnCreateFilterDescriptor(&convKernelDescriptor);
    cudnnSetFilter4dDescriptor(convKernelDescriptor,
            /*dataType=*/CUDNN_DATA_FLOAT,
            /*format=*/CUDNN_TENSOR_NCHW,
            /*out_channels=*/N,
            /*in_channels=*/C,
            /*kernel_height=*/R,
            /*kernel_width=*/S);
    cudnnCreateConvolutionDescriptor(&convDesc);
    cudnnSetConvolution2dDescriptor(convDesc,
            /*pad_height=*/1,
            /*pad_width=*/1,
            /*vertical_stride=*/1,
            /*horizontal_stride=*/1,
            /*dilation_height=*/1,
            /*dilation_width=*/1,
            /*mode=*/CUDNN_CROSS_CORRELATION,
                                    CUDNN_DATA_FLOAT);
    int batch_size{0}, channels{0}, height{0}, width{0};
    cudnnGetConvolution2dForwardOutputDim(convDesc,
                                          convInputDescriptor,
                                          convKernelDescriptor,
                                          &batch_size,
                                          &channels,
                                          &height,
                                          &width);
    cudnnCreateTensorDescriptor(&convOutputDescriptor);
    cudnnSetTensor4dDescriptor(convOutputDescriptor,
            /*format=*/CUDNN_TENSOR_NCHW,
            /*dataType=*/CUDNN_DATA_FLOAT,
            /*batch_size=*/1,
            /*channels=*/N,
            /*image_height=*/H,
            /*image_width=*/W);
    cudnnGetConvolutionForwardWorkspaceSize(convCudnn,
                                            convInputDescriptor,
                                            convKernelDescriptor,
                                            convDesc,
                                            convOutputDescriptor,
                                            CUDNN_CONVOLUTION_FWD_ALGO_WINOGRAD_NONFUSED,
                                            &workspace_bytes);
    cudaMalloc(&d_workspace, workspace_bytes);
    unsigned int kernelSize = R*S*C*N;//kernel
    this->cpuKernel = (float *)malloc(kernelSize*sizeof(float));
    for(int i=0;i<kernelSize;++i){
        this->cpuKernel[i] = 1.0f;
    }
    cudaMemcpy(kernel,cpuKernel,R*S*C*N*sizeof(float),cudaMemcpyHostToDevice);
    free(cpuKernel);
}
float * ConvWinogradeNon::forward(float *input) {
    cudaMemset(output, 0, 1*N*H*W*sizeof(float));
    checkCUDNN(cudnnConvolutionForward(convCudnn,
                                       &alpha,
                                       convInputDescriptor,
                                       input,
                                       convKernelDescriptor,
                                       kernel,
                                       convDesc,
                                       CUDNN_CONVOLUTION_FWD_ALGO_WINOGRAD_NONFUSED,
                                       d_workspace,
                                       workspace_bytes,
                                       &beta,
                                       convOutputDescriptor,
                                       output));
    return output;
}
class ConvFFT{
public:
    float *cpuKernel;
    float alpha = 1.0f;
    float beta = 0.0f;
    cudnnHandle_t convCudnn;
    void* d_workspace{nullptr};
    size_t workspace_bytes{0};
    cudnnTensorDescriptor_t convInputDescriptor;
    cudnnTensorDescriptor_t convOutputDescriptor;
    cudnnFilterDescriptor_t convKernelDescriptor;
    cudnnConvolutionDescriptor_t convDesc;
    float *output;
    float *kernel;
    void initialize();
    float *forward(float *input);
};
void ConvFFT::initialize(){

    cudaMalloc(&kernel,sizeof(float)*C*N*9);
    cudaMalloc(&this->output,sizeof(float)*N*H*W);
    cudnnCreate(&convCudnn);
    cudnnCreateTensorDescriptor(&convInputDescriptor);
    cudnnSetTensor4dDescriptor(convInputDescriptor,
            /*format=*/CUDNN_TENSOR_NCHW,
            /*dataType=*/CUDNN_DATA_FLOAT,
            /*batch_size=*/1,
            /*channels=*/C,
            /*image_height=*/H,
            /*image_width=*/W);
    cudnnCreateFilterDescriptor(&convKernelDescriptor);
    cudnnSetFilter4dDescriptor(convKernelDescriptor,
            /*dataType=*/CUDNN_DATA_FLOAT,
            /*format=*/CUDNN_TENSOR_NCHW,
            /*out_channels=*/N,
            /*in_channels=*/C,
            /*kernel_height=*/R,
            /*kernel_width=*/S);
    cudnnCreateConvolutionDescriptor(&convDesc);
    cudnnSetConvolution2dDescriptor(convDesc,
            /*pad_height=*/1,
            /*pad_width=*/1,
            /*vertical_stride=*/1,
            /*horizontal_stride=*/1,
            /*dilation_height=*/1,
            /*dilation_width=*/1,
            /*mode=*/CUDNN_CROSS_CORRELATION,
                                    CUDNN_DATA_FLOAT);
    int batch_size{0}, channels{0}, height{0}, width{0};
    cudnnGetConvolution2dForwardOutputDim(convDesc,
                                          convInputDescriptor,
                                          convKernelDescriptor,
                                          &batch_size,
                                          &channels,
                                          &height,
                                          &width);
    cudnnCreateTensorDescriptor(&convOutputDescriptor);
    cudnnSetTensor4dDescriptor(convOutputDescriptor,
            /*format=*/CUDNN_TENSOR_NCHW,
            /*dataType=*/CUDNN_DATA_FLOAT,
            /*batch_size=*/1,
            /*channels=*/N,
            /*image_height=*/H,
            /*image_width=*/W);
    cudnnGetConvolutionForwardWorkspaceSize(convCudnn,
                                            convInputDescriptor,
                                            convKernelDescriptor,
                                            convDesc,
                                            convOutputDescriptor,
                                            CUDNN_CONVOLUTION_FWD_ALGO_FFT,
                                            &workspace_bytes);
    cudaMalloc(&d_workspace, workspace_bytes);
    unsigned int kernelSize = R*S*C*N;//kernel
    this->cpuKernel = (float *)malloc(kernelSize*sizeof(float));
    for(int i=0;i<kernelSize;++i){
        this->cpuKernel[i] = 1.0f;
    }
    cudaMemcpy(kernel,cpuKernel,R*S*C*N*sizeof(float),cudaMemcpyHostToDevice);
    free(cpuKernel);
}
float * ConvFFT::forward(float *input) {
    cudaMemset(output, 0, 1*N*H*W*sizeof(float));
    checkCUDNN(cudnnConvolutionForward(convCudnn,
                                       &alpha,
                                       convInputDescriptor,
                                       input,
                                       convKernelDescriptor,
                                       kernel,
                                       convDesc,
                                       CUDNN_CONVOLUTION_FWD_ALGO_FFT,
                                       d_workspace,
                                       workspace_bytes,
                                       &beta,
                                       convOutputDescriptor,
                                       output));
    return output;
}
__device__ void load_data_2_register(float *__restrict__ data_array, unsigned int c_index, const float * __restrict__ kernel, unsigned int n_id){
    for(unsigned int r=0;r<R;++r){
        for(unsigned int s=0;s<S;++s){
            data_array[r*S+s] = kernel[c_index*N*9+r*3*N+s*N+n_id];
        }
    }
}
__device__ void switch_function( unsigned int switch_condition,float *temp_kernel,float v,float *temp_result){
	switch (switch_condition) {
		case 0:
			#pragma unroll
			for ( int r = 0; r < 1; r++) {
				#pragma unroll
				for ( int s = 0; s < 1; s++) {
					float result = v * temp_kernel[r*S+s];
					temp_result[(0-r)*6+(0-s)] += result;
				}
			}
		break;
		case 1:
			#pragma unroll
			for ( int r = 0; r < 1; r++) {
				#pragma unroll
				for ( int s = 0; s < 2; s++) {
					float result = v * temp_kernel[r*S+s];
					temp_result[(0-r)*6+(1-s)] += result;
				}
			}
		break;
		case 2:
			#pragma unroll
			for ( int r = 0; r < 1; r++) {
				#pragma unroll
				for ( int s = 0; s < 3; s++) {
					float result = v * temp_kernel[r*S+s];
					temp_result[(0-r)*6+(2-s)] += result;
				}
			}
		break;
		case 3:
			#pragma unroll
			for ( int r = 0; r < 1; r++) {
				#pragma unroll
				for ( int s = 0; s < 3; s++) {
					float result = v * temp_kernel[r*S+s];
					temp_result[(0-r)*6+(3-s)] += result;
				}
			}
		break;
		case 4:
			#pragma unroll
			for ( int r = 0; r < 1; r++) {
				#pragma unroll
				for ( int s = 0; s < 3; s++) {
					float result = v * temp_kernel[r*S+s];
					temp_result[(0-r)*6+(4-s)] += result;
				}
			}
		break;
		case 5:
			#pragma unroll
			for ( int r = 0; r < 1; r++) {
				#pragma unroll
				for ( int s = 0; s < 3; s++) {
					float result = v * temp_kernel[r*S+s];
					temp_result[(0-r)*6+(5-s)] += result;
				}
			}
		break;
		case 6:
			#pragma unroll
			for ( int r = 0; r < 1; r++) {
				#pragma unroll
				for ( int s = 1; s < 3; s++) {
					float result = v * temp_kernel[r*S+s];
					temp_result[(0-r)*6+(6-s)] += result;
				}
			}
		break;
		case 7:
			#pragma unroll
			for ( int r = 0; r < 1; r++) {
				#pragma unroll
				for ( int s = 2; s < 3; s++) {
					float result = v * temp_kernel[r*S+s];
					temp_result[(0-r)*6+(7-s)] += result;
				}
			}
		break;
		case 8:
			#pragma unroll
			for ( int r = 0; r < 2; r++) {
				#pragma unroll
				for ( int s = 0; s < 1; s++) {
					float result = v * temp_kernel[r*S+s];
					temp_result[(1-r)*6+(0-s)] += result;
				}
			}
		break;
		case 9:
			#pragma unroll
			for ( int r = 0; r < 2; r++) {
				#pragma unroll
				for ( int s = 0; s < 2; s++) {
					float result = v * temp_kernel[r*S+s];
					temp_result[(1-r)*6+(1-s)] += result;
				}
			}
		break;
		case 10:
			#pragma unroll
			for ( int r = 0; r < 2; r++) {
				#pragma unroll
				for ( int s = 0; s < 3; s++) {
					float result = v * temp_kernel[r*S+s];
					temp_result[(1-r)*6+(2-s)] += result;
				}
			}
		break;
		case 11:
			#pragma unroll
			for ( int r = 0; r < 2; r++) {
				#pragma unroll
				for ( int s = 0; s < 3; s++) {
					float result = v * temp_kernel[r*S+s];
					temp_result[(1-r)*6+(3-s)] += result;
				}
			}
		break;
		case 12:
			#pragma unroll
			for ( int r = 0; r < 2; r++) {
				#pragma unroll
				for ( int s = 0; s < 3; s++) {
					float result = v * temp_kernel[r*S+s];
					temp_result[(1-r)*6+(4-s)] += result;
				}
			}
		break;
		case 13:
			#pragma unroll
			for ( int r = 0; r < 2; r++) {
				#pragma unroll
				for ( int s = 0; s < 3; s++) {
					float result = v * temp_kernel[r*S+s];
					temp_result[(1-r)*6+(5-s)] += result;
				}
			}
		break;
		case 14:
			#pragma unroll
			for ( int r = 0; r < 2; r++) {
				#pragma unroll
				for ( int s = 1; s < 3; s++) {
					float result = v * temp_kernel[r*S+s];
					temp_result[(1-r)*6+(6-s)] += result;
				}
			}
		break;
		case 15:
			#pragma unroll
			for ( int r = 0; r < 2; r++) {
				#pragma unroll
				for ( int s = 2; s < 3; s++) {
					float result = v * temp_kernel[r*S+s];
					temp_result[(1-r)*6+(7-s)] += result;
				}
			}
		break;
		case 16:
			#pragma unroll
			for ( int r = 0; r < 3; r++) {
				#pragma unroll
				for ( int s = 0; s < 1; s++) {
					float result = v * temp_kernel[r*S+s];
					temp_result[(2-r)*6+(0-s)] += result;
				}
			}
		break;
		case 17:
			#pragma unroll
			for ( int r = 0; r < 3; r++) {
				#pragma unroll
				for ( int s = 0; s < 2; s++) {
					float result = v * temp_kernel[r*S+s];
					temp_result[(2-r)*6+(1-s)] += result;
				}
			}
		break;
		case 18:
			#pragma unroll
			for ( int r = 0; r < 3; r++) {
				#pragma unroll
				for ( int s = 0; s < 3; s++) {
					float result = v * temp_kernel[r*S+s];
					temp_result[(2-r)*6+(2-s)] += result;
				}
			}
		break;
		case 19:
			#pragma unroll
			for ( int r = 0; r < 3; r++) {
				#pragma unroll
				for ( int s = 0; s < 3; s++) {
					float result = v * temp_kernel[r*S+s];
					temp_result[(2-r)*6+(3-s)] += result;
				}
			}
		break;
		case 20:
			#pragma unroll
			for ( int r = 0; r < 3; r++) {
				#pragma unroll
				for ( int s = 0; s < 3; s++) {
					float result = v * temp_kernel[r*S+s];
					temp_result[(2-r)*6+(4-s)] += result;
				}
			}
		break;
		case 21:
			#pragma unroll
			for ( int r = 0; r < 3; r++) {
				#pragma unroll
				for ( int s = 0; s < 3; s++) {
					float result = v * temp_kernel[r*S+s];
					temp_result[(2-r)*6+(5-s)] += result;
				}
			}
		break;
		case 22:
			#pragma unroll
			for ( int r = 0; r < 3; r++) {
				#pragma unroll
				for ( int s = 1; s < 3; s++) {
					float result = v * temp_kernel[r*S+s];
					temp_result[(2-r)*6+(6-s)] += result;
				}
			}
		break;
		case 23:
			#pragma unroll
			for ( int r = 0; r < 3; r++) {
				#pragma unroll
				for ( int s = 2; s < 3; s++) {
					float result = v * temp_kernel[r*S+s];
					temp_result[(2-r)*6+(7-s)] += result;
				}
			}
		break;
		case 24:
			#pragma unroll
			for ( int r = 0; r < 3; r++) {
				#pragma unroll
				for ( int s = 0; s < 1; s++) {
					float result = v * temp_kernel[r*S+s];
					temp_result[(3-r)*6+(0-s)] += result;
				}
			}
		break;
		case 25:
			#pragma unroll
			for ( int r = 0; r < 3; r++) {
				#pragma unroll
				for ( int s = 0; s < 2; s++) {
					float result = v * temp_kernel[r*S+s];
					temp_result[(3-r)*6+(1-s)] += result;
				}
			}
		break;
		case 26:
			#pragma unroll
			for ( int r = 0; r < 3; r++) {
				#pragma unroll
				for ( int s = 0; s < 3; s++) {
					float result = v * temp_kernel[r*S+s];
					temp_result[(3-r)*6+(2-s)] += result;
				}
			}
		break;
		case 27:
			#pragma unroll
			for ( int r = 0; r < 3; r++) {
				#pragma unroll
				for ( int s = 0; s < 3; s++) {
					float result = v * temp_kernel[r*S+s];
					temp_result[(3-r)*6+(3-s)] += result;
				}
			}
		break;
		case 28:
			#pragma unroll
			for ( int r = 0; r < 3; r++) {
				#pragma unroll
				for ( int s = 0; s < 3; s++) {
					float result = v * temp_kernel[r*S+s];
					temp_result[(3-r)*6+(4-s)] += result;
				}
			}
		break;
		case 29:
			#pragma unroll
			for ( int r = 0; r < 3; r++) {
				#pragma unroll
				for ( int s = 0; s < 3; s++) {
					float result = v * temp_kernel[r*S+s];
					temp_result[(3-r)*6+(5-s)] += result;
				}
			}
		break;
		case 30:
			#pragma unroll
			for ( int r = 0; r < 3; r++) {
				#pragma unroll
				for ( int s = 1; s < 3; s++) {
					float result = v * temp_kernel[r*S+s];
					temp_result[(3-r)*6+(6-s)] += result;
				}
			}
		break;
		case 31:
			#pragma unroll
			for ( int r = 0; r < 3; r++) {
				#pragma unroll
				for ( int s = 2; s < 3; s++) {
					float result = v * temp_kernel[r*S+s];
					temp_result[(3-r)*6+(7-s)] += result;
				}
			}
		break;
		case 32:
			#pragma unroll
			for ( int r = 1; r < 3; r++) {
				#pragma unroll
				for ( int s = 0; s < 1; s++) {
					float result = v * temp_kernel[r*S+s];
					temp_result[(4-r)*6+(0-s)] += result;
				}
			}
		break;
		case 33:
			#pragma unroll
			for ( int r = 1; r < 3; r++) {
				#pragma unroll
				for ( int s = 0; s < 2; s++) {
					float result = v * temp_kernel[r*S+s];
					temp_result[(4-r)*6+(1-s)] += result;
				}
			}
		break;
		case 34:
			#pragma unroll
			for ( int r = 1; r < 3; r++) {
				#pragma unroll
				for ( int s = 0; s < 3; s++) {
					float result = v * temp_kernel[r*S+s];
					temp_result[(4-r)*6+(2-s)] += result;
				}
			}
		break;
		case 35:
			#pragma unroll
			for ( int r = 1; r < 3; r++) {
				#pragma unroll
				for ( int s = 0; s < 3; s++) {
					float result = v * temp_kernel[r*S+s];
					temp_result[(4-r)*6+(3-s)] += result;
				}
			}
		break;
		case 36:
			#pragma unroll
			for ( int r = 1; r < 3; r++) {
				#pragma unroll
				for ( int s = 0; s < 3; s++) {
					float result = v * temp_kernel[r*S+s];
					temp_result[(4-r)*6+(4-s)] += result;
				}
			}
		break;
		case 37:
			#pragma unroll
			for ( int r = 1; r < 3; r++) {
				#pragma unroll
				for ( int s = 0; s < 3; s++) {
					float result = v * temp_kernel[r*S+s];
					temp_result[(4-r)*6+(5-s)] += result;
				}
			}
		break;
		case 38:
			#pragma unroll
			for ( int r = 1; r < 3; r++) {
				#pragma unroll
				for ( int s = 1; s < 3; s++) {
					float result = v * temp_kernel[r*S+s];
					temp_result[(4-r)*6+(6-s)] += result;
				}
			}
		break;
		case 39:
			#pragma unroll
			for ( int r = 1; r < 3; r++) {
				#pragma unroll
				for ( int s = 2; s < 3; s++) {
					float result = v * temp_kernel[r*S+s];
					temp_result[(4-r)*6+(7-s)] += result;
				}
			}
		break;
		case 40:
			#pragma unroll
			for ( int r = 2; r < 3; r++) {
				#pragma unroll
				for ( int s = 0; s < 1; s++) {
					float result = v * temp_kernel[r*S+s];
					temp_result[(5-r)*6+(0-s)] += result;
				}
			}
		break;
		case 41:
			#pragma unroll
			for ( int r = 2; r < 3; r++) {
				#pragma unroll
				for ( int s = 0; s < 2; s++) {
					float result = v * temp_kernel[r*S+s];
					temp_result[(5-r)*6+(1-s)] += result;
				}
			}
		break;
		case 42:
			#pragma unroll
			for ( int r = 2; r < 3; r++) {
				#pragma unroll
				for ( int s = 0; s < 3; s++) {
					float result = v * temp_kernel[r*S+s];
					temp_result[(5-r)*6+(2-s)] += result;
				}
			}
		break;
		case 43:
			#pragma unroll
			for ( int r = 2; r < 3; r++) {
				#pragma unroll
				for ( int s = 0; s < 3; s++) {
					float result = v * temp_kernel[r*S+s];
					temp_result[(5-r)*6+(3-s)] += result;
				}
			}
		break;
		case 44:
			#pragma unroll
			for ( int r = 2; r < 3; r++) {
				#pragma unroll
				for ( int s = 0; s < 3; s++) {
					float result = v * temp_kernel[r*S+s];
					temp_result[(5-r)*6+(4-s)] += result;
				}
			}
		break;
		case 45:
			#pragma unroll
			for ( int r = 2; r < 3; r++) {
				#pragma unroll
				for ( int s = 0; s < 3; s++) {
					float result = v * temp_kernel[r*S+s];
					temp_result[(5-r)*6+(5-s)] += result;
				}
			}
		break;
		case 46:
			#pragma unroll
			for ( int r = 2; r < 3; r++) {
				#pragma unroll
				for ( int s = 1; s < 3; s++) {
					float result = v * temp_kernel[r*S+s];
					temp_result[(5-r)*6+(6-s)] += result;
				}
			}
		break;
		case 47:
			#pragma unroll
			for ( int r = 2; r < 3; r++) {
				#pragma unroll
				for ( int s = 2; s < 3; s++) {
					float result = v * temp_kernel[r*S+s];
					temp_result[(5-r)*6+(7-s)] += result;
				}
			}
		break;

	}
}
__global__ void transform(float *matrix, float *matrix2){
    for(unsigned int global_id = blockIdx.x * blockDim.x + threadIdx.x;global_id<C*H*W;global_id+=gridDim.x * blockDim.x){
        const float v = matrix[global_id];
        unsigned int c = global_id / (H*W);
        unsigned int hw = global_id % (H*W);
        int h = (hw)/W+1;
        int w = (hw)%W+1;
        int th_start = min(h/TH,THS-1);
        int tw_start = min(w/TW,TWS-1);
        for(int tile_h_id = th_start;tile_h_id>=0;tile_h_id--){
            if((tile_h_id*TH+TH+2)<=h){
                break;
            }
            for(int tile_w_id = tw_start;tile_w_id>=0;tile_w_id--){
                if((tile_w_id*TW+TW+2)<=w){
                    break;
                }
                unsigned int tile_id = tile_h_id * TWS + tile_w_id;
                unsigned int abs_h = h - tile_h_id*TH;
                unsigned int abs_w = w - tile_w_id*TW;
                matrix2[c*THS*TWS*(TH+2)*(TW+2)+tile_id*(TH+2)*(TW+2)+abs_h*(TW+2)+abs_w] = v;
            }
        }
    }
}
__device__ void load_input_2_shared_memory(float *values,float *shared_input,unsigned int warp_id,unsigned int lane_id,
                                           unsigned int tile_id,unsigned int tile_c_id){
    for(unsigned int c_id=warp_id;c_id<TC&&tile_c_id+c_id<C;c_id+=blockDim.x/32){
        for(unsigned int id = lane_id;id<(TH+2)*(TW+2);id+=32){
            shared_input[c_id*(TH+2)*(TW+2)+id] = values[(tile_c_id+c_id)*(THS*TWS)*(TH+2)*(TW+2)+tile_id*(TH+2)*(TW+2)+id];
        }
    }
}
__global__ void conv2d(float * __restrict__ values,const float * __restrict__ kernel, float * __restrict__ outputs){
    __shared__ float input[TC*(TH+2)*(TW+2)];
    const unsigned int tile_id = blockIdx.x;
    const unsigned int tc_id = tile_id / (THS * TWS);
    const unsigned int th_id = (tile_id - tc_id * (THS*TWS))/TWS;
    const unsigned int tw_id = (tile_id - tc_id * (THS*TWS))%TWS;
    const unsigned int h_start = th_id * TH;
    const unsigned int w_start = tw_id * TW;
    const unsigned int warp_id = threadIdx.x / 32;
    const unsigned int lane_id = threadIdx.x % 32;
    float data_array[9];
    float temp_result[TH*TW] = {0.0f};
    load_input_2_shared_memory(values,input,warp_id,lane_id,tile_id - tc_id * (THS*TWS),tc_id*TC);
    __syncthreads();
    float v;
    unsigned int n = threadIdx.x;
    unsigned int c_offset = tc_id * TC;
#pragma unroll
    for(unsigned int c=0;c<TC;c++){
        load_data_2_register(data_array,c + c_offset,kernel,n);
#pragma unroll
        for(unsigned int i=0;i<(TH+2)*(TW+2);++i){
            v = input[i + c*(TH+2)*(TW+2)];
            switch_function(i,data_array,v,temp_result);
        }
    }
#pragma unroll
    for (unsigned int th = 0; th < TH; ++th) {
#pragma unroll
        for (unsigned int tw = 0; tw < TW; ++tw) {
            if (h_start + th >= H || w_start + tw >= W) {
                continue;
            }
            atomicAdd(&outputs[n*H*W+(h_start + th) * W+(w_start + tw)],temp_result[(th * TW + tw)]);
        }
    }
}
float check_diff(float *x, float *y, unsigned int size){
    float diff = 0.0f;
#pragma omp parallel for reduction(+ : diff)
    for(unsigned int i=0;i<size;++i){
        diff += abs(x[i] - y[i]);
    }
    return diff;
}
int main(void){
    float *input = new float[C*H*W];
    time_t t;
    float *matrix;
    cudaMalloc(&matrix,C*(TH+2)*(TW+2)*THS*TWS*sizeof(float));
    cudaMemset(matrix,0,C*(TH+2)*(TW+2)*THS*TWS*sizeof(float));
    srand((unsigned) time(&t));
    for(int i =0;i<C*H*W;++i){
        input[i] = rand() % 10;
    }
    float *device_input;
    cudaMalloc(&device_input,C*H*W*sizeof(float));
    cudaMemcpy(device_input,input,C*H*W*sizeof(float),cudaMemcpyHostToDevice);
    float *K = new float[C*N*9];
    for(int i=0;i<C*N*9;++i){
        K[i] = 1.0f;
    }

    ConvGemm convGemm;
    convGemm.initialize();
    ConvWinogradeNon convWinogradeNon;
    convWinogradeNon.initialize();
    ConvFFT convFFT;
    convFFT.initialize();

    float *out_cudnn;
    float *out_cudnn_host = new float[N*H*W];
    cudaEvent_t event_start;
    cudaEvent_t event_stop;
    cudaEventCreate(&event_start);
    cudaEventCreate(&event_stop);
    out_cudnn = convGemm.forward(device_input);
    cudaMemcpy(out_cudnn_host,out_cudnn,N*H*W*sizeof(float),cudaMemcpyDeviceToHost);
    out_cudnn = convFFT.forward(device_input);
    out_cudnn = convWinogradeNon.forward(device_input);

    float *device_K;
    float *device_out;
    cudaMalloc(&device_out,H*W*N*sizeof(float));
    cudaMemset(device_out,0,H*W*N*sizeof(float));
    cudaMalloc(&device_K,C*N*9*sizeof(float));
    cudaMemcpy(device_K,K,C*N*9*sizeof(float),cudaMemcpyHostToDevice);

    cudaEventRecord(event_start);
    convGemm.forward(device_input);
    cudaEventRecord(event_stop);
    cudaEventSynchronize(event_stop);
    float cudnnGemmTime;
    cudaEventElapsedTime(&cudnnGemmTime, event_start, event_stop);


    cudaEventRecord(event_start);
    convWinogradeNon.forward(device_input);
    cudaEventRecord(event_stop);
    cudaEventSynchronize(event_stop);
    float cudnnWinogradeTimeNon;
    cudaEventElapsedTime(&cudnnWinogradeTimeNon, event_start, event_stop);

    cudaEventRecord(event_start);
    convFFT.forward(device_input);
    cudaEventRecord(event_stop);
    cudaEventSynchronize(event_stop);
    float cudnnFFTTime;
    cudaEventElapsedTime(&cudnnFFTTime, event_start, event_stop);


        dim3 grid(14,4,2);

        dim3 block(2,14,4);

    cudaEventRecord(event_start);
    default_function_kernel0<<<grid, block>>>(device_input, device_K, device_out);
    cudaEventRecord(event_stop);
    cudaEventSynchronize(event_stop);
    float time_tvm;
    cudaEventElapsedTime(&time_tvm, event_start, event_stop);
    float *out_tvm = new float[N*H*W];
    cudaMemcpy(out_tvm,device_out,N*H*W*sizeof(float),cudaMemcpyDeviceToHost);
    cudaMemset(device_out, 0, sizeof(float)*N*H*W);

    unsigned int blkDim = ((N - 1)/32 + 1) * 32;
    cudaEventRecord(event_start);
    transform<<<216,1024>>>(device_input,matrix);
    conv2d<<<TCS*THS*TWS,blkDim>>>(matrix,device_K, device_out);
    cudaEventRecord(event_stop);
    cudaEventSynchronize(event_stop);
    float time_tdc;
    cudaEventElapsedTime(&time_tdc, event_start, event_stop);
    float *out_tdc = new float[N*H*W];
    cudaMemcpy(out_tdc,device_out,N*H*W*sizeof(float),cudaMemcpyDeviceToHost);

    ofstream outfile;
    char buffer[1000];
    int ret = sprintf(buffer,"%d,%d,%d,%d,%f,%f,%f,%f,%f,%f,%f,%f,%f\n",N,C,H,W,
            cudnnFFTTime,cudnnWinogradeTimeNon,cudnnGemmTime,time_tvm,time_tdc,
            cudnnFFTTime/time_tdc,cudnnWinogradeTimeNon/time_tdc,cudnnGemmTime/time_tdc,time_tvm/time_tdc);
    outfile.open("../../evaluation_outcome/2080Ti-layers-eval-oracle.csv", std::ios_base::app);
    outfile << buffer;


    float difference = check_diff(out_tvm, out_tdc, N*H*W);
    cout<<N<<","<<C<<","<<H<<","<<W<<","<<cudnnFFTTime<<","<<cudnnWinogradeTimeNon<<","<<cudnnGemmTime<<","<<
                                   time_tvm<<","<<time_tdc<<","<<cudnnFFTTime/time_tdc<<","<<cudnnWinogradeTimeNon/time_tdc<<","<<cudnnGemmTime/time_tdc<<","<<time_tvm/time_tdc<<endl;
    return 0;
}

