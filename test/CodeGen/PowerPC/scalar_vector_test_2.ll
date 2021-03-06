; RUN: llc -mcpu=pwr9 -verify-machineinstrs -ppc-vsr-nums-as-vr -ppc-asm-full-reg-names \
; RUN:    -mtriple=powerpc64le-unknown-linux-gnu < %s | FileCheck %s --check-prefix=P9LE
; RUN: llc -mcpu=pwr9 -verify-machineinstrs -ppc-vsr-nums-as-vr -ppc-asm-full-reg-names \
; RUN:    -mtriple=powerpc64-unknown-linux-gnu < %s | FileCheck %s --check-prefix=P9BE
; RUN: llc -mcpu=pwr8 -verify-machineinstrs -ppc-vsr-nums-as-vr -ppc-asm-full-reg-names \
; RUN:    -mtriple=powerpc64le-unknown-linux-gnu < %s | FileCheck %s --check-prefix=P8LE
; RUN: llc -mcpu=pwr8 -verify-machineinstrs -ppc-vsr-nums-as-vr -ppc-asm-full-reg-names \
; RUN:    -mtriple=powerpc64-unknown-linux-gnu < %s | FileCheck %s --check-prefix=P8BE

define void @test_liwzx1(<1 x float>* %A, <1 x float>* %B, <1 x float>* %C) {
; P9LE-LABEL: test_liwzx1:
; P9LE:       # %bb.0:
; P9LE-NEXT:    lfiwzx f0, 0, r3
; P9LE-NEXT:    lfiwzx f1, 0, r4
; P9LE-NEXT:    xxpermdi vs0, f0, f0, 2
; P9LE-NEXT:    xxpermdi vs1, f1, f1, 2
; P9LE-NEXT:    xvaddsp vs0, vs0, vs1
; P9LE-NEXT:    xxsldwi vs0, vs0, vs0, 3
; P9LE-NEXT:    xscvspdpn f0, vs0
; P9LE-NEXT:    stfs f0, 0(r5)
; P9LE-NEXT:    blr

; P9BE-LABEL: test_liwzx1:
; P9BE:       # %bb.0:
; P9BE-NEXT:    lfiwzx f0, 0, r3
; P9BE-NEXT:    lfiwzx f1, 0, r4
; P9BE-NEXT:    xxsldwi vs0, f0, f0, 1
; P9BE-NEXT:    xxsldwi vs1, f1, f1, 1
; P9BE-NEXT:    xvaddsp vs0, vs0, vs1
; P9BE-NEXT:    xscvspdpn f0, vs0
; P9BE-NEXT:    stfs f0, 0(r5)
; P9BE-NEXT:    blr

; P8LE-LABEL: test_liwzx1:
; P8LE:       # %bb.0:
; P8LE-NEXT:    lfiwzx f0, 0, r3
; P8LE-NEXT:    lfiwzx f1, 0, r4
; P8LE-NEXT:    xxpermdi vs0, f0, f0, 2
; P8LE-NEXT:    xxpermdi vs1, f1, f1, 2
; P8LE-NEXT:    xvaddsp vs0, vs0, vs1
; P8LE-NEXT:    xxsldwi vs0, vs0, vs0, 3
; P8LE-NEXT:    xscvspdpn f0, vs0
; P8LE-NEXT:    stfsx f0, 0, r5
; P8LE-NEXT:    blr

; P8BE-LABEL: test_liwzx1:
; P8BE:       # %bb.0:
; P8BE-NEXT:    lfiwzx f0, 0, r3
; P8BE-NEXT:    lfiwzx f1, 0, r4
; P8BE-NEXT:    xxsldwi vs0, f0, f0, 1
; P8BE-NEXT:    xxsldwi vs1, f1, f1, 1
; P8BE-NEXT:    xvaddsp vs0, vs0, vs1
; P8BE-NEXT:    xscvspdpn f0, vs0
; P8BE-NEXT:    stfsx f0, 0, r5
; P8BE-NEXT:    blr
  %a = load <1 x float>, <1 x float>* %A
  %b = load <1 x float>, <1 x float>* %B
  %X = fadd <1 x float> %a, %b
  store <1 x float> %X, <1 x float>* %C
  ret void
}

define <1 x float>* @test_liwzx2(<1 x float>* %A, <1 x float>* %B, <1 x float>* %C) {
; P9LE-LABEL: test_liwzx2:
; P9LE:       # %bb.0:
; P9LE-NEXT:    lfiwzx f0, 0, r3
; P9LE-NEXT:    lfiwzx f1, 0, r4
; P9LE-NEXT:    mr r3, r5
; P9LE-NEXT:    xxpermdi vs0, f0, f0, 2
; P9LE-NEXT:    xxpermdi vs1, f1, f1, 2
; P9LE-NEXT:    xvsubsp vs0, vs0, vs1
; P9LE-NEXT:    xxsldwi vs0, vs0, vs0, 3
; P9LE-NEXT:    xscvspdpn f0, vs0
; P9LE-NEXT:    stfs f0, 0(r5)
; P9LE-NEXT:    blr

; P9BE-LABEL: test_liwzx2:
; P9BE:       # %bb.0:
; P9BE-NEXT:    lfiwzx f0, 0, r3
; P9BE-NEXT:    lfiwzx f1, 0, r4
; P9BE-NEXT:    mr r3, r5
; P9BE-NEXT:    xxsldwi vs0, f0, f0, 1
; P9BE-NEXT:    xxsldwi vs1, f1, f1, 1
; P9BE-NEXT:    xvsubsp vs0, vs0, vs1
; P9BE-NEXT:    xscvspdpn f0, vs0
; P9BE-NEXT:    stfs f0, 0(r5)
; P9BE-NEXT:    blr

; P8LE-LABEL: test_liwzx2:
; P8LE:       # %bb.0:
; P8LE-NEXT:    lfiwzx f0, 0, r3
; P8LE-NEXT:    lfiwzx f1, 0, r4
; P8LE-NEXT:    mr r3, r5
; P8LE-NEXT:    xxpermdi vs0, f0, f0, 2
; P8LE-NEXT:    xxpermdi vs1, f1, f1, 2
; P8LE-NEXT:    xvsubsp vs0, vs0, vs1
; P8LE-NEXT:    xxsldwi vs0, vs0, vs0, 3
; P8LE-NEXT:    xscvspdpn f0, vs0
; P8LE-NEXT:    stfsx f0, 0, r5
; P8LE-NEXT:    blr

; P8BE-LABEL: test_liwzx2:
; P8BE:       # %bb.0:
; P8BE-NEXT:    lfiwzx f0, 0, r3
; P8BE-NEXT:    lfiwzx f1, 0, r4
; P8BE-NEXT:    mr r3, r5
; P8BE-NEXT:    xxsldwi vs0, f0, f0, 1
; P8BE-NEXT:    xxsldwi vs1, f1, f1, 1
; P8BE-NEXT:    xvsubsp vs0, vs0, vs1
; P8BE-NEXT:    xscvspdpn f0, vs0
; P8BE-NEXT:    stfsx f0, 0, r5
; P8BE-NEXT:    blr
  %a = load <1 x float>, <1 x float>* %A
  %b = load <1 x float>, <1 x float>* %B
  %X = fsub <1 x float> %a, %b
  store <1 x float> %X, <1 x float>* %C
  ret <1 x float>* %C
}
