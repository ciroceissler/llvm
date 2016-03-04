; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=x86_64-unknown -mattr=+avx | FileCheck %s --check-prefix=ALL --check-prefix=AVX --check-prefix=AVX1
; RUN: llc < %s -mtriple=x86_64-unknown -mattr=+avx2 | FileCheck %s --check-prefix=ALL --check-prefix=AVX --check-prefix=AVX2
; RUN: llc < %s -mtriple=x86_64-unknown -mattr=+avx512f | FileCheck %s --check-prefix=ALL --check-prefix=AVX --check-prefix=AVX512F
;
; Combine tests involving AVX target shuffles

declare <4 x float> @llvm.x86.avx.vpermil.ps(<4 x float>, i8)
declare <8 x float> @llvm.x86.avx.vpermil.ps.256(<8 x float>, i8)
declare <2 x double> @llvm.x86.avx.vpermil.pd(<2 x double>, i8)
declare <4 x double> @llvm.x86.avx.vpermil.pd.256(<4 x double>, i8)

declare <4 x float> @llvm.x86.avx.vpermilvar.ps(<4 x float>, <4 x i32>)
declare <8 x float> @llvm.x86.avx.vpermilvar.ps.256(<8 x float>, <8 x i32>)
declare <2 x double> @llvm.x86.avx.vpermilvar.pd(<2 x double>, <2 x i64>)
declare <4 x double> @llvm.x86.avx.vpermilvar.pd.256(<4 x double>, <4 x i64>)

declare <8 x i32> @llvm.x86.avx.vperm2f128.si.256(<8 x i32>, <8 x i32>, i8)
declare <8 x float> @llvm.x86.avx.vperm2f128.ps.256(<8 x float>, <8 x float>, i8)
declare <4 x double> @llvm.x86.avx.vperm2f128.pd.256(<4 x double>, <4 x double>, i8)

define <4 x float> @combine_vpermilvar_4f32(<4 x float> %a0) {
; ALL-LABEL: combine_vpermilvar_4f32:
; ALL:       # BB#0:
; ALL-NEXT:    vmovaps {{.*#+}} xmm1 = [3,2,1,0]
; ALL-NEXT:    vpermilps %xmm1, %xmm0, %xmm0
; ALL-NEXT:    vpermilps %xmm1, %xmm0, %xmm0
; ALL-NEXT:    retq
  %1 = tail call <4 x float> @llvm.x86.avx.vpermilvar.ps(<4 x float> %a0, <4 x i32> <i32 3, i32 2, i32 1, i32 0>)
  %2 = tail call <4 x float> @llvm.x86.avx.vpermilvar.ps(<4 x float>  %1, <4 x i32> <i32 3, i32 2, i32 1, i32 0>)
  ret <4 x float> %2
}

define <8 x float> @combine_vpermilvar_8f32(<8 x float> %a0) {
; ALL-LABEL: combine_vpermilvar_8f32:
; ALL:       # BB#0:
; ALL-NEXT:    vmovaps {{.*#+}} ymm1 = [3,2,1,0,2,3,0,1]
; ALL-NEXT:    vpermilps %ymm1, %ymm0, %ymm0
; ALL-NEXT:    vpermilps %ymm1, %ymm0, %ymm0
; ALL-NEXT:    retq
  %1 = tail call <8 x float> @llvm.x86.avx.vpermilvar.ps.256(<8 x float> %a0, <8 x i32> <i32 3, i32 2, i32 1, i32 0, i32 2, i32 3, i32 0, i32 1>)
  %2 = tail call <8 x float> @llvm.x86.avx.vpermilvar.ps.256(<8 x float>  %1, <8 x i32> <i32 3, i32 2, i32 1, i32 0, i32 2, i32 3, i32 0, i32 1>)
  ret <8 x float> %2
}

define <2 x double> @combine_vpermilvar_2f64(<2 x double> %a0) {
; ALL-LABEL: combine_vpermilvar_2f64:
; ALL:       # BB#0:
; ALL-NEXT:    movl $2, %eax
; ALL-NEXT:    vmovq %rax, %xmm1
; ALL-NEXT:    vpermilpd %xmm1, %xmm0, %xmm0
; ALL-NEXT:    vpermilpd %xmm1, %xmm0, %xmm0
; ALL-NEXT:    retq
  %1 = tail call <2 x double> @llvm.x86.avx.vpermilvar.pd(<2 x double> %a0, <2 x i64> <i64 2, i64 0>)
  %2 = tail call <2 x double> @llvm.x86.avx.vpermilvar.pd(<2 x double>  %1, <2 x i64> <i64 2, i64 0>)
  ret <2 x double> %2
}

define <4 x double> @combine_vpermilvar_4f64(<4 x double> %a0) {
; ALL-LABEL: combine_vpermilvar_4f64:
; ALL:       # BB#0:
; ALL-NEXT:    vmovapd {{.*#+}} ymm1 = [2,0,2,0]
; ALL-NEXT:    vpermilpd %ymm1, %ymm0, %ymm0
; ALL-NEXT:    vpermilpd %ymm1, %ymm0, %ymm0
; ALL-NEXT:    retq
  %1 = tail call <4 x double> @llvm.x86.avx.vpermilvar.pd.256(<4 x double> %a0, <4 x i64> <i64 2, i64 0, i64 2, i64 0>)
  %2 = tail call <4 x double> @llvm.x86.avx.vpermilvar.pd.256(<4 x double>  %1, <4 x i64> <i64 2, i64 0, i64 2, i64 0>)
  ret <4 x double> %2
}
